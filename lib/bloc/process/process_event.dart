part of 'process_bloc.dart';

abstract class ProcessEvent extends Equatable {
  const ProcessEvent();
}

class ProcessInitEvent extends ProcessEvent {
  @override
  List<Object?> get props => [];
}

class ProcessGetTeamsBaseDirectoryEvent extends ProcessEvent {
  @override
  List<Object?> get props => [];
}

class ProcessOpenDirectoryEvent extends ProcessEvent {
  final ProfileModel profileModel;

  const ProcessOpenDirectoryEvent({required this.profileModel});

  @override
  List<Object?> get props => [profileModel];
}

class ProcessMakeDirectoryEvent extends ProcessEvent {
  final ProfileModel profileModel;

  const ProcessMakeDirectoryEvent({required this.profileModel});

  @override
  List<Object?> get props => [profileModel];
}

class ProcessRemoveDirectoryEvent extends ProcessEvent {
  final ProfileModel profileModel;

  const ProcessRemoveDirectoryEvent({required this.profileModel});

  @override
  List<Object?> get props => [profileModel];
}

class ProcessLaunchTeamsEvent extends ProcessEvent {
  final ProfileModel profileModel;

  const ProcessLaunchTeamsEvent({required this.profileModel});

  @override
  List<Object?> get props => [profileModel];
}
