import 'package:flutter/material.dart';

class RecoveryStep {
  final String title;
  final String description;
  final Color accentColor;
  final String? actionButton;

  RecoveryStep({
    required this.title,
    required this.description,
    required this.accentColor,
    this.actionButton,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'accentColor': accentColor.value,
    'actionButton': actionButton,
  };

  factory RecoveryStep.fromJson(Map<String, dynamic> json) => RecoveryStep(
    title: json['title'] as String,
    description: json['description'] as String,
    accentColor: Color(json['accentColor'] as int),
    actionButton: json['actionButton'] as String?,
  );
}

class RecoveryPlanModel {
  final String id;
  final String diseaseId;
  final List<RecoveryStep> steps;

  RecoveryPlanModel({
    required this.id,
    required this.diseaseId,
    required this.steps,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'diseaseId': diseaseId,
    'steps': steps.map((s) => s.toJson()).toList(),
  };

  factory RecoveryPlanModel.fromJson(Map<String, dynamic> json) => RecoveryPlanModel(
    id: json['id'] as String,
    diseaseId: json['diseaseId'] as String,
    steps: (json['steps'] as List).map((s) => RecoveryStep.fromJson(s as Map<String, dynamic>)).toList(),
  );
}
