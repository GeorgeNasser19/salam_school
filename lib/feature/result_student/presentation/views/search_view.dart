import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salam_school/feature/result_student/presentation/views/admin_view.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/search_square.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/text_custom.dart';

import '../../data/mangemant_repo_imp.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();

  // Animation Controllers and Animations for each component
  late AnimationController _logoController;
  late AnimationController _textCustomController;
  late AnimationController _searchSquareController;

  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _textCustomAnimation;
  late Animation<Offset> _searchSquareAnimation;
  final textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _textCustomController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _searchSquareController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Initialize animations with slight delay
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    _textCustomAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Start from the left
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textCustomController, curve: Curves.easeOut),
    );

    _searchSquareAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _searchSquareController, curve: Curves.easeOut),
    );

    // Start animations with delays
    Future.delayed(const Duration(milliseconds: 300), () {
      _textCustomController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _logoController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _searchSquareController.forward();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _logoController.dispose();
    _textCustomController.dispose();
    _searchSquareController.dispose();
    textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: .9,
                child: Image.asset(
                  isSmallScreen
                      ? "lib/assets/last edit small.png"
                      : "lib/assets/last edit.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: isSmallScreen ? 20 : 0,
                  ),
                  // TextCustom with slide animation
                  SlideTransition(
                    position: _textCustomAnimation,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: isSmallScreen ? 20 : 0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: isSmallScreen ? 0 : 100),
                              child: const TextCustom(),
                            ),
                          ],
                        ),
                        const Spacer(),

                        // Logo with slide animation
                        SlideTransition(
                          position: _logoAnimation,
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: isSmallScreen ? 0 : 0),
                            child: Image.asset(
                              "lib/assets/logo-removebg-preview.png",
                              scale: isSmallScreen ? 4.4 : 2.10,
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: .5,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Teacher Only "),
                                      actions: [
                                        Column(
                                          children: [
                                            TextField(
                                              controller: textcontroller,
                                              decoration: const InputDecoration(
                                                labelText: 'Password',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (textcontroller.text ==
                                                      "!999") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => AdminView(
                                                              mangemantRepoImp:
                                                                  MangemantRepoImp(
                                                                      FirebaseFirestore
                                                                          .instance)),
                                                        ));
                                                  }
                                                },
                                                child: const Text("go"))
                                          ],
                                        ),
                                      ],
                                    ));
                          },
                          icon: const Icon(
                            Icons.three_p_outlined,
                            color: Color.fromARGB(0, 32, 32, 32),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // SearchSquare with slide animation
                  SlideTransition(
                    position: _searchSquareAnimation,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: isSmallScreen ? 20 : 100,
                            ),
                            Text(
                              isSmallScreen
                                  ? "       Welcome \n   Salam School "
                                  : "Welcome to Salam\nSchool ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSmallScreen ? 30 : 60,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: isSmallScreen ? 30 : 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: isSmallScreen ? 0 : 130,
                              ),
                              child: isSmallScreen
                                  ? null
                                  : const Text(
                                      "At Salam School, We provide a nurturing environment for students\n thrive academically and socially. Our dedicated staff is committed to\n fostering a love for learing in every child ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            if (isSmallScreen)
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: SearchSquare(
                                  searchController: searchController,
                                ),
                              ),
                            SizedBox(
                              height: isSmallScreen ? 100 : 305,
                            )
                          ],
                        ),
                        if (!isSmallScreen)
                          Padding(
                            padding: const EdgeInsets.only(left: 150),
                            child: SearchSquare(
                              searchController: searchController,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
