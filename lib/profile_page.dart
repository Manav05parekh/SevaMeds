import 'package:flutter/material.dart';
import 'signup.dart'; // Import the SignUp page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// Custom clipper for curved bottom shape
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.height, 0); // Start at the bottom-left corner
    path.lineTo(size.width, size.height); // Draw a line to the bottom-right corner
    path.lineTo(size.width, size.height / 2); // Draw a line to the top-right corner
    path.quadraticBezierTo(
        size.width / 2, size.height / 2.36, 0, size.height / 2); // Draw a quadratic Bézier curve to create a curve
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Inside the MyProfilePage widget
class MyProfilePage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  // Constructor with userData argument
  const MyProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
Widget build(BuildContext context) {
  if (userData == null) {
    // User data not available, display default content
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background image with curved bottom
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Image.asset(
              'assets/images/profile_back.png',
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: 500,
            ),
          ),
          // Profile content
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 75,
                  // Display default image or placeholder
                  backgroundImage: AssetImage('assets/images/default_profile_photo.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Name not found',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 6, 6),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email not found',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 71, 69, 69),
                  ),
                ),
                // Display default text for blood and medicine donations
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite, color: Colors.red),
                          Text(' Blood Donations: 0'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0), // Add right padding here
                            child: Icon(Icons.medical_services, color: Colors.green),
                          ),
                          const SizedBox(width: 8), // Adding some space between the icon and the text
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0), // Add left padding here
                              child: Text(
                                ' Medicine Donation: No medicine donations',
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Display default text for date of medicine donation
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blue),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            ' Date of Medicine Donation: Date not available',
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center, // Adjust alignment as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Display default text for address
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Colors.orange),
                      Text(' Address: Address not available'),
                    ],
                  ),
                ),
                // Register / Sign In Button
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text('Register / Sign In'),
                  ),
                ),
                // Sign Out Button (disabled as user is not signed in)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: null,
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  } else {
      // User data available, proceed to display profile
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profile'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            // Background image with curved bottom
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Image.asset(
                'assets/images/profile_back.png',
                fit: BoxFit.fitHeight,
                width: double.infinity,
                height: 500,
              ),
            ),
            // Profile content
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage(userData!['profilePhoto'] ?? ''),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userData!['name'] ?? 'Name not available',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 6, 6, 6),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData!['email'] ?? 'Email not available',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 71, 69, 69),
                    ),
                  ),
                  // Display user's blood and medicine donations
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite, color: Colors.red),
                            Text(' Blood Donations: ${userData!['bloodDonation'] ?? 0}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0), // Add right padding here
                              child: Icon(Icons.medical_services, color: Colors.green),
                            ),
                            const SizedBox(width: 8), // Adding some space between the icon and the text
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0), // Add left padding here
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: userData!['medicineDonation'] != null && userData!['medicineDonation']['donation1'] != null
                                      ? (userData!['medicineDonation']['donation1'] as List<dynamic>).map((donation) {
                                          return Text(
                                            ' Medicine Donation: $donation',
                                            overflow: TextOverflow.visible, // Or any other overflow behavior you prefer
                                          );
                                        }).toList()
                                      : [Text('No medicine donations')],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Display date of medicine donation
                  if (userData!['date_medicine_donate'] != null && userData!['date_medicine_donate'] is List)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.blue),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                ' Date of Medicine Donation: ${_formatDate(userData!['date_medicine_donate'])}',
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center, // Adjust alignment as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Display address
                  if (userData!['address'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on, color: Colors.orange),
                          Text(' Address: ${userData!['address']}'),
                        ],
                      ),
                    ),
                  // Register / Sign In Button
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text('Register / Sign In'),
                    ),
                  ),
                  // Sign Out Button
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyProfilePage(userData: null)),
                        );
                      },
                      child: const Text('Sign Out'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  String _formatDate(List<dynamic> dateList) {
    if (dateList.isNotEmpty && dateList[0] is Timestamp) {
      final Timestamp timestamp = dateList[0];
      final dateTime = timestamp.toDate();
      final formattedDate = DateFormat.yMMMd().format(dateTime);
      return formattedDate;
    }
    return 'Date not available';
  }
}
