import 'package:flutter/material.dart';

/// A reusable search bar widget with optional hint and callback.
class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged; // Callback when text changes
  final String hint; // Placeholder text inside the search field

  const CustomSearchBar({super.key, this.onChanged, this.hint = 'Search...'});
  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark; // Detect dark mode

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: isDark
            ? Colors.grey[850]
            : Colors.white, // Background color based on theme
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            hintText: hint,
            prefixIcon: const Icon(Icons.search_outlined), // Search icon
            suffixIcon: IconButton(
              onPressed: () {}, // Placeholder for filter action
              icon: const Icon(Icons.tune), // Filter icon
            ),
            border: InputBorder.none, // No border
          ),
        ),
      ),
    );
  }
}
