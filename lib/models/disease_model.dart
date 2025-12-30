class DiseaseModel {
  final String id;
  final String name;
  final String description;
  final String severity;
  final String imageUrl;
  final String cropId;
  final DateTime detectedAt;

  DiseaseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.severity,
    required this.imageUrl,
    required this.cropId,
    required this.detectedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'severity': severity,
    'imageUrl': imageUrl,
    'cropId': cropId,
    'detectedAt': detectedAt.toIso8601String(),
  };

  factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    severity: json['severity'] as String,
    imageUrl: json['imageUrl'] as String,
    cropId: json['cropId'] as String,
    detectedAt: DateTime.parse(json['detectedAt'] as String),
  );

  DiseaseModel copyWith({
    String? id,
    String? name,
    String? description,
    String? severity,
    String? imageUrl,
    String? cropId,
    DateTime? detectedAt,
  }) => DiseaseModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    severity: severity ?? this.severity,
    imageUrl: imageUrl ?? this.imageUrl,
    cropId: cropId ?? this.cropId,
    detectedAt: detectedAt ?? this.detectedAt,
  );
}
