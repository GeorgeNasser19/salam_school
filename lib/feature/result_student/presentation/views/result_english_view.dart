import 'package:flutter/material.dart';
import '../../data/model/execl_model.dart';

///////////////// isComplete = true
class ResultEnglishView extends StatelessWidget {
  const ResultEnglishView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Container(
                  width: curWidth < 400 ? 500 : 1100,
                  height: 8000,
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(curWidth.toString()),
                        Text(
                          'Second Semester 2024\nProgress Report',
                          style: TextStyle(
                              fontSize:
                                  _getFontSize(context, 24), // Adjust font size
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Congratulations\n${student.grade}',
                          style: TextStyle(
                              fontSize:
                                  _getFontSize(context, 22), // Adjust font size
                              color: Colors.blue),
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
                                const Color.fromARGB(255, 82, 116, 175),
                              );
                            })
                          ],
                        ),
                        const SizedBox(height: 16),
                        curWidth < 600
                            ? const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      'Administrative official: Caroline Thrwat'),
                                  SizedBox(height: 4),
                                  Text('Primary stage supervisor: Amany Adeeb'),
                                  SizedBox(height: 4),
                                  Text('School Principal: Nesreen Monged'),
                                ],
                              )
                            : const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Administrative official: Caroline Thrwat'),
                                  Text('Primary stage supervisor: Amany Adeeb'),
                                  Text('School Principal: Nesreen Monged'),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
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
            isHeader: false, color: const Color.fromARGB(255, 82, 116, 175)),
        _buildCell('Exceeds\nExpectations',
            isHeader: false, color: Colors.blue),
        _buildCell('Always meets\nExpectations',
            isHeader: false, color: Colors.green),
        _buildCell('Sometimes meets\nExpectations',
            isHeader: false, color: Colors.yellow),
        _buildCell('Unacceptable\n', isHeader: true, color: Colors.red),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade, Color subjectColor) {
    Color exceedsColor = Colors.transparent;
    Color alwaysColor = Colors.transparent;
    Color sometimesColor = Colors.transparent;
    Color unacceptableColor = Colors.transparent;

    if (grade >= 35 && grade <= 40) {
      exceedsColor = Colors.blue;
    } else if (grade >= 30 && grade < 35) {
      alwaysColor = Colors.green;
    } else if (grade >= 25 && grade < 30) {
      sometimesColor = Colors.yellow;
    } else if (grade < 25) {
      unacceptableColor = Colors.red;
    }

    return TableRow(
      children: [
        _buildCell(subject, color: subjectColor),
        _buildCell('', color: exceedsColor),
        _buildCell('', color: alwaysColor),
        _buildCell('', color: sometimesColor),
        _buildCell('', color: unacceptableColor),
      ],
    );
  }

  Widget _buildCell(String text,
      {bool isHeader = false, Color color = Colors.transparent}) {
    return Container(
      height: 50, // تحديد ارتفاع الخلية
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey.shade400), // إضافة حدود
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
