import 'package:alumni_management_application_new/rbac_feature_flagging/models/feature_name.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/services/app_feature_config.dart';
import 'package:flagsmith/flagsmith.dart';

class AppFeatureService {
  final FlagsmithClient _flagsmithClient;

  AppFeatureService._internal(this._flagsmithClient);

  FlagsmithClient get flagsmithClient => _flagsmithClient;

  static Future<AppFeatureService> initialize(String apiKey) async {
    final client = await FlagsmithClient.init(apiKey: apiKey);
    await client.getFeatureFlags(reload: true);
    return AppFeatureService._internal(client);
  }

  Future<AppFeatureConfig> fetchFeatureConfig() async {
    final enabledFeatures = <FeatureName>{};

    try {
      for (var feature in FeatureName.values) {
        bool isEnabled = await _flagsmithClient.isFeatureFlagEnabled(
          feature.name,
        );
        if (isEnabled) {
          enabledFeatures.add(feature);
        }
      }
    } catch (e) {
      rethrow; // Optionally rethrow or handle gracefully
    }

    return AppFeatureConfig(enabledFeatures);
  }
}
