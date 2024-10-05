import 'dart:collection';

import 'package:excel/excel.dart';

class ExeclModel {
  final String studentId;
  final String studentName;
  final String grade;
  final String language;
  final LinkedHashMap<String, double> subjects;

  // Updated constructor to have all fields in curly braces for consistency
  ExeclModel({
    required this.studentId,
    required this.studentName,
    required this.grade,
    required this.language,
    required this.subjects,
  });

  factory ExeclModel.fromExcelRow(List<Data?> row, List<String> subjectNames) {
    LinkedHashMap<String, double> subjects = LinkedHashMap();

    for (int i = 0; i < subjectNames.length; i++) {
      double value = double.tryParse(row[i + 4]?.value.toString() ?? '0') ?? 0;
      subjects[subjectNames[i]] =
          double.parse(value.toStringAsFixed(1)); // تحويل القيمة إلى int
    }

    return ExeclModel(
      studentId: row[0]?.value.toString() ?? '', // ID
      studentName: row[1]?.value.toString() ?? '', // Name
      grade: row[2]?.value.toString() ?? '', // Grade
      language: row[3]?.value.toString() ?? '', // Language
      subjects: subjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'name': studentName,
      'grade': grade,
      'subjects': subjects,
      'language': language, // Language field in JSON
    };
  }
}
