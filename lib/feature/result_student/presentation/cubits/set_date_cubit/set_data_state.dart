part of 'set_data_cubit.dart';

abstract class SetDataState extends Equatable {
  const SetDataState();

  @override
  List<Object> get props => [];
}

class SetDataInitial extends SetDataState {}

class SetDataLoading extends SetDataState {}

class SetDataSuccess extends SetDataState {
  final List<ExeclModel> students;

  const SetDataSuccess(this.students);

  @override
  List<Object> get props => [students];
}

class SetDataFailure extends SetDataState {
  final String error;

  const SetDataFailure(this.error);

  @override
  List<Object> get props => [error];
}
