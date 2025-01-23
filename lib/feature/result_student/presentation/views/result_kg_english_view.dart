import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart';

class ResultKgEnglishView extends StatelessWidget {
  const ResultKgEnglishView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    final isSmallScreen = curWidth < 600;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
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
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(left: isSmallScreen ? 0 : 800),
                child: SizedBox(
                  width: curWidth < 400 ? 500 : 1100,
                  height: 8000,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (isSmallScreen)
                            SizedBox(
                              height: student.subjects.entries.length <= 6
                                  ? 50
                                  : 50,
                            ),
                          if (!isSmallScreen)
                            const SizedBox(
                              height: 60,
                            ),
                          Text(
                            'First Semester 2024-2025',
                            style: TextStyle(
                                color:
                                    isSmallScreen ? Colors.white : Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
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
                          const SizedBox(height: 8),
                          Text(
                            '${student.grade}',
                            style:  TextStyle(
                                fontSize: 22, color:
                                isSmallScreen
                                          ? Colors.white
                                          : Colors.black, ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8), // تعديل المحاذاة
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Name: ${student.studentName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSmallScreen
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: _getFontSize(context, 22)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: const {
                              0: FlexColumnWidth(1.5),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(0),
                            },
                            children: [
                              _buildHeaderRow(),
                              ...student.subjects.entries.map((entry) {
                                return _buildRow(
                                  entry.key,
                                  entry.value.toDouble(),
                                );
                              })
                            ],
                          ),
                          const SizedBox(height: 16),
                          Center(
                              child: Text(
                            'School Principal\nNesreen Monged',
                            style: TextStyle(
                              fontSize: _getFontSize(context, 22),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const SizedBox(height: 8),
                            if (student.total != null) ...[
                        const SizedBox(height: 16),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                          child: const Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 4,
                              top: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 164, 189, 233),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                student.total.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  double _getFontSize(BuildContext context, double baseSize) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return baseSize * 0.8;
    }
    return baseSize;
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell(
          'Subject ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
        _buildCell(
          'Grade ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
        _buildCell(
          'Color ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade) {
    return TableRow(
      children: [
        _buildCell(subject, color: Colors.white, isHeader: true),
        _buildCell(grade.toString(), color: Colors.white, isHeader: true),
        Container(
          height: 50,
          color: _getGradeColor(grade),
        ),
      ],
    );
  }

  Color _getGradeColor(double grade) {
    if (grade >= 80 && grade <= 100) {
      return Colors.blue; // درجة عالية
    } else if (grade >= 65 && grade < 79) {
      return Colors.green; // درجة متوسطة
    } else if (grade >= 50 && grade < 64) {
      return Colors.yellow; // درجة منخفضة
    } else if (grade < 49) {
      return Colors.red;
    }
    return Colors.transparent; 
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
            fontSize: 14,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
