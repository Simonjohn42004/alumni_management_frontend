import 'package:core/src/models/departments.dart';
import 'package:core/src/models/education.dart';
import 'package:posts/posts.dart';

class User {
  final String id;
  final int roleId;
  final String fullName;
  final String email;
  final String passwordHash;
  final String phoneNumber; // required
  final String? profilePicture;
  final int graduationYear;
  final String? currentPosition;
  final DateTime createdAt;
  final int collegeId;
  final Department department;
  final List<String> skillSets;

  final List<Education>? educations;
  final List<Post>? posts;
  final List<PostComment>? postComments;

  User({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.phoneNumber,
    this.profilePicture,
    required this.graduationYear,
    this.currentPosition,
    required this.createdAt,
    required this.collegeId,
    required this.department,
    required this.skillSets,
    this.educations,
    this.posts,
    this.postComments,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      roleId: json['roleId'] as int,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profilePicture'] as String?,
      graduationYear: json['graduationYear'] as int,
      currentPosition: json['currentPosition'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      collegeId: json['collegeId'] as int,
      department: (json['department'] as String).toDepartment(),
      skillSets: (json['skillSets'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      educations: json['educations'] != null
          ? (json['educations'] as List<dynamic>)
                .map((e) => Education.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      posts: json['posts'] != null
          ? (json['posts'] as List<dynamic>)
                .map((e) => Post.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      postComments: json['postComments'] != null
          ? (json['postComments'] as List<dynamic>)
                .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'graduationYear': graduationYear,
      'currentPosition': currentPosition,
      'createdAt': createdAt.toIso8601String(),
      'collegeId': collegeId,
      'department': department.toShortString(),
      'skillSets': skillSets,
      if (educations != null)
        'educations': educations!.map((e) => e.toJson()).toList(),
      if (posts != null) 'posts': posts!.map((e) => e.toJson()).toList(),
      if (postComments != null)
        'postComments': postComments!.map((e) => e.toJson()).toList(),
    };
  }

  User copyWith({
    String? id,
    int? roleId,
    String? fullName,
    String? email,
    String? passwordHash,
    String? phoneNumber,
    String? profilePicture,
    int? graduationYear,
    String? currentPosition,
    DateTime? createdAt,
    int? collegeId,
    Department? department,
    List<String>? skillSets,
    List<Education>? educations,
    List<Post>? posts,
    List<PostComment>? postComments,
  }) {
    return User(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      graduationYear: graduationYear ?? this.graduationYear,
      currentPosition: currentPosition ?? this.currentPosition,
      createdAt: createdAt ?? this.createdAt,
      collegeId: collegeId ?? this.collegeId,
      department: department ?? this.department,
      skillSets: skillSets ?? this.skillSets,
      educations: educations ?? this.educations,
      posts: posts ?? this.posts,
      postComments: postComments ?? this.postComments,
    );
  }
}
