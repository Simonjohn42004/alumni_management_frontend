// RBAC Bloc
import 'package:alumni_management_application_new/rbac_feature_flagging/bloc/rbac_feature_flagging_event.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/bloc/rbac_feature_flagging_state.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/models/feature_name.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/models/permission_actions.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/models/permissions.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/models/role.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/services/rbac_repo.dart';
import 'package:bloc/bloc.dart';

class RbacBloc extends Bloc<RbacEvent, RbacState> {
  final RbacRepository _repository;

  RbacBloc(this._repository) : super(const RbacState(loading: false)) {
    on<LoadRbacEvent>(_onLoadRbac);
    on<ClearRbacEvent>((event, emit) => emit(RbacState()));
  }

  Future<void> _onLoadRbac(LoadRbacEvent event, Emitter<RbacState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      Role role = await _repository.fetchRoleWithPermissions(event.userRoleId);
      emit(state.copyWith(role: role, loading: false));
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: 'Failed to load RBAC data: ${e.toString()}',
        ),
      );
    }
  }

  bool hasPermission({
    required FeatureName feature,
    required PermissionAction action,
    bool isOwner = false,
  }) {
    final role = state.role;
    if (role == null) return false;
    try {
      final permission = role.permissions.firstWhere(
        (perm) => perm.feature == feature,
        orElse: () => Permission(
          feature: feature,
          canCreate: false,
          canRead: false,
          canUpdateOwn: false,
          canUpdateAny: false,
          canDeleteOwn: false,
          canDeleteAny: false,
        ),
      );

      switch (action) {
        case PermissionAction.create:
          return permission.canCreate;
        case PermissionAction.read:
          return permission.canRead;
        case PermissionAction.update:
          return isOwner
              ? permission.canUpdateOwn || permission.canUpdateAny
              : permission.canUpdateAny;
        case PermissionAction.delete:
          return isOwner
              ? permission.canDeleteOwn || permission.canDeleteAny
              : permission.canDeleteAny;
      }
    } catch (_) {
      return false;
    }
  }
}
