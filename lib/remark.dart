import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Remark());
}

class Remark extends StatefulWidget {
  @override
  _RemarkState createState() => _RemarkState();
}

class Remarks {
  final String name;
  final String dateofact;
  final String remarktype;
  final String staffname;
  final String actiontaken;
  Remarks({
    required this.name,
    required this.dateofact,
    required this.remarktype,
    required this.staffname,
    required this.actiontaken,
  });
}

class _RemarkState extends State<Remark> {
  List<Remarks> remarkList = [];
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
      final response = await http.get(Uri.parse(
          'https://test.smartschoolplus.co.in/webservice/sspmobileservice.asmx/ViewRemark?SchoolCode=TESTLAKE&RStudentId=3414&RDate=17/02/2024'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> remark = jsonData['RemarkView'];
        setState(() {
          remarkList = remark.map((item) {
            return Remarks(
              name: item['NAME'],
              dateofact: item['DATEOFACT'],
              remarktype: item['Remark Type'],
              staffname: item['Staff'],
              actiontaken: item['Action Taken'],
            );
          }).toList();
          errorMessage = ''; // Reset error message
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        errorMessage =
        'Failed to fetch data. Please check your internet connection and try again.';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'REMARKS',
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
                refreshData();
              },
            ),
          ],
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : errorMessage.isNotEmpty
            ? Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        )
            : remarkList.isEmpty
            ? Center(
          child: Text(
            'No remarks found',
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: remarkList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = remarkList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0, horizontal: 12.0),
              child: Card(
                elevation: 8,
                child: ListTile(
                  subtitle: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      remarkInfo(
                          'assets/images/date.png',
                          '  Date:         ${item.dateofact}'),
                      remarkInfo(
                          'assets/images/remark.png',
                          '  Remark:    ${item.remarktype}'),
                      Row(
                        children: [
                          Expanded(
                            child: remarkInfo(
                                'assets/images/staffname.png',
                                '  Staff:        ${item.staffname}'),
                          ),
                          Expanded(
                            child: remarkInfo(
                                'assets/images/action.png',
                                '  Action:         ${item.actiontaken}'),
                          ),
                        ],
                      ),
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
      ),
    );
  }

  Widget remarkInfo(String imagePath, String text) {
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
            child: Image.asset(imagePath, width: 27, height: 27),
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
