import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/call_tile.dart';
import '../data/call_data.dart';
import '../widgets/search_bar.dart';
import '../models/call_model.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String _searchQuery = ''; // Current search input

  // Filtered call list based on search query
  List<Call> get visibleCalls {
    final q = _searchQuery.trim().toLowerCase();
    return q.isEmpty
        ? callItems
        : callItems.where((c) => c.name.toLowerCase().contains(q)).toList();
  }

  // Show feedback via snackbar
  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final calls = visibleCalls;

    return Scaffold(
      appBar: const _CallAppBar(), // Custom app bar
      body: Column(
        children: [
          const SizedBox(height: 8),
          CustomSearchBar(
            hint: 'Search calls...',
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RepaintBoundary(
              child: ListView.builder(
                itemCount: calls.length,
                itemBuilder: (ctx, i) {
                  final call = calls[i];
                  return CallTile(
                    call: call,
                    onTap: () => _showSnack('Open call details: ${call.name}'),
                    onCallAction: () => _showSnack(
                      call.isVideo ? 'Start video call' : 'Start voice call',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSnack('Open dialer'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_call),
      ),
    );
  }
}

class _CallAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CallAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            // Title
            Text(
              'Calls',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const Spacer(),

            // Favorites icon
            IconButton(
              onPressed: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Favorites tapped'))),
              icon: Icon(Icons.favorite_border, color: AppColors.primary),
              tooltip: 'Favorites',
            ),

            // More options icon
            IconButton(
              onPressed: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('More options'))),
              icon: Icon(Icons.more_vert, color: AppColors.primary),
              tooltip: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
