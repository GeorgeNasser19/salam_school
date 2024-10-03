import 'package:excel/excel.dart';

class ExeclModel {
  final String studentId;
  final String studentName;
  final int grade; // Add the grade field
  final Map<String, int> subjects;

  ExeclModel({
    required this.studentId,
    required this.studentName,
    required this.grade, // Include grade in constructor
    required this.subjects,
  });

  factory ExeclModel.fromExcelRow(List<Data?> row, List<String> subjectNames) {
    Map<String, int> subjects = {};

    for (int i = 0; i < subjectNames.length; i++) {
      subjects[subjectNames[i]] =
          int.tryParse(row[i + 3]?.value.toString() ?? '0') ??
              0; // Adjust index for subjects
    }

    return ExeclModel(
      studentId: row[0]?.value.toString() ?? '', // ID
      studentName: row[1]?.value.toString() ?? '', // Name
      grade: int.tryParse(row[2]?.value.toString() ?? '0') ?? 0, // Grade
      subjects: subjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'name': studentName,
      'grade': grade, // Include grade in JSON
      'subjects': subjects,
    };
  }
}
