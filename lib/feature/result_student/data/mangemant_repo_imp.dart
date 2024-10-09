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

      // تحويل البيانات إلى Map
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // استخراج القيم
      String studentName = data['name'];
      String studentId = doc.id;
      String studentGrade = data['grade'];
      String studentLanguage = data['language'];

      // احصل على المجموع إذا وُجد
      double? total =
          data.containsKey('total') ? data['total']?.toDouble() : null;

      LinkedHashMap<String, double> subjects = LinkedHashMap();
      LinkedHashMap<String, double> additionalSubjects = LinkedHashMap();

      if (data.containsKey('subjects')) {
        Map<String, dynamic> subjectsData = data['subjects'];
        subjectsData.forEach((key, value) {
          // تحويل القيمة إلى double إذا كانت int أو String
          subjects[key] = (value is int)
              ? value.toDouble()
              : double.tryParse(value.toString()) ?? 0.0;
        });
      }

      if (data.containsKey('additional_subjects')) {
        Map<String, dynamic> additionalSubjectsData =
            data['additional_subjects'];
        additionalSubjectsData.forEach((key, value) {
          // تحويل القيمة إلى double إذا كانت int أو String
          additionalSubjects[key] = (value is int)
              ? value.toDouble()
              : double.tryParse(value.toString()) ?? 0.0;
        });
      }

      ExeclModel student = ExeclModel(
        studentId: studentId,
        studentName: studentName,
        grade: studentGrade,
        language: studentLanguage,
        total: total, // المجموع الذي تم الحصول عليه
        subjects: subjects,
        additionalSubjects: additionalSubjects,
      );

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

        List<String> subjectNames = [];
        List<String> additionalSubjectNames = [];
        double? total; // المجموع سيكون null إذا لم يوجد

        bool stopFound = false;
        bool stop2Found = false;

        // تحليل الصف الأول
        for (int i = 4; i < sheet.rows[0].length; i++) {
          String cellValue = sheet.rows[0][i]?.value.toString() ?? '';

          if (cellValue.toUpperCase() == 'STOP') {
            stopFound = true;
            continue; // تجاوز كلمة "STOP"
          }

          if (cellValue.toUpperCase() == 'STOP2') {
            stop2Found = true;
            continue; // تجاوز كلمة "STOP2"
          }

          if (!stopFound) {
            // قبل "STOP" هي المواد الأساسية
            subjectNames.add(cellValue);
          } else if (!stop2Found) {
            // بين "STOP" و "STOP2" هي المواد التي لا تضاف للمجموع
            additionalSubjectNames.add(cellValue);
          } else if (stop2Found && total == null) {
            // بعد "STOP2" هو المجموع فقط إذا لم يتم تعيينه بعد
            total = double.tryParse(cellValue) ?? 0;
          }
        }

        // معالجة الصفوف المتبقية
        for (var row in sheet.rows.skip(1)) {
          List<double> subjectValues = [];
          List<double> additionalSubjectValues = [];
          double? totalValue;

          bool stopFound = false;
          bool stop2Found = false;

          for (int i = 4; i < row.length; i++) {
            var cell = row[i]?.value;

            if (cell == null) continue;

            String cellValue = cell.toString();

            if (cellValue.toUpperCase() == 'STOP') {
              stopFound = true;
              continue;
            }

            if (cellValue.toUpperCase() == 'STOP2') {
              stop2Found = true;
              continue;
            }

            if (!stopFound) {
              // القيم الأساسية قبل "STOP"
              subjectValues.add(double.tryParse(cellValue) ?? 0.0);
            } else if (!stop2Found) {
              // القيم الإضافية بين "STOP" و "STOP2"
              additionalSubjectValues.add(double.tryParse(cellValue) ?? 0.0);
            } else if (stop2Found && totalValue == null) {
              // القيمة بعد "STOP2" هي المجموع
              totalValue = double.tryParse(cellValue) ?? 0.0;
            }
          }

          // بناء `ExeclModel` من البيانات المقروءة
          ExeclModel student = ExeclModel(
            studentId: row[0]?.value.toString() ?? '',
            studentName: row[1]?.value.toString() ?? '',
            grade: row[2]?.value.toString() ?? '',
            language: row[3]?.value.toString() ?? '',
            total: totalValue,
            subjects: LinkedHashMap.fromIterables(subjectNames, subjectValues),
            additionalSubjects: LinkedHashMap.fromIterables(
                additionalSubjectNames, additionalSubjectValues),
          );

          students.add(student);
          log('تم استخراج بيانات الطالب: ${student.toJson()}');

          await firestore
              .collection('grades')
              .doc(student.grade)
              .collection('languages')
              .doc(student.language)
              .collection('students')
              .doc(student.studentId)
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
