import 'package:alumni_management_application_new/rbac_feature_flagging/models/feature_name.dart';

class Permission {
  final FeatureName feature;
  final bool canCreate;
  final bool canRead;
  final bool canUpdateOwn;
  final bool canUpdateAny;
  final bool canDeleteOwn;
  final bool canDeleteAny;

  Permission({
    required this.feature,
    required this.canCreate,
    required this.canRead,
    required this.canUpdateOwn,
    required this.canUpdateAny,
    required this.canDeleteOwn,
    required this.canDeleteAny,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      feature: FeatureName.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toLowerCase() == json['featureName'],
      ),
      canCreate: json['canCreate'],
      canRead: json['canRead'],
      canUpdateOwn: json['canUpdateOwn'],
      canUpdateAny: json['canUpdateAny'],
      canDeleteOwn: json['canDeleteOwn'],
      canDeleteAny: json['canDeleteAny'],
    );
  }
}
