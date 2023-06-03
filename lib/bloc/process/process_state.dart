part of 'process_bloc.dart';

abstract class ProcessState extends Equatable {
  const ProcessState();
}

class ProcessInitial extends ProcessState {
  @override
  List<Object> get props => [];
}

class ProcessLoadingState extends ProcessState {
  @override
  List<Object?> get props => [];
}

class ProcessFailureState extends ProcessState {
  final FailureModel failureModel;

  const ProcessFailureState({required this.failureModel});

  @override
  List<Object?> get props => [failureModel];
}

class ProcessGetTeamsBaseDirectoryState extends ProcessState {
  final String path;

  const ProcessGetTeamsBaseDirectoryState({required this.path});

  @override
  List<Object?> get props => [path];
}

class ProcessSuccessState extends ProcessState {
  @override
  List<Object?> get props => [];
}

class ProcessMakeDirectorySuccessState extends ProcessState {
  @override
  List<Object?> get props => [];
}

class ProcessRemoveDirectorySuccessState extends ProcessState {
  @override
  List<Object?> get props => [];
}
