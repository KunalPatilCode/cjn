// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemUiOverlayStyle

// Import your screens
import 'package:cjn/screens/splash_screen.dart';
import 'package:cjn/screens/video_player_screen.dart';
import 'package:cjn/screens/about.dart';

/// IMPORTANT: This `routeObserver` MUST be a top-level (global) variable.
/// It cannot be inside a class for `VideoPlayerScreen` to access it directly.
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Continuous Job Network',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(235, 4, 193, 251),
          brightness: Brightness.light,
        ).copyWith(
          secondary: const Color.fromARGB(235, 4, 193, 251),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Color.fromARGB(235, 4, 193, 251),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color.fromARGB(235, 4, 193, 251),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      // Register the routeObserver with the MaterialApp's Navigator
      navigatorObservers: [routeObserver],
      routes: {
        '/': (context) => const SplashScreen(),
        // MODIFIED: The /home route now points to VideoPlayerScreen.
        // It provides a default videoId for simplicity when navigating from the drawer.
        '/home': (context) => const VideoPlayerScreen(videoId: 'glxULceEEjA'),
        '/videoPlayer': (context) {
          final String? videoId = ModalRoute.of(context)?.settings.arguments as String?;
          return VideoPlayerScreen(videoId: videoId ?? 'glxULceEEjA');
        },
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
