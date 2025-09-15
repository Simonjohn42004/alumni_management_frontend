class Education {
  final int? id; // optional, assigned by DB
  final String userId;
  final String schoolName;
  final String degree;
  final String? fieldOfStudy;
  final DateTime startDate;
  final DateTime endDate;
  final String cgpa; // represent Decimal as String
  final String? description;

  Education({
    this.id,
    required this.userId,
    required this.schoolName,
    required this.degree,
    this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    required this.cgpa,
    this.description,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as int?,
      userId: json['userId'] as String,
      schoolName: json['schoolName'] as String,
      degree: json['degree'] as String,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      cgpa: json['cgpa'].toString(),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'schoolName': schoolName,
      'degree': degree,
      if (fieldOfStudy != null) 'fieldOfStudy': fieldOfStudy,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'cgpa': cgpa,
      if (description != null) 'description': description,
    };
  }

  Education copyWith({
    int? id,
    String? userId,
    String? schoolName,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    String? cgpa,
    String? description,
  }) {
    return Education(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      schoolName: schoolName ?? this.schoolName,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cgpa: cgpa ?? this.cgpa,
      description: description ?? this.description,
    );
  }
}
