// lib/screens/video_player_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:cgn/widgets/logos/logo.dart';
import 'package:cgn/widgets/navigation_drawer.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState(); // CORRECTED: This now correctly refers to _VideoPlayerScreenState
}

// CORRECTED: Ensure the State class name matches what createState() returns
class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  final double _appBarHeight = 60.0;

  static const List<Map<String, String>> _qrList = [
    {'image': 'assets/qr1.png', 'label': 'JAVA'},
    {'image': 'assets/qr1.png', 'label': 'FLUTTER'},
    {'image': 'assets/qr1.png', 'label': 'REACT'},
    {'image': 'assets/qr1.png', 'label': 'PYTHON'},
    {'image': 'assets/qr1.png', 'label': 'C#'},
    {'image': 'assets/qr1.png', 'label': 'AWS'},
    {'image': 'assets/qr1.png', 'label': 'FULL STACK'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false, // Set to false to prevent automatic full-screen on orientation change
        enableCaption: true,
      ),
    );
    _controller.addListener(_listener);
  }

  void _listener() {
    // This listener handles system UI and orientation changes based on the player's internal full-screen state.
    if (_controller.value.isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Show system bars
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        // Allow landscape too, as user might manually rotate without going full screen
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    // Ensure system settings are reverted when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values); // Reset to all
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      // CORRECTED: Remove the 'controller' parameter directly from YoutubePlayerBuilder.
      // The controller is passed *inside* the YoutubePlayer widget below.
      player: YoutubePlayer( // This is the player widget that YoutubePlayerBuilder manages for fullscreen.
        controller: _controller, // <-- Pass the controller here to the YoutubePlayer widget.
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color.fromARGB(255, 7, 135, 255),
        progressColors: const ProgressBarColors(
          playedColor: Color.fromARGB(255, 7, 214, 255),
          handleColor: Color.fromARGB(255, 64, 166, 255),
          bufferedColor: Colors.grey,
        ),
        onReady: () => debugPrint('Player ready: ${widget.videoId}'),
        onEnded: (data) => debugPrint('Video ended: ${data.videoId}'),
      ),
      builder: (context, player) {
        // 'player' is the actual YoutubePlayer widget managed by YoutubePlayerBuilder.
        return Scaffold(
          backgroundColor: Colors.grey[900],
          // Hide AppBar and Drawer ONLY when the player is in its full-screen mode
          appBar: _controller.value.isFullScreen
              ? null
              : _buildClassyAppBar(context),
          drawer: _controller.value.isFullScreen
              ? null
              : const AppNavigationDrawer(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 84, 116, 142).withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio( // Add AspectRatio to maintain 16:9 in regular view
                        aspectRatio: 16 / 9,
                        child: player, // Use the player widget provided by the builder
                      ),
                    ),
                  ),
                ),
                // Only show ads and other content when not in player's full-screen mode
                if (!_controller.value.isFullScreen) ...[
                  _buildAdvertisementSection(),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 24, right: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Explore More Content',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _qrList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = _qrList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 64, 166, 255),
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    item['image']!,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.qr_code, size: 40, color: Colors.blue),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  item['label']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Helper methods remain unchanged ---
  PreferredSizeWidget _buildClassyAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: _appBarHeight,
      backgroundColor: Colors.black,
      elevation: 4,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Hero(
        tag: 'app-logo',
        child: AppLogo(height: 50),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => _showMoreOptions(context),
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[850],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildListTile(
                icon: Icons.share,
                title: 'Share Video',
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Share Video tapped');
                },
              ),
              _buildListTile(
                icon: Icons.download,
                title: 'Download Video',
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Download Video tapped');
                },
              ),
              _buildListTile(
                icon: Icons.info,
                title: 'Video Details',
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Video Details tapped');
                },
              ),
              _buildListTile(
                icon: Icons.flag,
                title: 'Report Issue',
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Report Issue tapped');
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildAdvertisementSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueAccent, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            debugPrint('Advertisement section tapped!');
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.campaign, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'ADVERTISEMENT',
                      style: TextStyle(
                        color: Colors.amber[300],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/banner.png',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        alignment: Alignment.center,
                        color: Colors.red[300],
                        child: const Text(
                          'Failed to load ad image',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Exclusive offer: OPPO RenoZ Purple..!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Text(
                  'New Launch first come first serve Click to know more!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Learn More button clicked!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'Learn More',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}