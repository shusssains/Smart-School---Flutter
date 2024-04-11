import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NewPolicy(),
  ));
}


class NewPolicy extends StatefulWidget {
  @override
  _NewPolicyState createState() => _NewPolicyState();
}

class _NewPolicyState extends State<NewPolicy> {
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
          'NEW POLICY',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF00008B),
      body: Center(
        child: Text(
          'No available new policy',
          style: TextStyle(fontSize: 24.0,
          color: Colors.white),
        ),
      ),
    );
  }
}