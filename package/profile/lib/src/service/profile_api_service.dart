import 'dart:convert';
import 'package:core/core.dart';
import 'package:core/core.dart' as http;

class ProfileApiService {
  final http.Client _client;

  ProfileApiService({http.Client? client}) : _client = client ?? http.Client();

  // Profile API Methods

  Future<User> createProfile(User user) async {
    final response = await _client.post(
      Uri.parse(Constants.profile),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create profile: ${response.body}');
    }
  }

  Future<List<User>> getAllProfiles() async {
    final response = await _client.get(Uri.parse(Constants.profile));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch profiles: ${response.body}');
    }
  }

  Future<User?> getProfileById(String id) async {
    final response = await _client.get(
      Uri.parse('${Constants.profileById}$id'),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to fetch profile $id: ${response.body}');
    }
  }

  Future<User> updateProfile(String id, Map<String, dynamic> updateData) async {
    final response = await _client.patch(
      Uri.parse('${Constants.profileById}$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updateData),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile $id: ${response.body}');
    }
  }

  Future<void> deleteProfile(String id) async {
    final response = await _client.delete(
      Uri.parse('${Constants.profileById}$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete profile $id: ${response.body}');
    }
  }

  // Education API Methods

  Future<Education> createEducation(Education education) async {
    final response = await _client.post(
      Uri.parse(Constants.educations),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(education.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Education.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create education: ${response.body}');
    }
  }

  Future<List<Education>> getAllEducations() async {
    final response = await _client.get(Uri.parse(Constants.educations));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Education.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch educations: ${response.body}');
    }
  }

  Future<Education> getEducationById(int id) async {
    final response = await _client.get(
      Uri.parse('${Constants.educationById}$id'),
    );
    if (response.statusCode == 200) {
      return Education.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch education $id: ${response.body}');
    }
  }

  Future<Education> updateEducation(
    int id,
    Map<String, dynamic> updateData,
  ) async {
    final response = await _client.patch(
      Uri.parse('${Constants.educationById}$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updateData),
    );
    if (response.statusCode == 200) {
      return Education.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update education $id: ${response.body}');
    }
  }

  Future<void> deleteEducation(int id) async {
    final response = await _client.delete(
      Uri.parse('${Constants.educationById}$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete education $id: ${response.body}');
    }
  }
}

