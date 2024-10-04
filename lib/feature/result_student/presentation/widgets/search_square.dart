import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    'Year 1',
                    'Year 2',
                    'Year 3',
                    'Year 4', // سنة 4 لفتح القائمة المخفية
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
                      showSubCategoryDropdown = (selectedYear == 'Year 4');
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
                    'Category 1',
                    'Category 2',
                    'Category 3',
                    'Category 4'
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

            // القائمة المنسدلة الثالثة (مخفية افتراضيًا)
            if (showSubCategoryDropdown)
              DropdownButton<String>(
                value: selectedSubCategory,
                hint: const Text(
                  "Select Subcategory", // التسمية الجديدة للقائمة الثالثة
                  style: TextStyle(color: Colors.white70),
                ),
                dropdownColor: const Color(0xFF3C3F47),
                items: <String>[
                  'Subcategory 1',
                  'Subcategory 2',
                  'Subcategory 3',
                  'Subcategory 4'
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

            BlocBuilder<FetchDataCubit, FetchDataState>(
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
                  context
                      .read<FetchDataCubit>()
                      .fetchData(widget.searchController.text);
                  // الانتظار حتى يتم جلب البيانات
                  if (state is FetchDataStateSuccess) {
                    // تحقق من القيم المختارة للإنتقال إلى صفحة النتائج
                    if (selectedYear == "Year 1" &&
                        selectedCategory == "Category 1") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultEnglishView(
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
                child: state is FetchDataStateLoading
                    ? const CircularProgressIndicator()
                    : const Text("Search"),
              );
            })
          ],
        ),
      ),
    );
  }
}
