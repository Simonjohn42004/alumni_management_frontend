import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Generic utility widget to automatically render skeleton loaders for any content.
/// Place this in /core/widgets/skeleton_loader.dart or /core/util/skeleton_util.dart as appropriate.
class SkeletonLoader extends StatelessWidget {
  /// If true, shows skeleton loading effect in place of content.
  final bool enabled;

  /// The widget to render/shade when not loading.
  final Widget child;

  /// Optional: transition animation between skeleton and real content.
  final bool enableSwitchAnimation;

  /// Optional: Custom Skeletonizer effect (default: shimmer).
  final ShimmerEffect? effect;

  /// Optional: Justify multiline text skeletons.
  final bool? justifyMultiLineText;

  /// Optional: Config for text skeleton border radius.
  final TextBoneBorderRadius? textBoneBorderRadius;

  /// Optional: Color override for containers in skeleton mode.
  final Color? containersColor;

  /// Optional: Whether to ignore containers and only skeletonize their children.
  final bool ignoreContainers;

  /// Optional: Skeletonizer config data for inherited theme config.
  final SkeletonizerConfigData? configData;

  const SkeletonLoader({
    super.key,
    required this.enabled,
    required this.child,
    this.enableSwitchAnimation = true,
    this.effect,
    this.justifyMultiLineText,
    this.textBoneBorderRadius,
    this.containersColor,
    this.ignoreContainers = false,
    this.configData,
  });

  @override
  Widget build(BuildContext context) {
    // Inherit default config from theme if configData is not provided
    final themeConfig =
        configData ??
        SkeletonizerConfigData(
          effect: effect ?? const ShimmerEffect(),
          justifyMultiLineText: justifyMultiLineText ?? false,
          ignoreContainers: ignoreContainers,
          containersColor: containersColor,
        );

    return SkeletonizerConfig(
      data: themeConfig,
      child: Skeletonizer(
        enabled: enabled,
        enableSwitchAnimation: enableSwitchAnimation,
        effect: effect,
        ignoreContainers: ignoreContainers,
        child: child,
      ),
    );
  }
}
