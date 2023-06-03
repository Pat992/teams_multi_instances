part of 'process_bloc.dart';

abstract class ProcessState extends Equatable {
  const ProcessState();
}

class ProcessInitial extends ProcessState {
  @override
  List<Object> get props => [];
}
