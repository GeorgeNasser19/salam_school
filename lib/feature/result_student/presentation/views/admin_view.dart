import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salam_school/feature/result_student/presentation/views/serch_view.dart';

import '../../data/mangemant_repo_imp.dart';
import '../cubits/fetch_data_cubit/cubit/fetch_data_cubit.dart';
import '../cubits/set_date_cubit/set_data_cubit.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key, required this.mangemantRepoImp});

  final MangemantRepoImp mangemantRepoImp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetDataCubit(mangemantRepoImp),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Admin View',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Excel File",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<SetDataCubit, SetDataState>(
                builder: (context, state) {
                  if (state is SetDataLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is SetDataFailure) {
                    return Column(
                      children: [
                        const Icon(Icons.close, color: Colors.red, size: 60),
                        const SizedBox(height: 10),
                        Text(
                          'Error: ${state.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    );
                  } else if (state is SetDataSuccess) {
                    return const Column(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 60),
                        SizedBox(height: 10),
                        Text(
                          'File uploaded successfully!',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['xlsx', 'xls']);

                        if (result != null) {
                          Uint8List? fileBytes = result.files.single.bytes;

                          if (fileBytes != null) {
                            // ignore: use_build_context_synchronously
                            context.read<SetDataCubit>().setData(fileBytes);
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No file selected.')),
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => FetchDataCubit(
                            MangemantRepoImp(FirebaseFirestore.instance)),
                        child: const SearchView(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_sharp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
