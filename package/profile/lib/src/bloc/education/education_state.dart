import 'package:core/core.dart';
import 'package:equatable/equatable.dart';


abstract class EducationState extends Equatable {
  const EducationState();

  @override
  List<Object?> get props => [];
}

// Initial idle state before any action
class EducationInitial extends EducationState {}

// Loading state during async operations
class EducationLoading extends EducationState {}

// State when a single education record is loaded
class EducationLoaded extends EducationState {
  final Education education;

  const EducationLoaded(this.education);

  @override
  List<Object?> get props => [education];
}

// State when multiple education records are loaded
class EducationsLoaded extends EducationState {
  final List<Education> educations;

  const EducationsLoaded(this.educations);

  @override
  List<Object?> get props => [educations];
}

// State indicating successful create, update or delete operation without specific data
class EducationOperationSuccess extends EducationState {}

// State representing failure with an error message
class EducationFailure extends EducationState {
  final String message;

  const EducationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
