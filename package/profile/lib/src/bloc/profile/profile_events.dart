import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch all profiles
class LoadProfiles extends ProfileEvent {}

// Event to fetch a single profile by id
class LoadProfileById extends ProfileEvent {
  final String id;

  const LoadProfileById(this.id);

  @override
  List<Object?> get props => [id];
}

// Event to create a new profile
class CreateProfile extends ProfileEvent {
  final User user;

  const CreateProfile(this.user);

  @override
  List<Object?> get props => [user];
}

// Event to update an existing profile by id with partial data
class UpdateProfile extends ProfileEvent {
  final String id;
  final Map<String, dynamic> updateData;

  const UpdateProfile(this.id, this.updateData);

  @override
  List<Object?> get props => [id, updateData];
}

// Event to delete a profile by id
class DeleteProfile extends ProfileEvent {
  final String id;

  const DeleteProfile(this.id);

  @override
  List<Object?> get props => [id];
}
