import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExamSyllabus extends StatefulWidget {
  @override
  _ExamSyllabusState createState() => _ExamSyllabusState();
}

class Exam {
  final String examId;
  final String examName;
  final String isActive;

  Exam({required this.examId, required this.examName, required this.isActive});

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      examId: json['Exam Id'],
      examName: json['Exam Name'],
      isActive: json['Is Active'],
    );
  }
}

class Syllabus {
  final int classId;
  final String className;
  final int subjectId;
  final String subject;
  final String subjectCode;
  final String exam;
  final String groupName;
  final String activity;
  final String portionDate;
  final String portion;
  final String fileName;
  final String photoPath;

  Syllabus({
    required this.classId,
    required this.className,
    required this.subjectId,
    required this.subject,
    required this.subjectCode,
    required this.exam,
    required this.groupName,
    required this.activity,
    required this.portionDate,
    required this.portion,
    required this.fileName,
    required this.photoPath,
  });

  factory Syllabus.fromJson(Map<String, dynamic> json) {
    return Syllabus(
      classId: json['CLASSID'],
      className: json['Class'],
      subjectId: json['SUBJECTID'],
      subject: json['Subject'],
      subjectCode: json['SUBJECTCODE'],
      exam: json['EXAM'],
      groupName: json['GROUPNAME'],
      activity: json['ACTIVITY'],
      portionDate: json['PORTIONDATE'],
      portion: json['PORTION'],
      fileName: json['FILENAME'],
      photoPath: json['PHOTOPATH'],
    );
  }
}

class _ExamSyllabusState extends State<ExamSyllabus> {
  String selectedExam = '';
  List<Exam> exams = [];
  List<Syllabus> syllabusList = [];

  @override
  void initState() {
    super.initState();
    fetchExams();
    fetchSyllabus();
  }

  Future<void> fetchExams() async {
    final response = await http.get(Uri.parse(
        'https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetAllExamName?SchoolCode=TESTLAKE&Classid=1'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Status Code'] == '01') {
        setState(() {
          exams = (data['Exam Name'] as List)
              .map((json) => Exam.fromJson(json))
              .toList();
          selectedExam = exams.isNotEmpty ? exams[0].examName : '';
        });
      }
    }
  }

  Future<void> fetchSyllabus() async {
    final response = await http.get(Uri.parse(
        'https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetExamSyllabus?SchoolCode=TESTLAKE&Classid=1&StudentId=3414&Groupid=15'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Status Code'] == '01') {
        setState(() {
          syllabusList = (data['SYLLABUS'] as List)
              .map((json) => Syllabus.fromJson(json))
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EXAM SYLLABUS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF00008B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              //refreshData();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.5, ),
            value: selectedExam,
            onChanged: (value) {
              setState(() {
                selectedExam = value!;
              });
            },
            items: exams.map((exam) {
              return DropdownMenuItem<String>(
                value: exam.examName,
                child: Text(exam.examName),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: syllabusList.length,
              itemBuilder: (context, index) {
                final syllabus = syllabusList[index];
                if (syllabus.exam == selectedExam) {
                  return Card(
                    elevation: 10,
                    //color: Color(0xFF00008B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/subject.png',
                        width: 55,
                        height: 55,
                      ),
                      title: Text(
                        syllabus.subject,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        syllabus.activity,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF00008B),
        child: Container(height: 50.0),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExamSyllabus(),
  ));
}
