part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileListEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfileAddEvent extends ProfileEvent {
  final List<ProfileModel> profileModels;

  const ProfileAddEvent({required this.profileModels});

  @override
  List<Object?> get props => [profileModels];
}

class ProfileRemoveEvent extends ProfileEvent {
  final List<ProfileModel> profileModels;

  const ProfileRemoveEvent({required this.profileModels});

  @override
  List<Object?> get props => [profileModels];
}
