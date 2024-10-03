import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/fetch_data_cubit/cubit/fetch_data_cubit.dart';
import 'result_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Enter Student ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final studentId = searchController.text;

                  context.read<FetchDataCubit>().fetchData(studentId);
                },
                child: const Text('Search'),
              ),
              const SizedBox(height: 20),
              // Using BlocBuilder to react to Cubit state changes
              BlocBuilder<FetchDataCubit, FetchDataState>(
                builder: (context, state) {
                  if (state is FetchDataStateLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is FetchDataStateSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultView(student: state.student),
                        ),
                      );
                    });
                    return const SizedBox();
                  } else if (state is FetchDataStateFailure) {
                    return Text(
                      'Error: ${state.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ));
  }
}
