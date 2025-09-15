import 'package:alumni_management_application_new/rbac_feature_flagging/bloc/rbac_feature_flagging_bloc.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/bloc/rbac_feature_flagging_event.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/models/feature_name.dart';
import 'package:alumni_management_application_new/rbac_feature_flagging/services/app_feature_service.dart';

class FeatureAndRbacController {
  final AppFeatureService featureService; // Your existing flagsmith wrapper
  final RbacBloc rbacBloc;

  FeatureAndRbacController({
    required this.featureService,
    required this.rbacBloc,
  });

  // Fetch flags + permissions and dispatch to Bloc
  Future<bool> initialize({
    required String flagsmithApiKey,
    required int userRoleId,
  }) async {
    try {
      // 1. Initialize Flag Smith client and fetch Flags
      final appFeatureService = await AppFeatureService.initialize(
        flagsmithApiKey,
      );
      final featureConfig = await appFeatureService.fetchFeatureConfig();

      // 2. Load RBAC role permissions from your backend via repository and dispatch to Bloc
      rbacBloc.add(LoadRbacEvent(userRoleId));

      // 3. Optionally wait for RBAC state to update (simplified example)
      await rbacBloc.stream.firstWhere((state) => !state.loading);

      // 4. Provide access to combined feature flags and RBAC
      _enabledFeatures = featureConfig.enabledFeatures;

      return true; // success
    } catch (_) {
      return false; // handle errors gracefully
    }
  }

  Set<FeatureName> _enabledFeatures = {};

  bool isFeatureEnabled(FeatureName featureName) {
    // Map from FeatureName Enum to your Feature Enum from flagsmith
    // Here assuming feature names match exactly (adjust if not)
    return _enabledFeatures.any(
      (f) =>
          f.name.toUpperCase() ==
          featureName.toString().split('.').last.toUpperCase(),
    );
  }
}
