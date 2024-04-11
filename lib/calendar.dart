import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedDate;
  late List<List<int>> _calendarDays;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _generateCalendarDays();
  }

  void _generateCalendarDays() {
    int year = _selectedDate.year;
    int month = _selectedDate.month;
    _calendarDays = [];
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int currentDay = 1;

    while (currentDay <= daysInMonth) {
      List<int> week = [];
      for (int i = 0; i < 7; i++) {
        // Check if currentDay falls within the month or if it's the first day
        if ((i == DateTime(year, month, currentDay).weekday - 1) || (currentDay != 1 && currentDay <= daysInMonth)) {
          week.add(currentDay);
          currentDay++;
        } else {
          week.add(0); // Placeholder for empty cells
        }
      }
      _calendarDays.add(week);
    }
  }

  void _onMonthChange(int monthIncrement) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + monthIncrement);
      _generateCalendarDays();
    });
  }

  String _getMonthName(int month) {
    // Convert month number to month name
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
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
          'CALENDAR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF00008B),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back,
                color: Colors.white,),
                onPressed: () {
                  _onMonthChange(-1);
                },
              ),
              Text('${_getMonthName(_selectedDate.month)} ${_selectedDate.year}', style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold, fontSize: 16, )),
              IconButton(
                icon: Icon(Icons.arrow_forward,
                  color: Colors.white,),
                onPressed: () {
                  _onMonthChange(1);
                },
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: _calendarDays.length * 7,
              itemBuilder: (BuildContext context, int index) {
                int row = index ~/ 7;
                int col = index % 7;
                int day = _calendarDays[row][col];
                return Card(
                  color: day != 0 ? Colors.white : Colors.transparent, // Set color for non-empty cells
                  child: day != 0
                      ? Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Calendar(),
  ));
}
