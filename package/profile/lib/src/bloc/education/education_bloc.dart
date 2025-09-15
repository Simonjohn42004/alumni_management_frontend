import 'package:core/core.dart';
import 'package:profile/src/bloc/education/education_event.dart';
import 'package:profile/src/bloc/education/education_state.dart';
import 'package:profile/src/service/profile_api_service.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final ProfileApiService apiService;

  EducationBloc({required this.apiService}) : super(EducationInitial()) {
    on<LoadEducations>(_onLoadEducations);
    on<LoadEducationById>(_onLoadEducationById);
    on<CreateEducation>(_onCreateEducation);
    on<UpdateEducation>(_onUpdateEducation);
    on<DeleteEducation>(_onDeleteEducation);
  }

  Future<void> _onLoadEducations(
    LoadEducations event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());
    try {
      final educations = await apiService.getAllEducations();
      emit(EducationsLoaded(educations));
    } catch (e) {
      emit(EducationFailure(e.toString()));
    }
  }

  Future<void> _onLoadEducationById(
    LoadEducationById event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());
    try {
      final education = await apiService.getEducationById(event.id);
      emit(EducationLoaded(education));
    } catch (e) {
      emit(EducationFailure(e.toString()));
    }
  }

  Future<void> _onCreateEducation(
    CreateEducation event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());
    try {
      final created = await apiService.createEducation(event.education);
      emit(EducationLoaded(created));
    } catch (e) {
      emit(EducationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateEducation(
    UpdateEducation event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());
    try {
      final updated = await apiService.updateEducation(
        event.id,
        event.updateData,
      );
      emit(EducationLoaded(updated));
    } catch (e) {
      emit(EducationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteEducation(
    DeleteEducation event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());
    try {
      await apiService.deleteEducation(event.id);
      emit(EducationOperationSuccess());
    } catch (e) {
      emit(EducationFailure(e.toString()));
    }
  }
}
