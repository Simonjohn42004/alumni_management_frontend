import 'package:alumni_management_application_new/rbac_feature_flagging/models/feature_name.dart';

class AppFeatureConfig {
  final Set<FeatureName> enabledFeatures;

  AppFeatureConfig(this.enabledFeatures);

  bool isEnabled(FeatureName feature) => enabledFeatures.contains(feature);

  factory AppFeatureConfig.fromJson(Map<String, dynamic> json) {
    final features = (json['enabledFeatures'] as List<dynamic>)
        .map((s) => FeatureName.values.firstWhere((f) => f.name == s))
        .toSet();
    return AppFeatureConfig(features);
  }

  factory AppFeatureConfig.empty() => AppFeatureConfig({});
}
