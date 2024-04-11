// Import the package
import 'package:flutter/material.dart';

// Define your ExamResults widget
class ExamResults extends StatefulWidget {
  const ExamResults({Key? key}) : super(key: key);

  @override
  State<ExamResults> createState() => _ExamResultsState();
}

// Define the state of your ExamResults widget
class _ExamResultsState extends State<ExamResults> {
  // Initialize your variables
  String _selectedAcademicYear = '2022';
  String _selectedExamType = 'Midterm';
  List<String> _subjects = ['Maths', 'Science', 'English', 'History', 'Geography'];
  List<String> _marks = ['43/50', '35/50', '40/50', '45/50', '38/50'];
  List<String> _grades = ['A+', 'B', 'A', 'A+', 'B'];

  // Function to handle downloading the report card
  void _downloadReportCard() {
    // Implement your download functionality here
    // For example, you can show a toast message indicating the report card is downloaded.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading report card...'),
      ),
    );
  }

  // Build method to create the UI
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
          'EXAM RESULTS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF00008B),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Academic Year',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedAcademicYear,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAcademicYear = newValue!;
                    });
                  },
                  items: ['2022', '2023', '2024']
                      .map((year) => DropdownMenuItem<String>(
                    value: year,
                    child: Text(year,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                  ))
                      .toList(),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Exam Type',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedExamType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedExamType = newValue!;
                    });
                  },
                  items: ['Midterm', 'Half-Yearly', 'Quarterly', 'Annual']
                      .map((type) => DropdownMenuItem<String>(
                    value: type,
                    child: Text(type,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                  ))
                      .toList(),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(child: Text('Subject',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)),
                        ),
                        TableCell(
                          child: Center(child: Text('Marks',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)),
                        ),
                        TableCell(
                          child: Center(child: Text('Grade',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)),
                        ),
                      ],
                    ),
                    ...List.generate(_subjects.length, (index) {
                      return TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_subjects[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_marks[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_grades[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: _downloadReportCard,
                leading: Image.asset('assets/images/download.png',
                  width: 34, // Adjust the width as needed
                  height: 34, ), // Load icon from assets
                title: Text(
                  'Download Report Card',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main function to run the app
void main() {
  runApp(MaterialApp(
    home: ExamResults(),
  ));
}
