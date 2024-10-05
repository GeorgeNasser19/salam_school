// import 'dart:collection';
// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:excel/excel.dart';
// import 'package:dartz/dartz.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../domain/mangemant_repo.dart';
// import 'model/execl_model.dart';

// class MangemantRepoImp extends MangemantRepo {
//   final FirebaseFirestore firestore;
//   MangemantRepoImp(this.firestore);

//   @override
//   Future<Either<String, ExeclModel>> fetchData(String studentID) async {
//     try {
//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection('students')
//           .doc(studentID)
//           .get();

//       if (!doc.exists) {
//         return const Left('Student not found.');
//       }

//       String studentName = doc['name'];
//       String studentId = doc.id;
//       String studentGrade = doc['grade'];

//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       LinkedHashMap<String, double> subjects = LinkedHashMap();

//       if (data.containsKey('subjects')) {
//         Map<String, dynamic> subjectsData = data['subjects'];
//         subjectsData.forEach((key, value) {
//           // Convert to int
//           subjects[key] = (value is int)
//               ? value.toDouble()
//               : double.tryParse(value.toString()) ?? 0.0;
//         });
//       }

//       ExeclModel student = ExeclModel(
//         studentId: studentId,
//         studentName: studentName,
//         grade: studentGrade,
//         subjects: subjects,
//       );

//       return Right(student);
//     } catch (e) {
//       log("Error fetching student data: $e");
//       return Left("Error fetching student data: $e");
//     }
//   }

//   @override
//   Future<Either<String, List<ExeclModel>>> setData(Uint8List filepath) async {
//     try {
//       var excel = Excel.decodeBytes(filepath);
//       List<ExeclModel> students = [];

//       for (var table in excel.tables.keys) {
//         var sheet = excel.tables[table];
//         if (sheet == null) {
//           return Left('Sheet $table is null or empty.');
//         }

//         List<String> subjectNames = sheet.rows[0]
//             .skip(3) // Skip ID, Name, and Grade columns
//             .map((cell) => cell?.value.toString() ?? '')
//             .toList();

//         for (var row in sheet.rows.skip(1)) {
//           ExeclModel student = ExeclModel.fromExcelRow(row, subjectNames);
//           students.add(student);
//           log('Extracted Student: ${student.toJson()}');

//           await FirebaseFirestore.instance
//               .collection('students')
//               .doc(student.studentId)
//               .set(student.toJson());
//         }
//       }

//       return Right(students);
//     } catch (e) {
//       log("Error uploading file: $e");
//       return Left("Error uploading file: $e");
//     }
//   }
// }
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
  Future<Either<String, ExeclModel>> fetchData(
      String studentID, String selectedYear, String selectedLanguage) async {
    try {
      // سجل البيانات التي سيتم البحث عنها
      log("Searching for student in year: $selectedYear, language: $selectedLanguage, student ID: $studentID");

      DocumentSnapshot doc = await firestore
          .collection('grades')
          .doc(selectedYear)
          .collection('languages')
          .doc(selectedLanguage)
          .collection('students')
          .doc(studentID)
          .get();
      log("Path being queried: grades/$selectedYear/languages/$selectedLanguage/students/$studentID");

      if (!doc.exists) {
        log("Student not found in year $selectedYear and language $selectedLanguage.");
        return const Left('الطالب غير موجود.');
      }

      // استخراج البيانات من الوثيقة
      log("Document found, extracting data...");

      String studentName = doc['name'];
      String studentId = doc.id;
      String studentGrade = doc['grade'];
      String studentLanguage = doc['language'];

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      LinkedHashMap<String, double> subjects = LinkedHashMap();

      if (data.containsKey('subjects')) {
        Map<String, dynamic> subjectsData = data['subjects'];
        subjectsData.forEach((key, value) {
          subjects[key] = (value is int)
              ? value.toDouble()
              : double.tryParse(value.toString()) ?? 0.0;
        });
      }

      ExeclModel student = ExeclModel(
          studentId: studentId,
          studentName: studentName,
          grade: studentGrade,
          language: studentLanguage,
          subjects: subjects);

      log("Student data successfully extracted.");
      return Right(student);
    } catch (e) {
      log("Error fetching student data: $e");
      return Left("خطأ في جلب بيانات الطالب: $e");
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
          return Left('ورقة العمل $table فارغة أو غير موجودة.');
        }

        // Skip ID, Name, Grade, and Language columns
        List<String> subjectNames = sheet.rows[0]
            .skip(4)
            .map((cell) => cell?.value.toString() ?? '')
            .toList();

        for (var row in sheet.rows.skip(1)) {
          ExeclModel student = ExeclModel.fromExcelRow(row, subjectNames);
          students.add(student);
          log('تم استخراج بيانات الطالب: ${student.toJson()}');

          // Structure: /grade/{grade}/language/{language}/students/{studentId}
          await firestore
              .collection('grades') // Use collection for grade
              .doc(student.grade) // Use grade document
              .collection('languages') // Collection for languages
              .doc(student.language) // Use language document
              .collection('students') // Collection for students
              .doc(student.studentId) // Document for student
              .set(student.toJson());
        }
      }

      return Right(students);
    } catch (e) {
      log("خطأ في تحميل الملف: $e");
      return Left("خطأ في تحميل الملف: $e");
    }
  }
}
