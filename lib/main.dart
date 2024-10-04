import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salam_school/feature/result_student/data/mangemant_repo_imp.dart';
import 'package:salam_school/feature/result_student/presentation/cubits/fetch_data_cubit/cubit/fetch_data_cubit.dart';
import 'package:salam_school/firebase_options.dart';

import 'feature/result_student/presentation/views/search_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Result Management',
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
      },
    );
  }
}
