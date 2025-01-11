import 'package:bloc/bloc.dart';
import 'package:salam_school/feature/result_student/presentation/cubits/fetch_data_cubit/cubit/fetch_data_state.dart';

import '../../../../data/mangemant_repo_imp.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit(this.mangemantRepoImp) : super(FetchDataStateInitial());

  final MangemantRepoImp mangemantRepoImp;

  /// Fetches data from the repository.
  ///
  /// Emits [FetchDataStateLoading] and then either
  /// [FetchDataStateSuccess] or [FetchDataStateFailure] based on the result.
  Future<void> fetchData(
      String studentID, String selectedYear, String selectedLanguage) async {
    emit(FetchDataStateLoading());

    final result = await mangemantRepoImp.fetchData(
        studentID, selectedYear, selectedLanguage);

    result.fold(
      (failure) => emit(FetchDataStateFailure(failure)),
      (student) => emit(FetchDataStateSuccess(student)),
    );
  }
}
