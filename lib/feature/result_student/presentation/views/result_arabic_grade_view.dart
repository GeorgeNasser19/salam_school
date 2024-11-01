import 'package:flutter/material.dart';
import '../../data/model/execl_model.dart';

class ResultArabicGradeView extends StatelessWidget {
  const ResultArabicGradeView({super.key, required this.student});

  final ExeclModel student;

  @override
  Widget build(BuildContext context) {
    final curWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = curWidth < 600;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: .9,
                child: Image.asset(
                  isSmallScreen
                      ? "lib/assets/Untitled design 2 .png"
                      : "lib/assets/Untitled design.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            SizedBox(
              width: isSmallScreen ? double.infinity : 1100,
              child: Padding(
                padding: isSmallScreen
                    ? const EdgeInsets.symmetric(horizontal: 16)
                    : const EdgeInsets.only(left: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: Text(
                          'تقرير التقدم - الفصل الدراسي الثاني 2024',
                          style: TextStyle(
                            color: isSmallScreen ? Colors.white : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: Text(
                          'congratulations\n${student.grade}',
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: Text(
                          "Salam School",
                          style: TextStyle(
                              fontSize: 22,
                              color:
                                  isSmallScreen ? Colors.white : Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: " الاسم :  ",
                                style: TextStyle(
                                    color: isSmallScreen
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: student.studentName,
                                style: TextStyle(
                                    color: isSmallScreen
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // جدول المواد الأساسية
                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: Table(
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
                      ),

                      if (student.total != null) ...[
                        const SizedBox(height: 16),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                          child: const Text(
                            ' المجموع الكلي',
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
                      const SizedBox(height: 16),

                      // قسم مواد خارج المجموع
                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: const Text(
                          'مواد خارج المجموع',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(right: isSmallScreen ? 0 : 40),
                        child: Table(
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
                      ),

                      const SizedBox(height: 16),
                      // عرض توقيع المديرة
                      isSmallScreen
                          ? const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'مديرة المدرسة: نسرين منجد',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 400),
                                  child: Text(
                                    'مديرة المدرسة : نسرين منجد',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell(
          'الماده\n  ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
        _buildCell(
          'الدرجه\n  ',
          isHeader: true,
          color: const Color.fromARGB(255, 164, 189, 233),
        ),
      ],
    );
  }

  TableRow _buildRow(String subject, double grade) {
    return TableRow(
      children: [
        _buildCell(subject, color: Colors.white),
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
