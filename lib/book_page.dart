import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Implement cart functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '"The more that you read, the more things you will know. The more that you learn, the more places you\'ll go."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue[700],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Implement action for "Donate Books" button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Donate Books',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/maindonate.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Implement action for "What you Do?" button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'What you Do?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wyd1.png',
              'Fill up the Book Donation Form',
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wyd2.png',
              'Get the Books ready and packed',
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wyd3.png',
              'Take the printouts (Tracking Slip)',
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wyd4.png',
              'Handover Books to the Pick Up Partner at Doorstep',
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Implement action for "What We Do?" button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'What We Do?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wwd2.png',
              'Assured Books are listed',
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wwd3.png',
              'Storing and Maintaing the Books quality',
            ),
            SizedBox(height: 20),
            _buildImageWithText(
              context,
              'assets/images/wwd4.png',
              'Shipping Books to the Needy',
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithText(
      BuildContext context, String imagePath, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
