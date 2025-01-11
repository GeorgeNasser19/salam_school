import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart';

class ResultArabicView extends StatelessWidget {
  const ResultArabicView({super.key, required this.student});

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
                                  ? 100
                                  : 50,
                            ),
                          if (!isSmallScreen)
                            const SizedBox(
                              height: 150,
                            ),
                          Text(
                            'تقرير التقدم - الفصل الدراسي الثاني 2024',
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
                            'تهانينا\n${student.grade}',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.black),
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
                          Center(
                              child: Text(
                            'مديره المدرسة: نسرين منجد',
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

  TableRow  _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell('المادة\n  ',
            isHeader: false, color: const Color.fromARGB(255, 250, 251, 252)),
        _buildCell('متفوق\nفي التوقعات', isHeader: true, color: Colors.blue),
        _buildCell('يلبي دائمًا\nالتوقعات',
            isHeader: true, color: Colors.green),
        _buildCell('يلبي أحيانًا\nالتوقعات',
            isHeader: false, color: Colors.yellow),
        _buildCell('غير مقبول\n', isHeader: true, color: Colors.red),
      ],
    );
  }

  TableRow _buildRow(
    String subject,
    double grade,
    Color subjectColor,
  ) {
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
        _buildCell(subject, color: subjectColor, textColor: Colors.black,isHeader: true),
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
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
