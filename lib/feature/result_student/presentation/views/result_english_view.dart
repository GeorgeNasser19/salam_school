import 'package:flutter/material.dart';
import '../../data/model/execl_model.dart';

class ResultEnglishView extends StatelessWidget {
  const ResultEnglishView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    final isSmallScreen = curWidth < 600;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: .9,
                child: Image.asset(
                  isSmallScreen
                      ? "lib/assets/last edit small.png"
                      : "lib/assets/last edit.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: isSmallScreen ? 0 : 800),
                      child: Container(
                        width: curWidth < 400 ? 500 : 1100,
                        height: 8000,
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: isSmallScreen ? 100 : 150,
                              ),
                              Text(
                                'Second Semester 2024\nProgress Report',
                                style: TextStyle(
                                    color: isSmallScreen
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: _getFontSize(
                                        context, 24), // Adjust font size
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Salam Sohag School",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSmallScreen
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: _getFontSize(
                                              context, 24)), // Adjust font size
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Congratulations\n${student.grade}',
                                style: TextStyle(
                                    fontSize: _getFontSize(
                                        context, 22), // Adjust font size
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Name : ${student.studentName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSmallScreen
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: _getFontSize(
                                              context, 18)), // Adjust font size
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const {
                                  0: FlexColumnWidth(1.3),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1),
                                  3: FlexColumnWidth(1),
                                  4: FlexColumnWidth(1),
                                },
                                children: [
                                  _buildHeaderRow(),
                                  ...student.subjects.entries.map((entry) {
                                    return _buildRow(
                                      entry.key,
                                      entry.value.toDouble(),
                                      const Color.fromARGB(255, 255, 255, 255),
                                    );
                                  })
                                ],
                              ),  
                              const SizedBox(height: 16),
                              const Center(
                                child: Text(
                                  'School Principal\nNesreen Monged',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ));
  }

  // Function to adjust font size based on screen size
  double _getFontSize(BuildContext context, double baseSize) {
    // Get the device's width
    double width = MediaQuery.of(context).size.width;

    // If the width is small (like a phone), reduce the font size
    if (width < 600) {
      return baseSize * 0.8; // Reduce font size to 80% for smaller screens
    }

    return baseSize; // Keep original size for larger screens
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell('Subject\n  ',
            isHeader: true, color: const Color.fromARGB(255, 243, 243, 243)),
        _buildCell('Exceeds\nExpectations', isHeader: true, color: Colors.blue),
        _buildCell('Always meets\nExpectations',
            isHeader: true, color: Colors.green),
        _buildCell('Sometimes meets\nExpectations',
            isHeader: true, color: Colors.yellow),
        _buildCell('Unacceptable\n', isHeader: true, color: Colors.red),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade, Color subjectColor) {
    Color exceedsColor = Colors.transparent;
    Color alwaysColor = Colors.transparent;
    Color sometimesColor = Colors.transparent;
    Color unacceptableColor = Colors.transparent;

    if (grade >= 80 && grade <= 100) {
      exceedsColor = Colors.blue;
    } else if (grade >= 65 && grade < 79) {
      alwaysColor = Colors.green;
    } else if (grade >= 50 && grade < 64) {
      sometimesColor = Colors.yellow;
    } else if (grade < 49) {
      unacceptableColor = Colors.red;
    }

    return TableRow(
      children: [
        _buildCell(subject, color: subjectColor, textColor: Colors.black ,isHeader: true),
        _buildCell('', color: exceedsColor,textColor: Colors.black),
        _buildCell('', color: alwaysColor,textColor: Colors.black),
        _buildCell('', color: sometimesColor,textColor: Colors.black),
        _buildCell('', color: unacceptableColor,textColor: Colors.black),
      ],
    );
  }

  Widget _buildCell(String text,
      {bool isHeader = false,
      Color color = Colors.transparent,
      Color textColor = Colors.black}) {
   
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: textColor, // تعيين لون النص هنا
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
