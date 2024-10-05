import 'dart:typed_data';

import 'package:dartz/dartz.dart';

abstract class MangemantRepo {
  Future<Either<String, dynamic>> setData(Uint8List filepath);
  Future<Either<String, dynamic>> fetchData(
      String studentID, String selectedYear, String selectedLanguage);
}
