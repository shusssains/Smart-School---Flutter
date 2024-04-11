import 'package:flutter/material.dart';

class Youtube extends StatefulWidget {
  const Youtube({Key? key}) : super(key: key);

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
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
          'YOUTUBE CHANNEL',
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
          'Currently YouTube channel is not available',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          color: Colors.white,),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Youtube(),
  ));
}
