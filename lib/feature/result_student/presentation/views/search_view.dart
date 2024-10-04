import 'package:flutter/material.dart';
import 'package:salam_school/feature/result_student/presentation/views/passward_admin.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/search_square.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/text_custom.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  String? selectedYear;
  String? selectedCategory;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 247, 246, 246),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: TextCustom(),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Image.asset(
                        "lib/assets/logo.jpg",
                        scale: 3.5,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PasswardAdmin()),
                          );
                        },
                        icon: const Icon(Icons.three_p_outlined))
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: SearchSquare(
                      searchController: searchController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
