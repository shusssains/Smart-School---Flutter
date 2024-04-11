import 'package:flutter/material.dart';

class PrincipalAppointmentMessage extends StatefulWidget {
  @override
  _PrincipalAppointmentMessageState createState() =>
      _PrincipalAppointmentMessageState();
}

class _PrincipalAppointmentMessageState
    extends State<PrincipalAppointmentMessage> {
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
          'PRINCIPAL APPOINTMENT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF00008B),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'No principal appointment is available',
          style: TextStyle(fontSize: 20,
          color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
