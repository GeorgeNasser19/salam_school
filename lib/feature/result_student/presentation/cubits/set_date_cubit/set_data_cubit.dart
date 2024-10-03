import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/mangemant_repo_imp.dart';
import '../../../data/model/execl_model.dart';

part 'set_data_state.dart';

class SetDataCubit extends Cubit<SetDataState> {
  SetDataCubit(this.mangemantRepoImp) : super(SetDataInitial());

  final MangemantRepoImp mangemantRepoImp;

  Future<void> setData(Uint8List filepath) async {
    emit(SetDataLoading());

    final result = await mangemantRepoImp.setData(filepath);

    result.fold(
      (failure) => emit(SetDataFailure(failure)),
      (student) => emit(SetDataSuccess(student)),
    );
  }
}
