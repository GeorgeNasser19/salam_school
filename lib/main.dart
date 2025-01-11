import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salam_school/feature/result_student/data/mangemant_repo_imp.dart';
import 'package:salam_school/feature/result_student/presentation/cubits/fetch_data_cubit/cubit/fetch_data_cubit.dart';
import 'package:salam_school/firebase_options.dart';

import 'feature/result_student/presentation/views/search_view.dart';

  /// Initializes the Firebase app and then runs the app's widget tree.
  ///
  /// This function is the top-level entry point of the app, and is called when
  /// the app is launched. It initializes the Firebase app by calling
  /// [Firebase.initializeApp] with the platform-specific configuration options
  /// from [DefaultFirebaseOptions.currentPlatform].
  ///
  /// After initializing the Firebase app, it runs the app's widget tree by
  /// calling [runApp] with the top-level widget of the app, [MyApp].
  ///
  /// This function is marked as `async` because [Firebase.initializeApp] returns
  /// a [Future]. The function uses the `await` keyword to wait for the
  /// initialization to complete before running the app's widget tree.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salam School',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      themeMode: ThemeMode.light,
      routes: const {},
      home: BlocProvider(
        create: (context) =>
            FetchDataCubit(MangemantRepoImp(FirebaseFirestore.instance)),
        child: const SearchView(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
