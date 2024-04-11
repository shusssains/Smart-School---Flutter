import 'package:flutter/material.dart';

class MedicalRecordspage extends StatefulWidget {
  const MedicalRecordspage({Key? key}) : super(key: key);

  @override
  State<MedicalRecordspage> createState() => _MedicalRecordspageState();
}

class _MedicalRecordspageState extends State<MedicalRecordspage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        title: Text('MEDICAL RECORDS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF00008B),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _animation,
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                // Generate some dummy data
                String date =
                    'Date: ${DateTime.now().subtract(Duration(days: index)).toString()}';
                String time = 'Time: 10:00 AM';
                String record =
                    'Record: Some medical record here.';
                return FadeTransition(
                  opacity: _animation,
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 14),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildIconContainer(
                                  'assets/images/calender.png', size: 42),
                              SizedBox(width: 12),
                              Text(
                                date,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              _buildIconContainer(
                                  'assets/images/time.png', size: 42),
                              SizedBox(width: 12),
                              Text(
                                time,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              _buildIconContainer(
                                  'assets/images/date.png', size: 40),
                              SizedBox(width: 12),
                              Text(
                                record,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconContainer(String imagePath, {double size = 20}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2), // Make it circular
        color: Color(0xFF00008B),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0), // Adjust padding
        child: Image.asset(
          imagePath,
          //color: Colors.white,
          width: size * 0.7, // Adjust image size
          height: size * 0.7,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MedicalRecordspage(),
  ));
}
