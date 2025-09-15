// ignore_for_file: constant_identifier_names

enum Department {
  COMPUTER_SCIENCE_ENGINEERING,
  COMPUTER_SCIENCE_BUSINESS_SYSTEMS,
  ARTIFICIAL_INTELLIGENCE_DATA_SCIENCE,
  ARTIFICIAL_INTELLIGENCE_MACHINE_LEARNING,
  MECHANICAL_AUTOMATION_ENGINEERING,
  INTERNET_OF_THINGS,
  CYBERSECURITY,
  COMPUTER_COMMUNICATION_ENGINEERING,
  ELECTRICAL_INSTRUMENTATION_ENGINEERING,
  INSTRUMENTATION_CONTROL_ENGINEERING,
  INFORMATION_TECHNOLOGY,
  MECHANICAL_ENGINEERING,
  ELECTRICAL_ELECTRONICS_ENGINEERING,
  CIVIL_ENGINEERING,
  ELECTRONICS_COMMUNICATION_ENGINEERING,
}

extension DepartmentExtension on Department {
  /// Human-readable display name for UI
  String get displayName {
    switch (this) {
      case Department.COMPUTER_SCIENCE_ENGINEERING:
        return 'Computer Science Engineering';
      case Department.COMPUTER_SCIENCE_BUSINESS_SYSTEMS:
        return 'Computer Science Business Systems';
      case Department.ARTIFICIAL_INTELLIGENCE_DATA_SCIENCE:
        return 'Artificial Intelligence & Data Science';
      case Department.ARTIFICIAL_INTELLIGENCE_MACHINE_LEARNING:
        return 'Artificial Intelligence & Machine Learning';
      case Department.MECHANICAL_AUTOMATION_ENGINEERING:
        return 'Mechanical Automation Engineering';
      case Department.INTERNET_OF_THINGS:
        return 'Internet of Things';
      case Department.CYBERSECURITY:
        return 'Cybersecurity';
      case Department.COMPUTER_COMMUNICATION_ENGINEERING:
        return 'Computer Communication Engineering';
      case Department.ELECTRICAL_INSTRUMENTATION_ENGINEERING:
        return 'Electrical Instrumentation Engineering';
      case Department.INSTRUMENTATION_CONTROL_ENGINEERING:
        return 'Instrumentation & Control Engineering';
      case Department.INFORMATION_TECHNOLOGY:
        return 'Information Technology';
      case Department.MECHANICAL_ENGINEERING:
        return 'Mechanical Engineering';
      case Department.ELECTRICAL_ELECTRONICS_ENGINEERING:
        return 'Electrical & Electronics Engineering';
      case Department.CIVIL_ENGINEERING:
        return 'Civil Engineering';
      case Department.ELECTRONICS_COMMUNICATION_ENGINEERING:
        return 'Electronics & Communication Engineering';
    }
  }

  /// Converts enum to string key (e.g. for JSON serialization)
  String toShortString() => toString().split('.').last;

  /// Factory method to parse from string key
  static Department fromString(String deptString) {
    return Department.values.firstWhere(
      (e) => e.toShortString() == deptString,
      orElse: () => throw Exception('Unknown department: $deptString'),
    );
  }
}

/// Optional extension on String for convenient parsing
extension DepartmentParsing on String {
  Department toDepartment() => DepartmentExtension.fromString(this);
}
