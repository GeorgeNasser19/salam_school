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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
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
                SizedBox(
                  height: isSmallScreen ? 50 : 0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: isSmallScreen ? 0 : 100),
                      child: const TextCustom(),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: isSmallScreen ? 0 : 100),
                      child: Image.asset(
                        "lib/assets/logo.jpg",
                        scale: isSmallScreen ? 10 : 3.5,
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
                        icon: const Icon(
                          Icons.three_p_outlined,
                          color: Color.fromARGB(251, 247, 246, 246),
                        ))
                  ],
                ),
                SizedBox(
                  height: isSmallScreen ? 50 : 0,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: isSmallScreen ? 0 : 50),
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
