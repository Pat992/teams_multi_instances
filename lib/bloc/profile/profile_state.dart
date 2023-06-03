part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final List<ProfileModel> profileModels;

  const ProfileSuccessState({required this.profileModels});

  @override
  List<Object?> get props => [profileModels];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileFailureState extends ProfileState {
  final FailureModel failureModel;

  const ProfileFailureState({required this.failureModel});

  @override
  List<Object?> get props => [failureModel];
}
