class Constants {
  static const String baseUrl = 'http://10.224.147.94:3999/api';

  // Profile endpoints
  static const String profile = '$baseUrl/profile';
  static const String profileById = '$baseUrl/profile/'; // append {id}

  // Education endpoints
  static const String educations = '$baseUrl/educations';
  static const String educationById = '$baseUrl/educations/'; // append {id}
}
