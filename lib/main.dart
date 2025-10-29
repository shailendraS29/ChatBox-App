import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/chat_provider.dart';
import 'screens/home_shell.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ), // Global chat state
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBox',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Auto switch light/dark based on system
      theme: ThemeData.light(useMaterial3: true).copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.bgLight,
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bgLight,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.bgDark,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bgDark,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeShell(), // Entry point of the app
    );
  }
}
