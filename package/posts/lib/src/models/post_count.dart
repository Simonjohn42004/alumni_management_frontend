class PostCount {
  final int postLikes;
  final int postComments;
  final int postSaves;

  PostCount({
    required this.postLikes,
    required this.postComments,
    required this.postSaves,
  });

  factory PostCount.fromJson(Map<String, dynamic> json) => PostCount(
    postLikes: json['postLikes'] as int,
    postComments: json['postComments'] as int,
    postSaves: json['postSaves'] as int,
  );

  Map<String, dynamic> toJson() => {
    'postLikes': postLikes,
    'postComments': postComments,
    'postSaves': postSaves,
  };
}
