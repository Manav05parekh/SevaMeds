import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


void main() {
  runApp(MaterialApp(
    title: 'Donate Medicine Page',
    home: DonateMedicinePage(),
  ));
}

class DonateMedicinePage extends StatefulWidget {
  @override
  _DonateMedicinePageState createState() => _DonateMedicinePageState();
}

class _DonateMedicinePageState extends State<DonateMedicinePage> with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  List<Medicine> _medicines = []; // List to store medicines

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Automatically add details for the first medicine
    _addNewMedicine();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Medicine'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < _medicines.length; i++)
                    _buildMedicineDetailsWidget(_medicines[i], i),
                  ElevatedButton(
                    onPressed: _addNewMedicine,
                    child: const Text(
                      'Add More Medicine',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitDonation,
                    child: const Text(
                      'Submit Donation',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineDetailsWidget(Medicine medicine, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        TextFormField(
          controller: medicine.quantityController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.shopping_bag),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: medicine.expiryDateController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Expiry Date',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.date_range),
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectExpiryDate(context, index),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await _openCamera(context, index);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              if (medicine.photoUploaded) // Display check icon if photo is uploaded
                const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 30,
                ),
            ],
          ),
        ),
      ],
    );
  }

void _submitDonation() async {
  // Check if user is authenticated
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // User not authenticated, handle accordingly
    print('User not authenticated.');
    return;
  }

  // Get the user's document reference in Firestore
  DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc('Jayesh');

  // Get the number of donations made by this user
  QuerySnapshot donationSnapshot = await userDocRef.collection('donations').get();
  int numberOfDonations = donationSnapshot.docs.length;

  // Generate the next donation ID
  String donationId = 'donation${numberOfDonations + 1}';

  // Get the medicine names from the current list of medicines
  List<String> medicineNames = _medicines.map((medicine) => medicine.medicineName).toList();

  try {
    // Update the user document to append the medicine names to the array
    await userDocRef.update({
      'medicineDonation.$donationId': FieldValue.arrayUnion(medicineNames),
    });

    print('Medicine names added to user document in Firestore under donation ID: $donationId');
  } catch (e) {
    print('Error adding medicine names to Firestore: $e');
  }

  // Iterate through each medicine and save its details to the user's document
  for (int i = 0; i < _medicines.length; i++) {
    Medicine medicine = _medicines[i];
    try {
      // Add medicine details under /users/Jayesh/donations/{donationId}/medicine/{medicineId}
      DocumentReference medicineDocRef = await userDocRef.collection('donations').doc(donationId)
        .collection('medicine').add({
          'name': medicine.medicineName,
          'quantity': medicine.quantityController.text,
          'expiryDate': medicine.expiryDateController.text,
          'photoUploaded': medicine.photoUploaded,
      });
// Show self ship details in an alert dialog
  _showSelfShipDialog();

  // Send email to jayeshpatel@gmail.com
  await _sendEmail('shubhamgala13@gmail.com');
      print('Medicine details added to user document in Firestore under document ID: ${medicineDocRef.id}');
    } catch (e) {
      print('Error adding medicine details to Firestore: $e');
    }
  }
}
void _showSelfShipDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Self Ship'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address:'),
            Text('99/101, 3RD floor, shri K.V.O. Deravasi Mahajanwadi,Chinchubunder,Mumbai- 400009'),
            SizedBox(height: 20),
            Text('Please courier your donation to the above address'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

Future<void> _sendEmail(String recipientEmail) async {
  // Create a SMTP server object with your credentials
  final smtpServer = gmail('manav05parekh@gmail.com', 'blksrdvozyznaxcp'); // Replace with your Gmail credentials

  // Create our email message
  final message = Message()
    ..from = Address('manav05parekh@gmail.com', 'Seva Meds') // Replace with your name and NGO name
    ..recipients.add(recipientEmail) // Recipient email
    ..subject = 'Thank You for Your Medicine Donation'
    ..html = '''
      <html>
      <body style="font-family: Arial, sans-serif;">
        <img src="https://scontent.fpnq1-1.fna.fbcdn.net/v/t39.30808-6/326525720_1139591963370897_595720975088830646_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_ohc=PNL0QjXIRowAb7IB-Bm&_nc_ht=scontent.fpnq1-1.fna&oh=00_AfBQcqBO6eyQqOD9W2mF6Uu4ljZ-xAy4joZOH5B0aXXwzQ&oe=66291CFA" alt="Tarun Mitra Mandal Logo" style="width: 100px; height: 100px;">
        <h2>Dear Donor,</h2>
        <p>Thank you for your generous donation of medicines. Your support will make a significant difference in the lives of those in need.</p>
        
        <p>We, at Tarun Mitra Mandal, greatly appreciate your contribution towards our cause. With your help, we can continue to serve the community and provide essential medical aid to those who cannot afford it.</p>
        
        <p>Below are the details of the medicines you donated:</p>
        <p>${_getMedicineDetails()}</p>
        
        <p>For any queries or further information, please feel free to contact us.</p>
        
        <p>Warm Regards,<br>
        Tarun Mitra Mandal</p>
        
        <p><em>Note: This is an automated email. Please do not reply.</em></p>
      </body>
      </html>
    '''; // Email body

  try {
    // Send the email
    await send(message, smtpServer);

    // If the send method completes without throwing an error, it means the email was sent successfully
    print('Email sent successfully');
  } catch (e) {
    print('Error sending email: $e');
    throw 'Could not send email';
  }
}




String _getMedicineDetails() {
  StringBuffer body = StringBuffer();

  for (int i = 0; i < _medicines.length; i++) {
    Medicine medicine = _medicines[i];
    body.writeln('Medicine ${i + 1}:');
    body.writeln('Name: ${medicine.medicineName}');
    body.writeln('Quantity: ${medicine.quantityController.text}');
    body.writeln('Expiry Date: ${medicine.expiryDateController.text}');
    body.writeln('---------------------');
  }

  return body.toString();
}



  Future<void> _selectExpiryDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _medicines[index].expiryDateController.text = picked.toString();
      });
    }
  }

  Future<String> _uploadImageAndGetMedicineName(BuildContext context, String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://actually-full-ant.ngrok-free.app/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Response data: $responseData'); // Print response content

        if (responseData.isNotEmpty) {
          // Set medicine name to the last medicine instance
          _medicines[_medicines.length - 1].medicineName = responseData;

          // Show dialog with medicine name
          _showMedicineNameDialog(context, responseData);

          setState(() {
            _medicines[_medicines.length - 1].photoUploaded = true; // Set flag for the last medicine
          });
          return responseData; // Return the detected medicine name
        } else {
          print('Failed to detect objects.');
          _showErrorDialog(context);
          return ''; // Return empty string in case of failure
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        _showErrorDialog(context);
        return ''; // Return empty string in case of failure
      }
    } catch (e) {
      print('Error uploading image: $e');
      _showErrorDialog(context);
      return ''; // Return empty string in case of failure
    }
  }

  Future<void> _openCamera(BuildContext context, int index) async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      // Corrected usage
      await _uploadImageAndGetMedicineName(context, pickedImage.path);
      // Pass image path and index
    }
  }

  void _showMedicineNameDialog(BuildContext context, String medicineName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detected Medicine'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Detected Medicine: $medicineName'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Photo Uploaded',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to get medicine name.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _addNewMedicine() {
    setState(() {
      _medicines.add(Medicine());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Medicine {
  TextEditingController quantityController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  bool photoUploaded = false; // Flag to track if photo is uploaded
  String medicineName = ''; // Variable to store medicine name
}
