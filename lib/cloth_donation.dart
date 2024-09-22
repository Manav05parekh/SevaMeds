import 'package:flutter/material.dart';

class ClothDonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothing Donation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/clothdonation.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
            height: 300, // Adjust height as needed
            width: MediaQuery.of(context)
                .size
                .width, // Use full width of the screen
          ),
          SizedBox(height: 16), // Add some space below the image
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to cloth details page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClothDetailsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  'Cloth Details',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16), // Add some space below the button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cloth For : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(
                      child: Text('Kids'),
                      value: 'Kids',
                    ),
                    DropdownMenuItem(
                      child: Text('Teenagers'),
                      value: 'Teenagers',
                    ),
                    DropdownMenuItem(
                      child: Text('Adult'),
                      value: 'Adult',
                    ),
                    DropdownMenuItem(
                      child: Text('Senior Citizens'),
                      value: 'Senior Citizens',
                    ),
                  ],
                  onChanged: (value) {
                    // Handle dropdown value change
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Gender : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(
                      child: Text('Male'),
                      value: 'Male',
                    ),
                    DropdownMenuItem(
                      child: Text('Female'),
                      value: 'Female',
                    ),
                    DropdownMenuItem(
                      child: Text('Other'),
                      value: 'Other',
                    ),
                  ],
                  onChanged: (value) {
                    // Handle dropdown value change
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Cloth Type : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(
                      child: Text('Shirt'),
                      value: 'Shirt',
                    ),
                    DropdownMenuItem(
                      child: Text('Trousers'),
                      value: 'Trousers',
                    ),
                    DropdownMenuItem(
                      child: Text('Dress'),
                      value: 'Dress',
                    ),
                    DropdownMenuItem(
                      child: Text('Skirt'),
                      value: 'Skirt',
                    ),
                    DropdownMenuItem(
                      child: Text('Jacket'),
                      value: 'Jacket',
                    ),
                    DropdownMenuItem(
                      child: Text('Other'),
                      value: 'Other',
                    ),
                  ],
                  onChanged: (value) {
                    // Handle dropdown value change
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit details
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        'Submit Details',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

class ClothDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloth Details'),
      ),
      body: Center(
        child: Text(
          'This is the Cloth Details Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
