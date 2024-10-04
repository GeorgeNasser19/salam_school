import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart';

class ResultArabicView extends StatelessWidget {
  const ResultArabicView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تغيير الاتجاه إلى من اليمين لليسار
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: SizedBox(
                width: 1100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ////////////////////////////////////////////////////////////////
                        const Text(
                          'صفحة النتائج - عربييي',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        ///////////////////////////////////////////////////////////////////
                        const Text(
                          'تقرير التقدم - الفصل الدراسي الثاني 2024',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تهانينا\n${student.grade}',
                          style:
                              const TextStyle(fontSize: 22, color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8), // تعديل المحاذاة
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "الاسم: ${student.studentName}",
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
                                entry.value.toDouble(),
                                const Color.fromARGB(255, 82, 116, 175),
                              );
                            })
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('المسؤول الإداري: كارولين ثروت'),
                            Text('مشرفة المرحلة الابتدائية: أماني عديب'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('مديرة المدرسة: نسرين منجد',
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell('المادة\n  ',
            isHeader: true, color: const Color.fromARGB(255, 82, 116, 175)),
        _buildCell('متفوق\nفي التوقعات', isHeader: true, color: Colors.blue),
        _buildCell('يلبي دائمًا\nالتوقعات',
            isHeader: true, color: Colors.green),
        _buildCell('يلبي أحيانًا\nالتوقعات',
            isHeader: true, color: Colors.yellow),
        _buildCell('غير مقبول\n', isHeader: true, color: Colors.red),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade, Color subjectColor) {
    Color exceedsColor = Colors.transparent;
    Color alwaysColor = Colors.transparent;
    Color sometimesColor = Colors.transparent;
    Color unacceptableColor = Colors.transparent;

    // تخصيص الألوان بناءً على الدرجة
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
        _buildCell(subject, color: subjectColor), // عرض المادة
        _buildCell('', color: exceedsColor), // عرض اللون بناءً على الدرجة
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
            color: isHeader ? Colors.black : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
