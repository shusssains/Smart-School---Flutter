import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ExamTimetable extends StatefulWidget {
  @override
  _ExamTimetableState createState() => _ExamTimetableState();
}
class Timetable {
  final String examDate;
  final String duration;
  final String subject;
  Timetable({

    required this.examDate,
    required this.duration,
    required this.subject,

  });
}
class _ExamTimetableState extends State<ExamTimetable> {
  List<Timetable> timetableList = [];
  bool isLoading = false;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('https://test.smartschoolplus.co.in/webservice/sspmobileservice.asmx/GetCBSEExamAllTimeTable?SchoolCode=TESTLAKE&ClassId=1&IsActivity=0'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> examTimetable = jsonData['CBSEExamTimeTable'];
        List<dynamic> subjects = examTimetable[0]['Subjects'];
        setState(() {
          timetableList = subjects.map((item) {
            return Timetable(
              examDate: item['ExamDate'],
              duration: item['Duration'],
              subject: item['Subject'],
            );
          }).toList();
          errorMessage = ''; // Reset error message
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch data. Please check your internet connection and try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1)); // Adding a delay of 1 second
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EXAM TIMETABLE',
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
      backgroundColor: const Color(0xFF00008B),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Customize loading indicator color
        ),
      )
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
      )
          : timetableList.isEmpty
          ? const Center(
        child: Text(
          'No Timetable found',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: timetableList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = timetableList[index];
          return Card(
            elevation: 8,
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timetableInfo('assets/images/date.png', 'Exam Date:     ${item.examDate}'),
                  const SizedBox(height: 15.0),
                  timetableInfo('assets/images/time.png', 'Duration:        ${item.duration}'),
                  const SizedBox(height: 15.0),
                  timetableInfo('assets/images/subject.png', 'Subject:          ${item.subject}'),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget timetableInfo(String imagePath, String text) {
    return Container(
      color: const Color(0xFF00008B),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Row(
        children: [
          const SizedBox(width: 5.0),
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(imagePath, width: 30, height: 30),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
