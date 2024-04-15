import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> apiData = [];
  bool isLoading = false;

  Future<void> fetchData() async {
    try {
      final response1 = await http.get(Uri.parse(
          'https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetAttendance?SchoolCode=TESTLAKE&StudentId=3414'));
      final response2 = await http.get(Uri.parse(
          'https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetStudentMonthWiseAttendance?SchoolCode=TESTLAKE&StudentId=3414&Month=05&MonthStartDate=01/05/2023&MonthEndDate=31/05/2023'));

      final data1 = json.decode(response1.body);
      final data2 = json.decode(response2.body);

      setState(() {
        apiData = [data1 ?? {}, data2 ?? {}]; // Null check added
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1)); // Adding a delay of 2 seconds
    fetchData();
  }
  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget initializes
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ATTENDANCE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0, // Increase the font size
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
              refreshData();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: apiData.length,
        itemBuilder: (context, index) {
          final workingDayDetails = apiData[index]['WorkingDayDetails']?[0] ?? {}; // Null check added
          return Card(
            elevation: 13,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFF00008B),
                    child: Text(
                      'Total Working Days: ${workingDayDetails["TotalWorkingDays"] ?? ''}', // Null check added
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Student Absent Days: ${workingDayDetails["StudentAbsentDays"] ?? ''}', // Null check added
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Student Working Days: ${workingDayDetails["StudentWorkingDays"] ?? ''}', // Null check added
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
