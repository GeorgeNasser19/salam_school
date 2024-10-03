import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "lib/assets/WhatsApp Image 2024-10-02 at 01.58.09_52ebf013.jpg",
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Container(
              width: 1100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Second Semester 2024\nProgress Report',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Congratulations\nGrade ${student.grade}',
                        style:
                            const TextStyle(fontSize: 22, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name : ${student.studentName}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
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
                              entry.value,
                              const Color.fromARGB(255, 82, 116, 175),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Administrative official: Caroline Thrwat'),
                          Text('Primary stage supervisor: Amany Adeeb'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('School Principal: Nesreen Monged',
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell('Subject\n  ',
            isHeader: false, color: const Color.fromARGB(255, 82, 116, 175)),
        _buildCell('Exceeds\nExpectations', isHeader: true, color: Colors.blue),
        _buildCell('Always meets\nExpectations',
            isHeader: true, color: Colors.green),
        _buildCell('Sometimes meets\nExpectations',
            isHeader: true, color: Colors.yellow),
        _buildCell('Unacceptable\n', isHeader: true, color: Colors.red),
      ],
    );
  }

  TableRow _buildRow(String subject, int grade, Color subjectColor) {
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
      padding: const EdgeInsets.all(8),
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isHeader ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
