import 'dart:collection';

import 'package:excel/excel.dart';

class ExeclModel {
  final String studentId;
  final String studentName;
  final String grade;
  final String language;
  final double? total; // المجموع قد يكون null إذا لم يكن موجودًا
  final Map<String, double> subjects; // المواد الأساسية
  final Map<String, double> additionalSubjects; // المواد الإضافية

  ExeclModel({
    required this.studentId,
    required this.studentName,
    required this.grade,
    required this.language,
    this.total, // المجموع هنا قد يكون null
    required this.subjects,
    required this.additionalSubjects,
  });

  factory ExeclModel.fromExcelRow(List<Data?> row, List<String> subjectNames,
      List<String> additionalSubjectNames, double? total) {
    LinkedHashMap<String, double> subjects = LinkedHashMap();
    LinkedHashMap<String, double> additionalSubjects = LinkedHashMap();

    // معالجة المواد الأساسية
    for (int i = 0; i < subjectNames.length; i++) {
      double value = double.tryParse(row[i + 4]?.value.toString() ?? '0') ?? 0;
      subjects[subjectNames[i]] = value;
    }

    for (int i = 0; i < additionalSubjectNames.length; i++) {
      double value = double.tryParse(
              row[i + subjectNames.length + 4]?.value.toString() ?? '0') ??
          0;
      additionalSubjects[additionalSubjectNames[i]] = value;
    }

    return ExeclModel(
      studentId: row[0]?.value.toString() ?? '',
      studentName: row[1]?.value.toString() ?? '',
      grade: row[2]?.value.toString() ?? '',
      language: row[3]?.value.toString() ?? '',
      total: total, // المجموع إذا وُجد
      subjects: subjects,
      additionalSubjects: additionalSubjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'name': studentName,
      'grade': grade,
      'language': language,
      'total': total, // المجموع هنا سيكون اختياريًا
      'subjects': subjects,
      'additional_subjects': additionalSubjects,
    };
  }
}
