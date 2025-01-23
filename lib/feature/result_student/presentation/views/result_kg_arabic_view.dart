import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart';

class ResultKgArabicView extends StatelessWidget {
  const ResultKgArabicView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    final isSmallScreen = curWidth < 600;

    return Directionality(
      textDirection: TextDirection.rtl,
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
                            ' الفصل الدراسي الاول 2025-2024',
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
                                  "السلام سوهاج الخاصه",
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
                                fontSize: 22, color: isSmallScreen
                                          ? Colors.white
                                          : Colors.black,),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8), // تعديل المحاذاة
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "الاسم: ${student.studentName}",
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
                            'مديره المدرسة\nنسرين منجد',
                            style: TextStyle(
                              fontSize: _getFontSize(context, 22),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const SizedBox(height: 8),
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
    // Get the device's width
    double width = MediaQuery.of(context).size.width;

    // If the width is small (like a phone), reduce the font size
    if (width < 600) {
      return baseSize * 0.8; // Reduce font size to 80% for smaller screens
    }

    return baseSize;
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell(
          'الماده ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
        _buildCell(
          'الدرجه ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
        _buildCell(
          'اللون ',
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
      height: 50, // تحديد ارتفاع الخلية
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey.shade400), // إضافة حدود
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
