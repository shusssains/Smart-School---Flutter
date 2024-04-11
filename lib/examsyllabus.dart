import 'package:flutter/material.dart';

class ExamSyllabus extends StatefulWidget {
  const ExamSyllabus({Key? key}) : super(key: key);

  @override
  State<ExamSyllabus> createState() => _ExamSyllabusState();
}

class _ExamSyllabusState extends State<ExamSyllabus> {
  String dropdownValue = 'Quarterly Exam';

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
          'EXAM TIMETABLE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF00008B),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search the subjects here',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder( // Add an outline border
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // Set the border color to light white
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width, // Set the width of the dropdown
              child: DropdownButton<String>(
                value: dropdownValue,
                underline: Container(), // Remove the default underline
                dropdownColor: const Color(0xFF00008B), // Set the dropdown background color
                style: const TextStyle(color: Colors.white), // Set the default text color to white
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Quarterly Exam',
                  'Half-Yearly Exam',
                  'Annual Exam',
                  'Mid Term Test'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.5)), // Add an outline border
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Add padding
                      child: Text(
                        value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First Row: Subject
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/subject.png', // Icon for subject
                                    width: 26,
                                    height: 26,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Maths ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Second Row: Syllabus
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/syllabus.png', // Icon for syllabus
                                    width: 26,
                                    height: 26,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Read, Write ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),),
                                ],
                              ),
                              SizedBox(height: 8), // Add spacing between the two rows
                            ],
                          ),
                        ),
                      ),

                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExamSyllabus(),
  ));
}
