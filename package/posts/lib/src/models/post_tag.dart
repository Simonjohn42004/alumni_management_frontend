class PostTag {
  final int id;
  final int postId;
  final int? commentId;
  final String taggedUserId;
  final String taggedBy;
  final DateTime taggedAt;

  // Optional nested relations if needed:
  // final Post? post;
  // final PostComment? comment;
  // final User? taggedUser;
  // final User? taggedByUser;

  PostTag({
    required this.id,
    required this.postId,
    this.commentId,
    required this.taggedUserId,
    required this.taggedBy,
    required this.taggedAt,
    // this.post,
    // this.comment,
    // this.taggedUser,
    // this.taggedByUser,
  });

  factory PostTag.fromJson(Map<String, dynamic> json) => PostTag(
    id: json['id'] as int,
    postId: json['postId'] as int,
    commentId: json['commentId'] as int?,
    taggedUserId: json['taggedUserId'] as String,
    taggedBy: json['taggedBy'] as String,
    taggedAt: DateTime.parse(json['taggedAt'] as String),
    // post: json['post'] != null
    //     ? Post.fromJson(json['post'] as Map<String, dynamic>)
    //     : null,
    // comment: json['comment'] != null
    //     ? PostComment.fromJson(json['comment'] as Map<String, dynamic>)
    //     : null,
    // taggedUser: json['taggedUser'] != null
    //     ? User.fromJson(json['taggedUser'] as Map<String, dynamic>)
    //     : null,
    // taggedByUser: json['taggedByUser'] != null
    //     ? User.fromJson(json['taggedByUser'] as Map<String, dynamic>)
    //     : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'commentId': commentId,
    'taggedUserId': taggedUserId,
    'taggedBy': taggedBy,
    'taggedAt': taggedAt.toIso8601String(),
    // 'post': post?.toJson(),
    // 'comment': comment?.toJson(),
    // 'taggedUser': taggedUser?.toJson(),
    // 'taggedByUser': taggedByUser?.toJson(),
  };
}
