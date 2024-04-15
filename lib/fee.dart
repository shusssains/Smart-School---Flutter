import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';

class AcademicYear {
  final String academicYear;
  final String academicYearId;

  AcademicYear({required this.academicYear, required this.academicYearId});

  factory AcademicYear.fromJson(Map<String, dynamic> json) {
    return AcademicYear(
      academicYear: json['ACADEMICYEAR'],
      academicYearId: json['ACADEMICYEARID'],
    );
  }
}

class FeeDetails {
  final String studentId;
  final String paymentMode;
  final String amount;
  final String receiptNo;
  final String transactionId;
  final String academicYear;
  final String frequencyName;
  final String paymentDate;

  FeeDetails({
    required this.studentId,
    required this.paymentMode,
    required this.amount,
    required this.receiptNo,
    required this.transactionId,
    required this.academicYear,
    required this.frequencyName,
    required this.paymentDate,
  });

  factory FeeDetails.fromJson(Map<String, dynamic> json) {
    return FeeDetails(
      studentId: json['STUDENTID'],
      paymentMode: json['PAYMENTMODE'],
      amount: json['AMOUNT'],
      receiptNo: json['RECEIPTNO'],
      transactionId: json['TRANSACTIONID'],
      academicYear: json['ACADEMICYEAR'],
      frequencyName: json['FREQUENCYNAME'],
      paymentDate: json['PAYMENTDATE'],
    );
  }
}

class Fee extends StatefulWidget {
  @override
  _FeeState createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  int? pdfPage = 0;
  String selectedAcademicYear = '';
  List<AcademicYear> academicYears = [];
  List<FeeDetails> feeDetailsList = [];

  @override
  void initState() {
    super.initState();
    fetchAcademicYears();
    fetchFeeDetails();
  }

  void openPdfPage(String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('PDF Viewer')),
          body: PDFView(
            filePath: pdfUrl,
            onPageChanged: (page, total) {
              setState(() {
                pdfPage = page;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> fetchAcademicYears() async {
    final response = await http.get(Uri.parse('https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetStudentFeePaidACYear?SchoolCode=TESTLAKE&StudentId=3414'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Status Code'] == '01') {
        setState(() {
          academicYears = (data['ACADEMICYEAR'] as List)
              .map((json) => AcademicYear.fromJson(json))
              .toList();
          selectedAcademicYear =
          academicYears.isNotEmpty ? academicYears[0].academicYear : '';
        });
      }
    }
  }

  Future<void> fetchFeeDetails() async {
    final response = await http.get(Uri.parse('https://test.smartschoolplus.co.in/WebService/SSPMobileService.asmx/GetReceiptWiseStudentFeePaidDetails?SchoolCode=TESTLAKE&StudentId=3414&Academicyear=2023'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Status Code'] == '01') {
        setState(() {
          feeDetailsList = (data['FEEDETAILS'] as List)
              .map((json) => FeeDetails.fromJson(json))
              .toList();
        });
      }
    }
  }

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
          'FEE RECEIPT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            style: const TextStyle(color: Colors.black),
            value: selectedAcademicYear,
            onChanged: (value) {
              setState(() {
                selectedAcademicYear = value!;
              });
            },
            items: academicYears.map((academicYear) {
              return DropdownMenuItem<String>(
                value: academicYear.academicYear,
                child: Text(academicYear.academicYear),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: feeDetailsList.length,
              itemBuilder: (context, index) {
                final feeDetail = feeDetailsList[index];
                if (feeDetail.academicYear == selectedAcademicYear) {
                  return Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: 'FREQUENCY NAME :',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:   feeDetail.frequencyName,
                              style: const TextStyle(color: Colors.black,),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 17.0),
                          Row(
                            children: [
                              Image.asset('assets/images/amount.png', width: 24, height: 24),
                              const SizedBox(width: 8),
                              Text(
                                'AMOUNT                   : ${feeDetail.amount}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 17.0),
                          Row(
                            children: [
                              Image.asset('assets/images/date.png', width: 24, height: 24),
                              const SizedBox(width: 8),
                              Text(
                                'DATE                          : ${feeDetail.paymentDate}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 17.0),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  openPdfPage('https://docs.apryse.com/samples/web/samples/full-apis/ViewerCustomSaveTest/ViewerCustomSaveTest.js'); // Replace with your PDF URL
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: const Color(0xFF00008B),// foreground
                                ),
                                icon: Image.asset('assets/images/view.png', width: 24, height: 24),
                                label: Text('View Receipt'),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton.icon(
                                onPressed: () {
                                  openPdfPage('https://docs.apryse.com/samples/web/samples/full-apis/ViewerCustomSaveTest/ViewerCustomSaveTest.js'); // Replace with your PDF URL
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: const Color(0xFF00008B), // foreground
                                ),
                                icon: Image.asset('assets/images/download.png', width: 24, height: 24),
                                label: Text('Download Receipt'),
                              ),
                            ],
                          ),
                        ],
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
        color: Color(0xFF00008B),
        child: Container(
          height: 50.0, // Adjust the height as needed
        ),
      ),
    );
  }
}
