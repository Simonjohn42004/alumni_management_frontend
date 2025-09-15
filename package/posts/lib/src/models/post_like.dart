class PostLike {
  final int postId;
  final String userId;
  final DateTime likedAt;

  // Optional nested relations if needed:
  // final Post? post;
  // final User? user;

  PostLike({
    required this.postId,
    required this.userId,
    required this.likedAt,
    // this.post,
    // this.user,
  });

  factory PostLike.fromJson(Map<String, dynamic> json) => PostLike(
    postId: json['postId'] as int,
    userId: json['userId'] as String,
    likedAt: DateTime.parse(json['likedAt'] as String),
    // post: json['post'] != null
    //     ? Post.fromJson(json['post'] as Map<String, dynamic>)
    //     : null,
    // user: json['user'] != null
    //     ? User.fromJson(json['user'] as Map<String, dynamic>)
    //     : null,
  );

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'userId': userId,
    'likedAt': likedAt.toIso8601String(),
    // 'post': post?.toJson(),
    // 'user': user?.toJson(),
  };
}
