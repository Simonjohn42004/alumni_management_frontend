import 'package:flutter/material.dart';

class OutlinedElevatedGlowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final Color? glowColor;
  final Color? fillColor;
  final double elevation;
  final double pressedElevation;
  final double? width;
  final double? height;

  const OutlinedElevatedGlowButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 12,
    this.glowColor,
    this.fillColor,
    this.elevation = 8,
    this.pressedElevation = 2,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _OutlinedElevatedGlowButtonState createState() =>
      _OutlinedElevatedGlowButtonState();
}

class _OutlinedElevatedGlowButtonState extends State<OutlinedElevatedGlowButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;

  Animation<double>? _elevationAnimation;
  Animation<Color?>? _fillColorAnimation;
  Animation<Color?>? _glowColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = Theme.of(context);
    final fillColor = widget.fillColor ?? theme.colorScheme.primary;
    final glowColor =
        widget.glowColor ?? theme.colorScheme.primary.withOpacity(0.6);

    _elevationAnimation ??= Tween<double>(
      begin: widget.elevation,
      end: widget.pressedElevation,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fillColorAnimation ??= ColorTween(
      begin: Colors.transparent,
      end: fillColor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _glowColorAnimation ??= ColorTween(
      begin: glowColor,
      end: Colors.transparent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: _fillColorAnimation!.value ?? Colors.transparent,
      elevation: _elevationAnimation!.value,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      shadowColor: _glowColorAnimation!.value ?? Colors.transparent,
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.width ?? 120,
            maxWidth: widget.width ?? 250,
            minHeight: widget.height ?? 48,
            maxHeight: widget.height ?? 70,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color:
                    widget.fillColor ?? Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              color: Colors.transparent,
            ),
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: TextStyle(
                color: _isPressed
                    ? Colors.white
                    : (widget.fillColor ??
                          Theme.of(context).colorScheme.primary),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
