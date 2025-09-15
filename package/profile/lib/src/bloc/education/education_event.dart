import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class EducationEvent extends Equatable {
  const EducationEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch all educations
class LoadEducations extends EducationEvent {}

// Event to fetch a single education by id
class LoadEducationById extends EducationEvent {
  final int id;

  const LoadEducationById(this.id);

  @override
  List<Object?> get props => [id];
}

// Event to create a new education entry
class CreateEducation extends EducationEvent {
  final Education education;

  const CreateEducation(this.education);

  @override
  List<Object?> get props => [education];
}

// Event to update existing education by id
class UpdateEducation extends EducationEvent {
  final int id;
  final Map<String, dynamic> updateData;

  const UpdateEducation(this.id, this.updateData);

  @override
  List<Object?> get props => [id, updateData];
}

// Event to delete education by id
class DeleteEducation extends EducationEvent {
  final int id;

  const DeleteEducation(this.id);

  @override
  List<Object?> get props => [id];
}
