// Repository interface (you implement fetching from backend)
import 'package:alumni_management_application_new/rbac_feature_flagging/models/role.dart';

abstract class RbacRepository {
  Future<Role> fetchRoleWithPermissions(int roleId);
}
