import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CircularCard(),
  ));
}

class CircularCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00008B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Implement your refresh functionality here
            },
          ),
        ],
        title: Text(
          'CIRCULAR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF00008B),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            10, // Generate 10 cards, you can adjust this number as needed
                (index) => CircularItemCard(
              date: 'Date: March ${index + 1}, 2024',
              circularText: 'Dear parent, please find, attach the final \n circular with the relevent information',
            ),
          ),
        ),
      ),
    );
  }
}

class CircularItemCard extends StatelessWidget {
  final String date;
  final String circularText;

  const CircularItemCard({
    Key? key,
    required this.date,
    required this.circularText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.date_range, size: 24), // Using default app icon for date
                SizedBox(width: 10),
                Text(date),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.info, size: 24), // Using default app icon for circular text
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    circularText,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Image.asset('assets/images/view.png', width: 24, height: 24),
                  onPressed: () {
                    // View action
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/images/download.png', width: 24, height: 24),
                  onPressed: () {
                    // Download action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
