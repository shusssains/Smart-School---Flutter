import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}
class HomeWork {
  final String homeworkdate;
  final String subjectname;
  final String description;
  HomeWork({
    required this.homeworkdate,
    required this.subjectname,
    required this.description,
  });
}
class _HomeworkScreenState extends State<HomeworkScreen> {
  List<HomeWork> homeWorkList = [];
  bool isLoading = false;
  String errorMessage = '';
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('https://staging.smartschoolplus.co.in/Webservice/SSPMobileService.asmx/GetAllHomework?SchoolCode=TESTLAKE&ClassId=1&HomeworkDate='));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> homeWork = jsonData['HomeWork'];
        setState(() {
          homeWorkList = homeWork.map((item) {
            return HomeWork(
              homeworkdate: item['HOMEWORKDATE'],
              subjectname: item['SUBJECTNAME'],
              description: item['DESCRIPTION'],
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
          'HOMEWORKS',
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
      //backgroundColor: const Color(0xFF00008B),
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
          : homeWorkList.isEmpty
          ? const Center(
        child: Text(
          'No homework found',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: homeWorkList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = homeWorkList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0), // Add space around each card
            child: Card(
              elevation: 8,
              child: ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeworkInfo('assets/images/calender.png', '  Homework Date :   ${item.homeworkdate}'),
                    homeworkInfo('assets/images/subject.png', '  Subject Name :      ${item.subjectname}'),
                    homeworkInfo('assets/images/homework.png', '  Description :          ${item.description}'),
                  ],
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
  Widget homeworkInfo(String imagePath, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Row(
        children: [
           const SizedBox(width: 5.0),
          Container(
            padding: const EdgeInsets.all(7.4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00008B),
            ),
            child: Image.asset(imagePath, width:27, height: 27),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                 fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
