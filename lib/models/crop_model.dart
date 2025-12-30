class CropModel {
  final String id;
  final String name;
  final String imageUrl;
  final DateTime plantedDate;
  final String userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CropModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.plantedDate,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'plantedDate': plantedDate.toIso8601String(),
    'userId': userId,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
    id: json['id'] as String,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String,
    plantedDate: DateTime.parse(json['plantedDate'] as String),
    userId: json['userId'] as String,
    status: json['status'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  CropModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    DateTime? plantedDate,
    String? userId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CropModel(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    plantedDate: plantedDate ?? this.plantedDate,
    userId: userId ?? this.userId,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
