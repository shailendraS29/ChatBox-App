import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'message_list_screen.dart';
import 'status_screen.dart';
import 'call_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0; // Active tab index

  // Handle bottom nav tap
  void _onTap(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
    }
  }

  // Show feedback via snackbar
  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      MessageListScreen(),
      StatusScreen(),
      CallScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ), // Preserve state across tabs
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSnack('FAB tapped'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
