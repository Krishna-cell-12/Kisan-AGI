class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final String? imageUrl;
  final int upvotes;
  final int replies;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    this.imageUrl,
    required this.upvotes,
    required this.replies,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'userName': userName,
    'content': content,
    'imageUrl': imageUrl,
    'upvotes': upvotes,
    'replies': replies,
    'createdAt': createdAt.toIso8601String(),
  };

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'] as String,
    userId: json['userId'] as String,
    userName: json['userName'] as String,
    content: json['content'] as String,
    imageUrl: json['imageUrl'] as String?,
    upvotes: json['upvotes'] as int,
    replies: json['replies'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  PostModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? content,
    String? imageUrl,
    int? upvotes,
    int? replies,
    DateTime? createdAt,
  }) => PostModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    upvotes: upvotes ?? this.upvotes,
    replies: replies ?? this.replies,
    createdAt: createdAt ?? this.createdAt,
  );
}
