import 'package:flutter/material.dart';
import 'passangerdetails.dart';
import 'payment.dart';
import 'principalappointment.dart';
import 'youtube.dart';
import 'admitcard.dart';
import 'calendar.dart';
import 'circular.dart';
import 'classtimetable.dart';
import 'communication.dart';
import 'examresults.dart';
import 'examsyllabus.dart';
import 'examtimetable.dart';
import 'fee.dart';
import 'gallery.dart';
import 'leaverequest.dart';
import 'newpolicy.dart';
import 'notification.dart';
import 'remark.dart';
import 'dart:async';
import 'childinfopage.dart';
import 'medicalrecordspage.dart';
import 'homework.dart';
import 'attendance.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GridView with Icons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GridViewIcons(),
        bottomNavigationBar: BottomNavigationBarWithSlideAnimation(),
      ),
    );
  }
}

class GridViewIcons extends StatelessWidget {
  final List<String> imageAssets = [
    'assets/images/childinfo.png',
    'assets/images/medicalrecords.png',
    'assets/images/homework.png',
    'assets/images/attendance.png',
    'assets/images/remarks.png',
    'assets/images/classtimetable.png',
    'assets/images/examtimetable.png',
    'assets/images/examsyllabus.png',
    'assets/images/examresults.png',
    'assets/images/calender.png',
    'assets/images/leaverequest.png',
    'assets/images/gallery.png',
    'assets/images/notification.png',
    'assets/images/circular.png',
    'assets/images/passengerdetails.png',
    'assets/images/appointment.png',
    'assets/images/youtubechannel.png',
    'assets/images/admitcard.png',
    'assets/images/communication.png',
    'assets/images/newpolicy.png',
    'assets/images/payment.png',
    'assets/images/feereceipt.png',
  ];

  final List<Widget> screens = [
    const ChildInfoPage(),
    const MedicalRecordspage(),
    HomeworkScreen(),
    const Attendance(),
    Remark(),
    const ClassTimeTable(),
    ExamTimetable(),
    const ExamSyllabus(),
    const ExamResults(),
    Calendar(),
    const leaverequest(),
    GalleryScreen(),
    NotificationPage(),
    CircularCard(),
    const PassengerDetails(),
    PrincipalAppointmentMessage(),
    const Youtube(),
    const AdmitCard(),
    const Fee(),
    const Payment(),
    const Communication(),
    NewPolicy(),
  ];
  final List<Color> cardColors = [
    Colors.red,
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.indigo,
    Colors.purple,
    Colors.lightGreen,
    // Add more colors as needed
  ];
  final List<String> screenTitles = [
    'Child Info',
    'Medical',
    'Homework',
    'Attendance',
    'Remarks',
    'Class ',
    'Exam ',
    'Exam Syllabus',
    'Exam Results',
    'Calender',
    'Leave Request',
    'Gallery',
    'Notification',
    'Circular',
    'Passenger',
    'Principal',
    'youtube',
    'Admit Card',
    'Fee Receipt',
    'Payment',
    'Communicatio',
    'New Policy',
    // Add more titles as needed
  ];
  final double imageSize = 32.0; // Adjust image size
  final double cardSize = 55.0; // Adjust card size
  final double titleSpace = 1.0; // Adjust space between card and title
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: imageAssets.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => screens[index]),
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        elevation: 2.3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        color: cardColors[index % cardColors.length],
                        child: Container(
                          width: cardSize,
                          height: cardSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                cardColors[index % cardColors.length].withOpacity(0.5), // lighter color
                                cardColors[index % cardColors.length], // original color
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              imageAssets[index],
                              width: imageSize,
                              height: imageSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: titleSpace),
                      Text(
                        screenTitles[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'DASHBOARD',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: const Color(0xFF00008B),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh, color:Colors.white),
          onPressed: () {
          },
        ),
        IconButton(
          icon: const Icon(Icons.timeline, color:Colors.white),
          onPressed: () {
            // Functionality for navigating to another class
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExamResults()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout, color:Colors.white),
          onPressed: () {
            // Functionality for logging out
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Perform logout functionality here
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class BottomNavigationBarWithSlideAnimation extends StatefulWidget {
  @override
  _BottomNavigationBarWithSlideAnimationState createState() =>
      _BottomNavigationBarWithSlideAnimationState();
}

class _BottomNavigationBarWithSlideAnimationState
    extends State<BottomNavigationBarWithSlideAnimation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      backgroundColor: const Color(0xFF00008B), // Dark blue color code
      selectedItemColor: Colors.white, // Set selected icon and label color to white
      unselectedItemColor: Colors.white, // Set unselected icon and label color to white
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Fee()),
              );
              break;
          }
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update),
          label: 'Updates',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Payment',
        ),
      ],
    );
  }
}