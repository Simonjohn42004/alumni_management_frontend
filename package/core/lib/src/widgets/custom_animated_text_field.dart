import 'package:flutter/material.dart';

class AnimatedOutlinedTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AnimatedOutlinedTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  @override
  AnimatedOutlinedTextFieldState createState() =>
      AnimatedOutlinedTextFieldState();
}

class AnimatedOutlinedTextFieldState extends State<AnimatedOutlinedTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _elevationController;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _elevationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _elevationAnimation = Tween<double>(
      begin: 0,
      end: 6,
    ).animate(_elevationController);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _elevationController.forward();
      } else {
        _elevationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _elevationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use colors and typography from your AppTheme (via Theme.of)
    final Color borderColor = theme.colorScheme.primary;
    final double elevation = _elevationAnimation.value;
    final TextStyle? labelStyle =
        theme.inputDecorationTheme.labelStyle ??
        theme.textTheme.titleMedium?.copyWith(color: borderColor);
    final TextStyle? hintStyle =
        theme.inputDecorationTheme.hintStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        );
    final TextStyle? textStyle = theme.textTheme.bodyMedium;

    return AnimatedBuilder(
      animation: _elevationAnimation,
      builder: (context, child) {
        return PhysicalModel(
          color: theme.scaffoldBackgroundColor,
          elevation: elevation,
          shadowColor: borderColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8),
          child: child,
        );
      },
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        validator: widget.validator,
        style: textStyle,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: borderColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
