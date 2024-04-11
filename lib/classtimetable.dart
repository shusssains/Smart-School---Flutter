import 'package:flutter/material.dart';

class ClassTimeTable extends StatelessWidget {
  const ClassTimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
          'CLASS TIMETABLE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF00008B),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          childAspectRatio: (screenWidth / 8) / (screenWidth / 8 + 50), // Adjust cell aspect ratio and increase space
          crossAxisSpacing: 8.0, // Increase horizontal space between cells
          mainAxisSpacing: 8.0, // Increase vertical space between cells
        ),
        itemCount: 7 * 8, // 7 rows and 8 columns
        itemBuilder: (BuildContext context, int index) {
          // Calculate row and column
          final row = index ~/ 8; // Fixing index calculation
          final column = index % 8;

          // First row displays days (Monday to Saturday)
          if (row == 0) {
            return _buildCell(_getDayAbbreviation(column), Colors.white);
          } else if (row == 6) {
            // Special styling for row index 6
            return _buildSpecialCell(column);
          } else {
            // Rest of the rows
            return _buildCell(_getTimeTableText(row - 1, column), Colors.white);
          }
        },
      ),
    );
  }

  String _getDayAbbreviation(int column) {
    switch (column) {
      case 0:
        return '#';
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String _getTimeTableText(int row, int column) {
    switch (column) {
      case 0:
        return (row + 1).toString();
      case 1:
        return 'PET';
      case 2:
        return 'ENG';
      case 3:
        return 'BREAK';
      case 4:
        return 'READ';
      case 5:
        return 'WRITE';
      case 6:
        return 'HINDI';
      case 7:
        return 'MATHS';
      default:
        return '';
    }
  }

  Widget _buildCell(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(4.0), // Reduce padding
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14, // Adjust font size
        ),
      ),
    );
  }

  Widget _buildSpecialCell(int column) {
    // Special styling for row index 6
    if (column == 6) {
      return _buildCell('Sun', Colors.white);
    } else {
      return _buildEmptyCell();
    }
  }

  Widget _buildEmptyCell() {
    return Container(); // Empty cell for Sunday
  }
}

void main() {
  runApp(MaterialApp(
    home: ClassTimeTable(),
  ));
}
