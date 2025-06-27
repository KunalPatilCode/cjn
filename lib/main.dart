import 'package:cjn/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cjn/screens/video_player_screen.dart'; // Ensure this path is correct
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import for Mobile Ads initialization

// Global RouteObserver for observing route changes
// This allows widgets (like VideoPlayerScreen) to react to navigation events.
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Flutter framework initialization
  // Initialize Google Mobile Ads SDK
  MobileAds.instance.initialize(); // This initializes the SDK with the App ID from AndroidManifest.xml
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set to false for production
      title: 'CJN Video App',
      theme: ThemeData(
        brightness: Brightness.dark, // Overall dark theme
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Dark app bar
          foregroundColor: Colors.white, // White icons/text on app bar
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.grey[900], // Dark background for screens
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent, // Primary color for your app
          secondary: Colors.cyanAccent, // Secondary color
          surface: Colors.grey[850]!, // Card/dialog background
          background: Colors.grey[900]!, // Main background
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          headlineSmall: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ).apply(
          bodyColor: Colors.white, // Default text color
          displayColor: Colors.white, // Default display text color
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blueAccent,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
          ),
        ),
        // cardTheme: CardTheme(
        //   color: Colors.grey[850],
        //   elevation: 4,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        // ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white70,
          textColor: Colors.white,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey[850],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        // Add any other specific theme properties you need
      ),
      navigatorObservers: [routeObserver], // Register the route observer here
      // Directly open VideoPlayerScreen as the home screen
      // Use a default video ID. You can change 'dQw4w9WgXcQ' to any other YouTube video ID.
      home: const VideoPlayerScreen(videoId: 'LMPvtCrOvZY'),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
      
      // onGenerateRoute is kept if you intend to navigate to VideoPlayerScreen from other places
      // and pass arguments via Navigator.pushNamed('/videoPlayer', arguments: 'some_video_id').
      // If you ONLY ever open to VideoPlayerScreen and never navigate to it again with arguments,
      // you could potentially remove this block and the 'routes' map.
      onGenerateRoute: (settings) {
        if (settings.name == '/videoPlayer') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return VideoPlayerScreen(
                videoId: args ?? 'LMPvtCrOvZY', // Fallback to default if no ID passed
              );
            },
          );
        }
        // If an unknown route is pushed, you can return null or a default error page.
        return null;
      },
    );
  }
}