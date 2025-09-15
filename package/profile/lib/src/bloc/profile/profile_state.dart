import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// Initial state when nothing has happened yet
class ProfileInitial extends ProfileState {}

// Loading state for async operations (fetching, updating, deleting)
class ProfileLoading extends ProfileState {}

// Loaded state for when a single user profile is fetched successfully
class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

// Loaded state for when multiple profiles are fetched successfully
class ProfilesLoaded extends ProfileState {
  final List<User> users;

  const ProfilesLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

// State when an operation (create, update, delete) succeeds but no specific data to return
class ProfileOperationSuccess extends ProfileState {}

// State when an operation fails, with optional error message
class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}
