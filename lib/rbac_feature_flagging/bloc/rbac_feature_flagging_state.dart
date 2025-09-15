import 'package:alumni_management_application_new/rbac_feature_flagging/models/role.dart';
import 'package:equatable/equatable.dart';

// RBAC State
class RbacState extends Equatable {
  final Role? role;
  final bool loading;
  final String? error;

  const RbacState({this.role, this.loading = false, this.error});

  RbacState copyWith({Role? role, bool? loading, String? error}) {
    return RbacState(
      role: role ?? this.role,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [role, loading, error];
}






