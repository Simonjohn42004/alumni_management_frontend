import 'dart:convert';
import 'package:alumni_management_application_new/rbac_feature_flagging/models/role.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/services/rbac_repo.dart';
import 'package:http/http.dart' as http;

class RbacApiService implements RbacRepository {
  final String baseUrl;
  final http.Client httpClient;

  RbacApiService({required this.baseUrl, http.Client? client})
    : httpClient = client ?? http.Client();

  @override
  Future<Role> fetchRoleWithPermissions(int roleId) async {
    final url = Uri.parse('$baseUrl/roles/$roleId/permissions');
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Role.fromJson(data);
    } else {
      throw Exception(
        'Failed to fetch RBAC permissions: ${response.reasonPhrase}',
      );
    }
  }
}
