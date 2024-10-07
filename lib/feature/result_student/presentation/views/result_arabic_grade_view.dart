import 'package:flutter/material.dart';

import '../../data/model/execl_model.dart'; /////////////////////////////////////// change

class ResultArabicGradeView extends StatelessWidget {
  const ResultArabicGradeView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
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
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " ${student.studentName} : الاسم ",
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
                      curWidth < 600
                          ? const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('المسؤول الإداري: كارولين ثروت'),
                                SizedBox(height: 4),
                                Text('مشرفه المرحلة الابتدائية: أماني عديب'),
                                SizedBox(height: 4),
                                Text('مديره المدرسة: نسرين منجد'),
                              ],
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('المسؤول الإداري: كارولين ثروت'),
                                Text('مشرفة المرحلة الابتدائية: أماني عديب'),
                              ],
                            ),
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
            isHeader: true, color: const Color.fromARGB(255, 82, 116, 175)),
        _buildCell('Grade\n  ',
            isHeader: true, color: const Color.fromARGB(255, 82, 116, 175)),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade) {
    return TableRow(
      children: [
        _buildCell(subject, color: const Color.fromARGB(255, 82, 116, 175)),
        _buildCell(grade.toString(), color: Colors.white),
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
            color: isHeader ? Colors.black : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
