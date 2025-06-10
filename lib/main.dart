// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemUiOverlayStyle

// Import your screens
import 'package:cgn/screens/splash_screen.dart'; // Assuming you have a SplashScreen
import 'package:cgn/screens/video_player_screen.dart'; // Import your VideoPlayerScreen

void main() {
  // Ensures Flutter is initialized before running the app.
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
        // The primarySwatch is deprecated in favor of colorScheme.
        // It's better to define your colorScheme explicitly for Material 3.
        primarySwatch: Colors.blue, // Keep for older widgets that might still use it
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(235, 4, 193, 251), // Your primary brand color
          brightness: Brightness.light,
        ).copyWith(
          // You can refine other colors here if needed
          secondary: const Color.fromARGB(235, 4, 193, 251), // Mapping accentColor to secondary
          // For dark mode, you might want to use ColorScheme.dark instead
          // Or provide a separate dark theme
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // Color for text and icons
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Color.fromARGB(235, 4, 193, 251),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          // Controls the status bar icon/text color on the device
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light,   // For iOS (light text/icons)
          ),
        ),
        textTheme: const TextTheme(
          // Using displayMedium for larger titles, or headlineLarge for prominent titles
          // titleLarge is typically used for titles in lists or dialogs
          titleLarge: TextStyle(
            color: Color.fromARGB(235, 4, 193, 251),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[900], // Consistent dark background
      ),

      // Define your app's routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // Your app's starting screen
        '/videoPlayer': (context) {
          // This route expects a String argument (the videoId)
          // Make sure you navigate to this route using Navigator.pushNamed with arguments:
          // Navigator.pushNamed(context, '/videoPlayer', arguments: 'your_dynamic_video_id');
          final String? videoId = ModalRoute.of(context)?.settings.arguments as String?;
          // Provide a default videoId if no argument is passed (e.g., for direct access or testing)
          return VideoPlayerScreen(videoId: videoId ?? 'glxULceEEjA');
        },
      },
    );
  }
}