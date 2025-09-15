class PostComment {
  final int id;
  final int postId;
  final String commenterId;
  final String comment;
  final DateTime createdAt;

  // Optional nested relations if needed
  // For now, reference only by IDs; you can add nested User or Post objects if you fetch those
  // final User? commenter;
  // final Post? post;
  // final List<PostTag>? postTags;

  PostComment({
    required this.id,
    required this.postId,
    required this.commenterId,
    required this.comment,
    required this.createdAt,
    // this.commenter,
    // this.post,
    // this.postTags,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
    id: json['id'] as int,
    postId: json['postId'] as int,
    commenterId: json['commenterId'] as String,
    comment: json['comment'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    // commenter: json['commenter'] != null
    //     ? User.fromJson(json['commenter'] as Map<String, dynamic>)
    //     : null,
    // post: json['post'] != null
    //     ? Post.fromJson(json['post'] as Map<String, dynamic>)
    //     : null,
    // postTags: json['PostTags'] != null
    //     ? (json['PostTags'] as List<dynamic>)
    //         .map((e) => PostTag.fromJson(e as Map<String, dynamic>))
    //         .toList()
    //     : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'commenterId': commenterId,
    'comment': comment,
    'createdAt': createdAt.toIso8601String(),
    // 'commenter': commenter?.toJson(),
    // 'post': post?.toJson(),
    // 'PostTags': postTags?.map((e) => e.toJson()).toList(),
  };
}
