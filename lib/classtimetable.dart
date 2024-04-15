import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassTimeTable extends StatefulWidget {
  @override
  _ClassTimeTableState createState() => _ClassTimeTableState();
}

class _ClassTimeTableState extends State<ClassTimeTable> {
  List<Map<String, dynamic>> _weeklySubjects = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromApi();
  }

  Future<void> _fetchDataFromApi() async {
    final apiUrl = 'https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetTimeTable?SchoolCode=TESTLAKE&ClassId=1';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weeklySubjects = [
            ...List.from(data['TTLPERIOD']),
            ...List.from(data['TTLPERIOD']),
            ...List.from(data['TTLPERIOD']),
            ...List.from(data['TTLPERIOD']),
            ...List.from(data['TTLPERIOD']),
            ...List.from(data['TTLPERIOD']),
          ];
        });
      } else {
        print('Error: Unable to fetch data from API.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CLASS TIMETABLE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00008B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              //refreshData();
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: _weeklySubjects.length,
        itemBuilder: (context, index) {
          final subject = _weeklySubjects[index]['Class'];
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF36454F),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  '$subject',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF00008B), // Blue color for the footer
        height: 50, // Adjust the height as needed
      ),
    );
  }
}
