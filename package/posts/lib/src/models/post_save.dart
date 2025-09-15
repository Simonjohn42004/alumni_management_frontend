class PostSave {
  final int postId;
  final String savedBy;
  final DateTime savedAt;

  // Optional nested relations if needed:
  // final Post? post;
  // final User? user;

  PostSave({
    required this.postId,
    required this.savedBy,
    required this.savedAt,
    // this.post,
    // this.user,
  });

  factory PostSave.fromJson(Map<String, dynamic> json) => PostSave(
        postId: json['postId'] as int,
        savedBy: json['savedBy'] as String,
        savedAt: DateTime.parse(json['savedAt'] as String),
        // post: json['post'] != null
        //     ? Post.fromJson(json['post'] as Map<String, dynamic>)
        //     : null,
        // user: json['user'] != null
        //     ? User.fromJson(json['user'] as Map<String, dynamic>)
        //     : null,
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'savedBy': savedBy,
        'savedAt': savedAt.toIso8601String(),
        // 'post': post?.toJson(),
        // 'user': user?.toJson(),
      };
}
