import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
          'PAYMENT DETAILS',
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPaymentCard('Term 1'),
                  _buildPaymentCard('Term 2'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(String term) {
    return Card(
      elevation: 4, // Adjust elevation as per your requirement
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xFF00008B), // Set background color to indigo
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  term,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          _buildRow('Amount: \$300', 'assets/images/amount.png'),
          _buildRow('Paid by: Online Payment', 'assets/images/paid.png'),
          _buildRow('Date: 14-03-2024', 'assets/images/date.png'),
          _buildRow('Download: View and download the receipt', 'assets/images/download.png'),
          _buildRow('Yet to Pay: \$200', 'assets/images/yettopay.png'),
          _buildRow('Last Date: 31-03-2024', 'assets/images/lastdate.png'),
          _buildRow('Discount: 10%', 'assets/images/discount.png'),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
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
          SizedBox(width: 16.0), // Initial space after the first icon
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
    home: Payment(),
  ));
}
