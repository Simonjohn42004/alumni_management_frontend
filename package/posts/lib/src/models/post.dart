import 'package:posts/src/models/post_comments.dart';
import 'package:posts/src/models/post_count.dart';
import 'package:posts/src/models/post_like.dart';
import 'package:posts/src/models/post_save.dart';
import 'package:posts/src/models/post_tag.dart';

class Post {
  final int id;
  final String authorId;
  final DateTime createdAt;
  final List<String> mediaUrls;
  final Author author;
  final PostCount count;

  final List<PostTag>? postTags;
  final List<PostComment>? postComments;
  final List<PostLike>? postLikes;
  final List<PostSave>? postSaves;

  Post({
    required this.id,
    required this.authorId,
    required this.createdAt,
    required this.mediaUrls,
    required this.author,
    required this.count,
    this.postTags,
    this.postComments,
    this.postLikes,
    this.postSaves,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'] as int,
    authorId: json['authorId'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    mediaUrls: List<String>.from(json['media_urls'] ?? []),
    author: Author.fromJson(json['author'] as Map<String, dynamic>),
    count: PostCount.fromJson(json['_count'] as Map<String, dynamic>),
    postTags: json['postTags'] != null
        ? (json['postTags'] as List<dynamic>)
              .map((e) => PostTag.fromJson(e as Map<String, dynamic>))
              .toList()
        : null,
    postComments: json['postComments'] != null
        ? (json['postComments'] as List<dynamic>)
              .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
              .toList()
        : null,
    postLikes: json['postLikes'] != null
        ? (json['postLikes'] as List<dynamic>)
              .map((e) => PostLike.fromJson(e as Map<String, dynamic>))
              .toList()
        : null,
    postSaves: json['postSaves'] != null
        ? (json['postSaves'] as List<dynamic>)
              .map((e) => PostSave.fromJson(e as Map<String, dynamic>))
              .toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'authorId': authorId,
    'createdAt': createdAt.toIso8601String(),
    'media_urls': mediaUrls,
    'author': author.toJson(),
    '_count': count.toJson(),
    if (postTags != null) 'postTags': postTags!.map((e) => e.toJson()).toList(),
    if (postComments != null)
      'postComments': postComments!.map((e) => e.toJson()).toList(),
    if (postLikes != null)
      'postLikes': postLikes!.map((e) => e.toJson()).toList(),
    if (postSaves != null)
      'postSaves': postSaves!.map((e) => e.toJson()).toList(),
  };
}

class Author {
  final String fullName;
  final String department;

  Author({required this.fullName, required this.department});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    fullName: json['fullName'] as String,
    department: json['department'] as String,
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'department': department,
  };
}
