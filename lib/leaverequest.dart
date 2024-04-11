import 'package:flutter/material.dart';

class leaverequest extends StatefulWidget {
  const leaverequest({Key? key}) : super(key: key);

  @override
  State<leaverequest> createState() => _leaverequestState();
}

class _leaverequestState extends State<leaverequest> {
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
          'LEAVE REQUEST',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
       backgroundColor: Color(0xFF00008B),
      body: Center(
        child: Text(
          'No Leave Request',
          style: TextStyle(fontSize: 24.0,
            fontWeight: FontWeight.bold,
          color: Colors.white),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: leaverequest(),
  ));
}
