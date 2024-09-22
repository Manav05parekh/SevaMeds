import 'package:flutter/material.dart';

class CampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campaign Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCampaignItem(
              imagePath: 'assets/images/campaign1.png',
              title: 'Campaign 1',
              location: 'Location 1',
              date: 'Date 1',
            ),
            _buildCampaignItem(
              imagePath: 'assets/images/c1.jpg',
              title: 'Campaign 2',
              location: 'Location 2',
              date: 'Date 2',
            ),
            _buildCampaignItem(
              imagePath: 'assets/images/c2.jpg',
              title: 'Campaign 3',
              location: 'Location 3',
              date: 'Date 3',
            ),
            _buildCampaignItem(
              imagePath: 'assets/images/c3.jpg',
              title: 'Campaign 4',
              location: 'Location 4',
              date: 'Date 4',
            ),
            _buildCampaignItem(
              imagePath: 'assets/images/c4.jpg',
              title: 'Campaign 5',
              location: 'Location 5',
              date: 'Date 5',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignItem({
    required String imagePath,
    required String title,
    required String location,
    required String date,
  }) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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
