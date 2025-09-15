import 'package:alumni_management_application_new/rbac_feature_flagging/models/permissions.dart';

class Role {
  final int id; // 1-currentStudent,2-alumni,3-faculty,4-admin
  final String name;
  final List<Permission> permissions;

  Role({required this.id, required this.name, required this.permissions});

  factory Role.fromJson(Map<String, dynamic> json) {
    var perms = (json['permissions'] as List)
        .map((p) => Permission.fromJson(p))
        .toList();

    return Role(id: json['id'], name: json['name'], permissions: perms);
  }
}
