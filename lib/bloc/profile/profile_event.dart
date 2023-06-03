part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileListEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfileAddEvent extends ProfileEvent {
  final ProfileModel profileModel;

  const ProfileAddEvent({required this.profileModel});

  @override
  List<Object?> get props => [profileModel];
}

class ProfileRemoveEvent extends ProfileEvent {
  final ProfileModel profileModel;

  const ProfileRemoveEvent({required this.profileModel});

  @override
  List<Object?> get props => [profileModel];
}
