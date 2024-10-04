import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_adby_view.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_arabic_grade_view';
import 'package:salam_school/feature/result_student/presentation/views/result_arabic_view.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_3lmy_view.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_english_view.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/text_field_costum.dart';

import '../cubits/fetch_data_cubit/cubit/fetch_data_cubit.dart';
import '../cubits/fetch_data_cubit/cubit/fetch_data_state.dart';

class SearchSquare extends StatefulWidget {
  const SearchSquare({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  State<SearchSquare> createState() => _SearchSquareState();
}

class _SearchSquareState extends State<SearchSquare> {
  String? selectedYear;
  String? selectedCategory;
  String? selectedSubCategory; // القائمة المنسدلة الثالثة

  bool showSubCategoryDropdown = false; // للتحكم في إظهار القائمة الثالثة

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // تعديل الارتفاع ليناسب القائمة الإضافية
      width: 400,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2D42),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 8),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello  ^_^ ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedYear,
                  hint: const Text(
                    "Select Year",
                    style: TextStyle(color: Colors.white70),
                  ),
                  dropdownColor: const Color(0xFF3C3F47),
                  items: <String>[
                    'KG 1',
                    'KG 2',
                    'Grade 1',
                    'Grade 2',
                    'Grade 3',
                    'Grade 4',
                    'Grade 5',
                    'Grade 6',
                    'preparatory 1',
                    'preparatory 2',
                    'secondary 1',
                    'secondary 2',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue;
                      showSubCategoryDropdown = (selectedYear == 'secondary 2');
                      if (!showSubCategoryDropdown) {
                        selectedSubCategory = null; // إعادة تعيين القيمة
                      }
                    });
                  },
                ),
                const SizedBox(width: 20), // مساحة بين القائمتين
                DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text(
                    "Select Category",
                    style: TextStyle(color: Colors.white70),
                  ),
                  dropdownColor: const Color(0xFF3C3F47),
                  items: <String>[
                    'عربي',
                    'English',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (showSubCategoryDropdown)
              DropdownButton<String>(
                value: selectedSubCategory,
                hint: const Text(
                  "Select Subcategory",
                  style: TextStyle(color: Colors.white70),
                ),
                dropdownColor: const Color(0xFF3C3F47),
                items: <String>[
                  'علمي',
                  'ادبي',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSubCategory = newValue;
                  });
                },
              ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: TextfieldCustom(searchController: widget.searchController),
            ),
            const SizedBox(height: 40),
            BlocConsumer<FetchDataCubit, FetchDataState>(
              listener: (context, state) {
                if (state is FetchDataStateSuccess) {
                  if (selectedYear == "Grade 1" ||
                      selectedYear == "Grade 2" ||
                      selectedYear == "Grade 3" ||
                      selectedYear == "Grade 4" ||
                      selectedYear == "Grade 5" ||
                      selectedYear == "Grade 6" ||
                      selectedYear == "KG 1" ||
                      selectedYear == "KG 2" && selectedCategory == "English") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultEnglishView(
                          student: state
                              .student, // تأكد من وجود student في حالة النجاح
                        ),
                      ),
                    );
                  } else if (selectedYear == "Grade 1" ||
                      selectedYear == "Grade 2" ||
                      selectedYear == "Grade 3" ||
                      selectedYear == "Grade 4" ||
                      selectedYear == "Grade 5" ||
                      selectedYear == "Grade 6" ||
                      selectedYear == "KG 1" ||
                      selectedYear == "KG 2" && selectedCategory == "عربي") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultArabicView(
                          student: state
                              .student, // تأكد من وجود student في حالة النجاح
                        ),
                      ),
                    );
                  }
                  if (selectedYear == "preparatory 1" ||
                      selectedYear == "preparatory 2" ||
                      selectedYear == "secondary 1" &&
                          selectedCategory == "عربي" ||
                      selectedCategory == "English") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultArabicGradeView(
                          student: state
                              .student, // تأكد من وجود student في حالة النجاح
                        ),
                      ),
                    );
                  }
                  if (selectedYear == "secondary 2" &&
                          selectedSubCategory == "علمي" &&
                          selectedCategory == "عربي" ||
                      selectedCategory == "English") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Result3mlyView(
                          student: state
                              .student, // تأكد من وجود student في حالة النجاح
                        ),
                      ),
                    );
                  }
                  if (selectedYear == "secondary 2" &&
                      selectedSubCategory == "ادبي" &&
                      selectedCategory == "عربي") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultAdbyView(
                          student: state
                              .student, // تأكد من وجود student في حالة النجاح
                        ),
                      ),
                    );
                  }
                } else if (state is FetchDataStateFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: ${state.error}'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (selectedYear == null ||
                        selectedCategory == null ||
                        (showSubCategoryDropdown &&
                            selectedSubCategory == null) ||
                        widget.searchController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'يجب اختيار جميع الخيارات وملء حقل البحث قبل المتابعة'),
                        backgroundColor: Colors.red,
                      ));
                      return; // منع الانتقال في حالة عدم اختيار كل الخيارات أو فارغ
                    }

                    if (state is! FetchDataStateLoading) {
                      context
                          .read<FetchDataCubit>()
                          .fetchData(widget.searchController.text);
                    }
                  },
                  child: state is FetchDataStateLoading
                      ? const CircularProgressIndicator()
                      : const Text("Search"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
