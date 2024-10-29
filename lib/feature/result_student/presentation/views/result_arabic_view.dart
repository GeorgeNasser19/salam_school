import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart';

class ResultArabicView extends StatelessWidget {
  const ResultArabicView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    return Directionality(
      textDirection: TextDirection.rtl, // تغيير الاتجاه إلى من اليمين لليسار
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: SizedBox(
                  width: curWidth < 400 ? 500 : 1100,
                  height: 8000,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'تقرير التقدم - الفصل الدراسي الثاني 2024',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'تهانينا\n${student.grade}',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.blue),
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
                                      fontSize: _getFontSize(context, 18)),
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
                                    // Text('المسؤول الإداري: كارولين ثروت'),
                                    // SizedBox(height: 4),
                                    // Text(
                                    //     'مشرفه المرحلة الابتدائية: أماني عديب'),
                                    // SizedBox(height: 4),
                                    Text('مديره المدرسة: نسرين منجد'),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text('المسؤول الإداري: كارولين ثروت'),
                                    // Text(
                                    //     'مشرفة المرحلة الابتدائية: أماني عديب'),
                                    Text('مديره المدرسة: نسرين منجد'),
                                  ],
                                ),
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
        _buildCell('المادة\n  ',
            isHeader: false, color: const Color.fromARGB(255, 82, 116, 175)),
        _buildCell('متفوق\nفي التوقعات', isHeader: true, color: Colors.blue),
        _buildCell('يلبي دائمًا\nالتوقعات',
            isHeader: true, color: Colors.green),
        _buildCell('يلبي أحيانًا\nالتوقعات',
            isHeader: false, color: Colors.yellow),
        _buildCell('غير مقبول\n', isHeader: true, color: Colors.red),
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
