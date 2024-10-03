part of 'fetch_data_cubit.dart';

sealed class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

class FetchDataStateInitial extends FetchDataState {}

class FetchDataStateLoading extends FetchDataState {}

class FetchDataStateSuccess extends FetchDataState {
  final ExeclModel student;

  const FetchDataStateSuccess(this.student);

  @override
  List<Object> get props => [student];
}

class FetchDataStateFailure extends FetchDataState {
  final String error;

  const FetchDataStateFailure(this.error);

  @override
  List<Object> get props => [error];
}
