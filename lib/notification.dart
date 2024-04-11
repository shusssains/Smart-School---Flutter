import 'package:flutter/material.dart';

// Notification class
class NotificationModel {
  final String date;
  final String time;
  final String message;
  final String iconPath;

  NotificationModel({
    required this.date,
    required this.time,
    required this.message,
    required this.iconPath,
  });
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Dummy list of notifications
  final List<NotificationModel> notifications = [
    NotificationModel(
      date: 'Mar 26, 2024',
      time: '10:00 AM',
      message: 'You have a new message',
      iconPath: 'assets/images/date.png',
    ),
    NotificationModel(
      date: 'Mar 26, 2024',
      time: '12:00 PM',
      message: 'Meeting reminder',
      iconPath: 'assets/images/time.png',
    ),
    NotificationModel(
      date: 'Mar 27, 2024',
      time: '02:00 PM',
      message: 'Event notification',
      iconPath: 'assets/images/notification.png',
    ),
  ];

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
          'NOTIFICATIONS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF00008B),
      body: SingleChildScrollView(
        child: Column(
          children: notifications.map((notification) {
            return NotificationCard(
              notification: notification,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(
          notification.iconPath,
          width: 50,
          height: 50,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.date),
            Text(notification.time),
            Text(notification.message),
            // Add more fields here if needed
          ],
        ),
        //trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Handle tap on notification
          // You can navigate to another page or perform other actions here
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationPage(),
  ));
}
