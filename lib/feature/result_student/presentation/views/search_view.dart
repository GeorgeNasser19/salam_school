import 'package:flutter/material.dart';
import 'package:salam_school/feature/result_student/presentation/views/passward_admin.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/search_square.dart';
import 'package:salam_school/feature/result_student/presentation/widgets/text_custom.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 247, 246, 246),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: isSmallScreen ? 50 : 0),

              // TextCustom with slide animation
              SlideTransition(
                position: _textCustomAnimation,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: isSmallScreen ? 0 : 100),
                      child: const TextCustom(),
                    ),
                    const Spacer(),

                    // Logo with slide animation
                    SlideTransition(
                      position: _logoAnimation,
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: isSmallScreen ? 0 : 100),
                        child: Image.asset(
                          "lib/assets/logo.jpg",
                          scale: isSmallScreen ? 10 : 3.5,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswardAdmin(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.three_p_outlined,
                        color: Color.fromARGB(251, 247, 246, 246),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isSmallScreen ? 50 : 0),

              // SearchSquare with slide animation
              SlideTransition(
                position: _searchSquareAnimation,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: isSmallScreen ? 0 : 50),
                    child: SearchSquare(
                      searchController: searchController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
