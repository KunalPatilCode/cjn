// lib/widgets/navigation_drawer.dart
import 'package:flutter/material.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // The background color of the drawer.
      backgroundColor: Theme.of(context).canvasColor, // Use theme's canvas color for better theming
      child: ListView(
        padding: EdgeInsets.zero, // Remove default ListView padding
        children: [
          // Drawer Header with CJN branding
          _buildHeader(context),

          // --- Core Navigation Items ---
          _buildMenuItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: '/videoPlayer', // Route to main screen
          ),
          _buildMenuItem(
            context,
            icon: Icons.login,
            title: 'Login',
            route: '/login',
          ),
          _buildMenuItem(
            context,
            icon: Icons.person_add,
            title: 'Register',
            route: '/register',
          ),

          // Visually separates sections
          const Divider(height: 1, thickness: 1, color: Colors.blueGrey),

          // --- Main Content Sections ---
          _buildMenuItem(
            context,
            icon: Icons.video_library,
            title: 'Videos',
            route: '/videos',
          ),
          _buildMenuItem(
            context,
            icon: Icons.qr_code,
            title: 'QR Codes',
            route: '/qrcodes',
          ),
          _buildMenuItem(
            context,
            icon: Icons.comment,
            title: 'Comments',
            route: '/comments',
          ),
          // Using a more concise way to build multiple similar menu items
          ...List.generate(10, (index) {
            return _buildMenuItem(
              context,
              icon: Icons.palette,
              title: 'Layout ${index + 1}',
              route: '/layout${index + 1}',
            );
          }),
          _buildMenuItem(
            context,
            icon: Icons.star, // Talent Parade icon
            title: 'Talent Parade',
            route: '/talent_parade',
          ),

          const Divider(height: 1, thickness: 1, color: Colors.blueGrey),

          // --- Admin & Settings ---
          _buildMenuItem(
            context,
            icon: Icons.admin_panel_settings,
            title: 'Admin Login',
            route: '/admin_login',
          ),
          _buildMenuItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            route: '/settings',
          ),

          const Divider(height: 1, thickness: 1, color: Colors.blueGrey),

          // --- Information & Support ---
          _buildMenuItem(
            context,
            icon: Icons.info,
            title: 'About',
            route: '/about',
          ),
          _buildMenuItem(
            context,
            icon: Icons.gavel, // Terms & Conditions icon
            title: 'Terms & Conditions',
            route: '/terms_conditions',
          ),
          _buildMenuItem(
            context,
            icon: Icons.privacy_tip, // Privacy Policy icon
            title: 'Privacy Policy',
            route: '/privacy_policy',
          ),
          _buildMenuItem(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            route: '/help',
          ),

          const Divider(height: 1, thickness: 1, color: Colors.blueGrey),

          // --- Logout ---
          // Logout doesn't navigate to a new route in the same way, so keep its specific onTap
          _buildMenuItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _logout(context), // Use specific logout logic
          ),
        ],
      ),
    );
  }

  /// Builds the custom header for the navigation drawer.
  Widget _buildHeader(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero, // Remove default margin from DrawerHeader
      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0), // Custom padding
      decoration: const BoxDecoration(
        color: Color(0xFF0A3D8F), // Solid background if gradient is disabled
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A3D8F), Color(0xFF00A8E8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end, // Aligns content to the bottom
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), // Adjusted padding for better visual
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15), // Slightly more rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Stronger shadow for more depth
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'CJN',
              style: TextStyle(
                fontSize: 36, // Increased font size for prominence
                fontWeight: FontWeight.w900, // Extra bold for impact
                color: const Color(0xFF0A3D8F),
                letterSpacing: 2.0, // More letter spacing
                shadows: [ // Added a subtle text shadow
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16), // Increased spacing
          const Text(
            'Continuous Job Network',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19, // Slightly larger font size
              fontWeight: FontWeight.w600, // Medium-bold font weight
              letterSpacing: 0.5, // Added some letter spacing
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single menu item for the navigation drawer.
  /// It now takes a `route` string, and uses `Navigator.pushNamed` internally.
  /// The `onTap` parameter is made optional, allowing for custom actions like logout.
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route, // Make route optional
    VoidCallback? onTap, // Make onTap optional
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
      // If a route is provided, use _navigateTo; otherwise, use the custom onTap.
      onTap: onTap ?? () => _navigateTo(context, route!),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      minLeadingWidth: 20,
      hoverColor: Colors.blue.withOpacity(0.1), // Add hover effect
      selectedTileColor: Colors.blue.withOpacity(0.2), // Add selected effect (if applicable)
      // selected: ModalRoute.of(context)?.settings.name == route, // Uncomment if you want selection highlighting
    );
  }

  /// Navigates to the specified route and closes the drawer.
  /// This method is now private and handles common navigation.
  void _navigateTo(BuildContext context, String route) {
    // Only navigate if the current route is different to avoid pushing same screen
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pop(context); // Close the drawer
      Navigator.pushNamed(context, route); // Navigate to the specified route
    } else {
      Navigator.pop(context); // Just close the drawer if already on the route
    }
  }

  /// Handles the logout logic.
  void _logout(BuildContext context) {
    Navigator.pop(context); // Close the drawer first
    // TODO: Implement your actual logout logic here
    // e.g., clear user session, make API call, then navigate to login/splash.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logging out...')),
    );
    // Example: Use `pushReplacementNamed` to prevent going back to previous screens after logout
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });
  }
}