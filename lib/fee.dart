import 'package:flutter/material.dart';

class Fee extends StatefulWidget {
  const Fee({Key? key}) : super(key: key);

  @override
  State<Fee> createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  String? selectedYear; // Default selected year

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
        title: const Text(
          'FEE RECEIPT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF00008B),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo), // Set border color to indigo
              borderRadius: BorderRadius.circular(4.0), // Optional: Set border radius
            ),
            child: DropdownButton<String>(
              value: selectedYear,
              hint: Text('Select the year of payment status',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),), // Placeholder text
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
              items: <String>['2022', '2023']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTermCard('Term 1'),
                  _buildTermCard('Term 2'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermCard(String term) {
    return Card(
      elevation: 4, // Adjust elevation as per your requirement
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color:Color(0xFF00008B),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '${selectedYear ?? 'SELECTED YEAR'} - $term',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0, width: 12),
          _buildRow('Amount: 300', 'assets/images/amount.png'),
          // SizedBox(height: 4, ),
          _buildRow('Paid by: Online Payment', 'assets/images/paid.png'),
          // SizedBox(height: 4, ),
          _buildRow('Date: 14-03-2024', 'assets/images/date.png'),
          // SizedBox(height: 4, ),
          _buildRow('Download: View and download the receipt', 'assets/images/download.png'),
          // SizedBox(height: 4, ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0), // Adjust padding for more space around the icon
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF00008B), // Indigo color for the circle
            ),
            child: Image.asset(
              iconPath,
              width: 24.0,
              height: 24.0,
              color: null, // Preserve original colors by setting color to null
            ),
          ),
          SizedBox(width: 16.0), // Additional space between icon and text
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), // Adjust font size as needed
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Fee(),
  ));
}
