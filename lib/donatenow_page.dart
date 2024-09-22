import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'payment_page.dart'; // Import the payment page

class MedicalPage extends StatefulWidget {
  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/images/m5.jpg',
    'assets/images/m3.jpg',
    'assets/images/m9.jpg',
    'assets/images/m10.jpg',
    'assets/images/m11.jpg',
  ];

  double _donationAmount = 10.0;
  TextEditingController _donationController = TextEditingController();
  Color _buttonColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _donationController.text = '$_donationAmount';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate for the Needy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: _imageList.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _imageList.map((url) {
                int index = _imageList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  Text(
                    'Your Help Can Save Lives!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '"Giving is not just about making a donation. It is about making a difference."',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Enter Donation Amount'),
                      content: TextFormField(
                        controller: _donationController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.monetization_on),
                          labelText: 'Donation Amount',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _donationAmount =
                                  double.parse(_donationController.text);
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹$_donationAmount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.blue),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _donationAmount = 10.0;
                    });
                  },
                  child: Text('₹10'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _donationAmount = 100.0;
                    });
                  },
                  child: Text('₹100'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _donationAmount = 50.0;
                    });
                  },
                  child: Text('₹50'),
                ),
              ],
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                        donationAmount:
                            _donationAmount), // Pass the donation amount to PaymentPage
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  'Donate',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
