import 'package:flutter/material.dart';
import 'package:cjn/widgets/navigation_drawer.dart'; // Import the navigation drawer
import 'package:cjn/widgets/logos/logo.dart'; // Import your AppLogo widget

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual structure for the screen
    return Scaffold(
      // Use the scaffold background color defined in your app's theme
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Build a custom app bar for the About screen
      appBar: _buildAppBar(context),
      // Integrate the existing navigation drawer
      drawer: const AppNavigationDrawer(),
      // Use SingleChildScrollView to ensure the content is scrollable if it overflows
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Apply consistent padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start (left)
          children: [
            // Main title for the About page
            Text(
              'About Continuous Job Network (CJN)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white, // Text color for visibility on dark background
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Spacing below the main title

            // First introductory section
            _buildSection(
              context,
              title: '', // No specific title for this introductory paragraph
              content:
                  'Continuous Job Network (CJN) is a 24/7 platform dedicated to jobs, employability, corporate branding, and career development. CJN aims to revolutionize the job market by offering continuous content for job seekers, employers, and career enthusiasts.',
            ),
            const SizedBox(height: 24), // Spacing between sections

            // Our Vision section
            _buildSection(
              context,
              title: 'Our Vision',
              content:
                  'To create an ecosystem where students excel, educators thrive, and employers efficiently find the talent they need, facilitating seamless interaction and career growth for all.',
            ),
            const SizedBox(height: 24), // Spacing between sections

            // Our Mission section
            _buildSection(
              context,
              title: 'Our Mission',
              content:
                  'To provide a 24/7 dedicated TV platform for job seekers and employers, offering resources for career development, employability skills, and corporate branding.',
            ),
            const SizedBox(height: 24), // Spacing before features heading

            // Heading for Key Features
            Text(
              'Key Features of CJN',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary, // Using the app's primary color
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12), // Spacing below features heading

            // List of key features, built using a helper method
            _buildFeatureItem(context, 'Real-time Job Listings',
                'Continuously updated job listings from various industries to keep job seekers informed of the latest opportunities.'),
            _buildFeatureItem(context, 'Employability Workshops',
                'CJN offers employability workshops and expert advice to enhance skills such as resume building, interview preparation, and soft skills.'),
            _buildFeatureItem(context, 'Corporate Branding',
                'Employers can showcase their organizations and build a strong employer brand through company culture segments.'),
            _buildFeatureItem(context, 'Career Growth Insights',
                'Get access to informative shows on how to find the perfect job and grow your career to its full potential.'),
            _buildFeatureItem(context, 'Searchable Video Archive',
                'Archived video content will be available on-demand, allowing users to access relevant career advice at any time.'),
            _buildFeatureItem(context, 'Global Accessibility',
                'CJN breaks down geographical barriers by making its content accessible to a global audience.'),
            const SizedBox(height: 20), // Final spacing at the bottom
          ],
        ),
      ),
    );
  }

  /// Builds a custom AppBar for the About screen.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 60.0, // Consistent toolbar height
      backgroundColor: Colors.black, // Dark background for the AppBar
      elevation: 4, // Add a subtle shadow
      centerTitle: true, // Center the title (logo in this case)
      iconTheme: const IconThemeData(color: Colors.white), // Color for leading icon (drawer button)
      title: const Hero(
        tag: 'app-logo', // Reusing the hero tag for smooth transition from other screens
        child: AppLogo(height: 50), // Your custom app logo widget
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12), // Rounded corners at the bottom
        ),
      ),
    );
  }

  /// Helper method to build a section with a title and content.
  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) // Only display the title if it's not empty
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary, // Using the app's secondary color
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white70, // Slightly desaturated white for body text for better contrast
            fontSize: 16,
            height: 1.5, // Increase line height for improved readability
          ),
        ),
      ],
    );
  }

  /// Helper method to build a single feature item.
  Widget _buildFeatureItem(BuildContext context, String featureTitle, String featureDescription) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            featureTitle,
            style: const TextStyle(
              color: Colors.white, // White color for feature titles
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4), // Small spacing between title and description
          Text(
            featureDescription,
            style: const TextStyle(
              color: Colors.white60, // Lighter white for feature descriptions
              fontSize: 15,
              height: 1.4, // Line height for readability
            ),
          ),
        ],
      ),
    );
  }
}
