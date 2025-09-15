import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class GenericSearchableDropdown<T> extends StatefulWidget {
  final String hintText;
  final List<T> items;
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final bool excludeSelected;
  final String? searchHintText;
  final String? noResultFoundText;
  final String? Function(T?)? validator;

  const GenericSearchableDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.excludeSelected = true,
    this.searchHintText,
    this.noResultFoundText,
    this.validator,
  }) : super(key: key);

  @override
  _GenericSearchableDropdownState<T> createState() =>
      _GenericSearchableDropdownState<T>();
}

class _GenericSearchableDropdownState<T>
    extends State<GenericSearchableDropdown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDec = theme.inputDecorationTheme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return CustomDropdown<T>.search(
      hintText: widget.hintText,
      items: widget.items,
      initialItem: selectedValue,
      excludeSelected: widget.excludeSelected,
      searchHintText: widget.searchHintText ?? 'Search...',
      noResultFoundText: widget.noResultFoundText ?? 'No results found',
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged(value);
      },
      validator: widget.validator,
      decoration: CustomDropdownDecoration(
        closedFillColor: inputDec.fillColor ?? colorScheme.surface,
        expandedFillColor: inputDec.fillColor ?? colorScheme.surface,
        closedShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        expandedShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        closedBorder: Border.all(color: colorScheme.primary, width: 2),
        closedBorderRadius: BorderRadius.circular(8),
        closedErrorBorder: Border.all(color: colorScheme.error, width: 2),
        closedErrorBorderRadius: BorderRadius.circular(8),
        expandedBorder: Border.all(color: colorScheme.primary, width: 2),
        expandedBorderRadius: BorderRadius.circular(8),
        hintStyle:
            inputDec.hintStyle ??
            textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
        headerStyle: textTheme.titleMedium,
        noResultFoundStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        errorStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
        listItemStyle: textTheme.bodyMedium,
        overlayScrollbarDecoration: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(
            colorScheme.primary.withValues(alpha: 0.6),
          ),
          trackColor: WidgetStateProperty.all(
            colorScheme.primary.withValues(alpha: 0.1),
          ),
        ),
        searchFieldDecoration: SearchFieldDecoration(
          hintStyle:
              inputDec.hintStyle ??
              textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
