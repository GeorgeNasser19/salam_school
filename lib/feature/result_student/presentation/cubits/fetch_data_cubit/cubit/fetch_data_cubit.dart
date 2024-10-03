import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/mangemant_repo_imp.dart';
import '../../../../data/model/execl_model.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit(this.mangemantRepoImp) : super(FetchDataStateInitial());

  final MangemantRepoImp mangemantRepoImp;

  Future<void> fetchData(String studentId) async {
    emit(FetchDataStateLoading());

    final result = await mangemantRepoImp.fetchData(studentId);

    result.fold(
      (failure) => emit(FetchDataStateFailure(failure)),
      (student) => emit(FetchDataStateSuccess(student)),
    );
  }
}
