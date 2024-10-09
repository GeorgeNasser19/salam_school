import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_adby_view.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_arabic_view.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_3lmy_view.dart';
import 'package:salam_school/feature/result_student/presentation/views/result_english_view.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/text_field_costum.dart';

import '../cubits/fetch_data_cubit/cubit/fetch_data_cubit.dart';
import '../cubits/fetch_data_cubit/cubit/fetch_data_state.dart';
import '../views/result_arabic_grade_view.dart';

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
  String? selectedSubCategory;
  bool showSubCategoryDropdown = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      height: isSmallScreen ? 400 : 600,
      width: isSmallScreen ? screenWidth * 0.9 : 400,
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 7),
            blurRadius: 13,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, -3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hello ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedYear,
                      hint: const Text(
                        "Select Year",
                        style: TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
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
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue;
                          showSubCategoryDropdown =
                              (selectedYear == 'secondary 2');
                          if (!showSubCategoryDropdown) {
                            selectedSubCategory = null;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      hint: const Text(
                        "Select Category",
                        style: TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
                      items: <String>[
                        'عربي',
                        'english',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (showSubCategoryDropdown)
                DropdownButton<String>(
                  value: selectedSubCategory,
                  hint: const Text(
                    "Select Subcategory",
                    style: TextStyle(color: Colors.black),
                  ),
                  dropdownColor: Colors.white,
                  items: <String>[
                    'علمي',
                    'ادبي',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
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
                width: isSmallScreen ? screenWidth * 0.8 : 300,
                child:
                    TextfieldCustom(searchController: widget.searchController),
              ),
              const SizedBox(height: 40),
              BlocConsumer<FetchDataCubit, FetchDataState>(
                  listener: (context, state) {
                if (state is FetchDataStateSuccess) {
                  if (selectedCategory == "english") {
                    if ((selectedYear == "Grade 1" ||
                        selectedYear == "Grade 2" ||
                        selectedYear == "Grade 3" ||
                        selectedYear == "Grade 4" ||
                        selectedYear == "Grade 5" ||
                        selectedYear == "Grade 6" ||
                        selectedYear == "KG 1" ||
                        selectedYear == "KG 2")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultEnglishView(
                            student: state.student,
                          ),
                        ),
                      );
                    } else if (selectedYear == "preparatory 1" ||
                        selectedYear == "preparatory 2" ||
                        selectedYear == "secondary 1") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultArabicGradeView(
                            student: state.student,
                          ),
                        ),
                      );
                    } else if (selectedYear == "secondary 2" &&
                        selectedSubCategory == "علمي") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Result3mlyView(
                            student: state.student,
                          ),
                        ),
                      );
                    }
                  } else if (selectedCategory == "عربي") {
                    if ((selectedYear == "Grade 1" ||
                        selectedYear == "Grade 2" ||
                        selectedYear == "Grade 3" ||
                        selectedYear == "Grade 4" ||
                        selectedYear == "Grade 5" ||
                        selectedYear == "Grade 6" ||
                        selectedYear == "KG 1" ||
                        selectedYear == "KG 2")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultArabicView(
                            student: state.student,
                          ),
                        ),
                      );
                    } else if (selectedYear == "preparatory 1" ||
                        selectedYear == "preparatory 2" ||
                        selectedYear == "secondary 1") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultArabicGradeView(
                            student: state.student,
                          ),
                        ),
                      );
                    } else if (selectedYear == "secondary 2" &&
                        selectedSubCategory == "علمي") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Result3mlyView(
                            student: state.student,
                          ),
                        ),
                      );
                    } else if (selectedYear == "secondary 2" &&
                        selectedSubCategory == "ادبي") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultAdbyView(
                            student: state.student,
                          ),
                        ),
                      );
                    }
                  }
                } else if (state is FetchDataStateFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: ${state.error}'),
                    backgroundColor: Colors.red,
                  ));
                }
              }, builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      if (selectedYear == null ||
                          selectedCategory == null ||
                          (showSubCategoryDropdown &&
                              selectedSubCategory == null) ||
                          widget.searchController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'يجب اختيار جميع الخيارات وملء حقل البحث قبل المتابعة'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }

                      if (state is! FetchDataStateLoading) {
                        context.read<FetchDataCubit>().fetchData(
                            widget.searchController.text,
                            selectedYear!,
                            selectedCategory!);
                      }
                    },
                    child: state is FetchDataStateLoading
                        ? const CircularProgressIndicator()
                        : const Text("Search",
                            style: TextStyle(color: Colors.black)));
              })
            ],
          ),
        ),
      ),
    );
  }
}
