import 'package:flutter/material.dart';
import '../../data/model/execl_model.dart';

class ResultArabicGradeView extends StatelessWidget {
  const ResultArabicGradeView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width.toInt();
    return Directionality(
      textDirection: TextDirection.rtl,
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
                            fontSize: 22,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "الاسم: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: student.studentName,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // جدول المواد الأساسية
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
                        if (student.total != null) ...[
                          const SizedBox(height: 16),
                          const Text(
                            ' المجموع الكلي',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 164, 189, 233), // لون الخلفية
                              borderRadius:
                                  BorderRadius.circular(10), // زوايا دائرية
                              border: Border.all(
                                color: Colors.black, // لون الحد
                                width: 2, // عرض الحد
                              ),
                            ),
                            child: Center(
                              child: Text(
                                student.total.toString(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        // قسم مواد خارج المجموع
                        const Text(
                          'مواد خارج المجموع',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                          },
                          children: [
                            _buildHeaderRow(),
                            ...student.additionalSubjects.entries.map((entry) {
                              return _buildRow(
                                entry.key,
                                entry.value.toDouble(),
                              );
                            })
                          ],
                        ),
                        const SizedBox(height: 16),
                        // عرض المجموع

                        const SizedBox(height: 16),
                        curWidth < 600
                            ? const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'المسؤول الإداري: كارولين ثروت',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'مشرفة المرحلة الابتدائية: أماني عديب',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'مديرة المدرسة: نسرين منجد',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            : const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   'المسؤول الإداري: كارولين ثروت',
                                  //   style:
                                  //       TextStyle(fontWeight: FontWeight.bold),
                                  // ),
                                  Text(
                                    'مديرة المدرسة: نسرين منجد',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  // Text(
                                  //   'مشرفة المرحلة الابتدائية: أماني عديب',
                                  //   style:
                                  //       TextStyle(fontWeight: FontWeight.bold),
                                  // ),
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
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell('الماده\n  ',
            isHeader: true, color: const Color.fromARGB(255, 164, 189, 233)),
        _buildCell('الدرجه\n  ',
            isHeader: true, color: const Color.fromARGB(255, 164, 189, 233)),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade) {
    return TableRow(
      children: [
        _buildCell(
          subject,
          color: Colors.white,
        ),
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
