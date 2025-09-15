
// RBAC Events
import 'package:equatable/equatable.dart';

abstract class RbacEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRbacEvent extends RbacEvent {
  final int userRoleId; // e.g., 1,2,3,4

  LoadRbacEvent(this.userRoleId);

  @override
  List<Object?> get props => [userRoleId];
}

class ClearRbacEvent extends RbacEvent {}