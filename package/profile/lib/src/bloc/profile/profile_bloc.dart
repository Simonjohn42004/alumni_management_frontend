import 'package:core/core.dart';
import 'package:profile/src/bloc/profile/profile_events.dart';
import 'package:profile/src/service/profile_api_service.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileApiService apiService;

  ProfileBloc({required this.apiService}) : super(ProfileInitial()) {
    on<LoadProfiles>(_onLoadProfiles);
    on<LoadProfileById>(_onLoadProfileById);
    on<CreateProfile>(_onCreateProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<DeleteProfile>(_onDeleteProfile);
  }

  Future<void> _onLoadProfiles(
    LoadProfiles event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final users = await apiService.getAllProfiles();
      emit(ProfilesLoaded(users));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onLoadProfileById(
    LoadProfileById event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await apiService.getProfileById(event.id);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileFailure('User not found'));
      }
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onCreateProfile(
    CreateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final newUser = await apiService.createProfile(event.user);
      emit(ProfileLoaded(newUser));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await apiService.updateProfile(event.id, event.updateData);
      final updatedUser = await apiService.getProfileById(event.id);
      if (updatedUser != null) {
        emit(ProfileLoaded(updatedUser));
      } else {
        emit(ProfileFailure('User not found'));
      }
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onDeleteProfile(
    DeleteProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await apiService.deleteProfile(event.id);
      emit(ProfileOperationSuccess());
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
