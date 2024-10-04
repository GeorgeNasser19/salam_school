import 'dart:collection';
import 'dart:developer';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/mangemant_repo.dart';
import 'model/execl_model.dart';

class MangemantRepoImp extends MangemantRepo {
  final FirebaseFirestore firestore;
  MangemantRepoImp(this.firestore);

  @override
  Future<Either<String, ExeclModel>> fetchData(String studentID) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('students')
          .doc(studentID)
          .get();

      if (!doc.exists) {
        return const Left('Student not found.');
      }

      String studentName = doc['name'];
      String studentId = doc.id;
      int studentGrade = doc['grade'];

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      LinkedHashMap<String, double> subjects = LinkedHashMap();

      if (data.containsKey('subjects')) {
        Map<String, dynamic> subjectsData = data['subjects'];
        subjectsData.forEach((key, value) {
          // Convert to int
          subjects[key] = (value is int)
              ? value.toDouble()
              : double.tryParse(value.toString()) ?? 0.0;
        });
      }

      ExeclModel student = ExeclModel(
        studentId: studentId,
        studentName: studentName,
        grade: studentGrade,
        subjects: subjects,
      );

      return Right(student);
    } catch (e) {
      log("Error fetching student data: $e");
      return Left("Error fetching student data: $e");
    }
  }

  @override
  Future<Either<String, List<ExeclModel>>> setData(Uint8List filepath) async {
    try {
      var excel = Excel.decodeBytes(filepath);
      List<ExeclModel> students = [];

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet == null) {
          return Left('Sheet $table is null or empty.');
        }

        List<String> subjectNames = sheet.rows[0]
            .skip(3) // Skip ID, Name, and Grade columns
            .map((cell) => cell?.value.toString() ?? '')
            .toList();

        for (var row in sheet.rows.skip(1)) {
          ExeclModel student = ExeclModel.fromExcelRow(row, subjectNames);
          students.add(student);
          log('Extracted Student: ${student.toJson()}');

          await FirebaseFirestore.instance
              .collection('students')
              .doc(student.studentId)
              .set(student.toJson());
        }
      }

      return Right(students);
    } catch (e) {
      log("Error uploading file: $e");
      return Left("Error uploading file: $e");
    }
  }
}
