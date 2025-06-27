import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:cjn/widgets/logos/logo.dart'; // Make sure this path is correct
import 'package:cjn/widgets/navigation_drawer.dart'; // Make sure this path is correct
import 'package:cjn/main.dart'; // Ensure this import is present and correct for routeObserver
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import google_mobile_ads for BannerAd

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> with RouteAware {
  late YoutubePlayerController _controller;
  final double _appBarHeight = 60.0;

  // --- AdMob Banner Ad Variables ---
  BannerAd? _bannerAd; // Nullable BannerAd instance
  bool _isBannerAdLoaded = false; // To track if the ad is loaded

  // IMPORTANT: Use Google's TEST Banner Ad Unit ID for development!
  // Replace this with your REAL ad unit ID ONLY when preparing for production.
  final String _adUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Google's TEST Banner ID

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
        forceHD: false,
        enableCaption: true,
      ),
    );
    _controller.addListener(_listener);

    // --- Initialize and Load Banner Ad ---
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('BannerAd loaded: \\${ad.adUnitId}');
          if (!mounted) return;
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: \\${ad.adUnitId}, Error: $error');
          ad.dispose(); // Dispose the ad when it fails to load
          if (!mounted) return;
          setState(() {
            _isBannerAdLoaded = false;
          });
        },
        onAdOpened: (ad) => debugPrint('BannerAd opened.'),
        onAdClosed: (ad) => debugPrint('BannerAd closed.'),
        onAdImpression: (ad) => debugPrint('BannerAd impression.'),
      ),
    );

    _bannerAd!.load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void didPushNext() {
    debugPrint('VideoPlayerScreen: didPushNext - Pausing video');
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void didPopNext() {
    debugPrint('VideoPlayerScreen: didPopNext - Resuming video');
    if (_controller.value.playerState == PlayerState.paused || _controller.value.playerState == PlayerState.buffering) {
      _controller.play();
    }
  }

  void _listener() {
    if (_controller.value.isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    routeObserver.unsubscribe(this);
    _controller.dispose();
    _bannerAd?.dispose(); // Dispose the banner ad when the screen is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
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
        return Scaffold(
          backgroundColor: Colors.grey[900],
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
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: player,
                      ),
                    ),
                  ),
                ),
                if (!_controller.value.isFullScreen) ...[
                  // Conditionally show the ad section only if banner is loaded
                  if (_isBannerAdLoaded && _bannerAd != null)
                    _buildAdvertisementSection(), // Now this will contain the actual ad
                  // If ad is not loaded, you might show a different placeholder or nothing
                  if (!_isBannerAdLoaded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        height: AdSize.banner.height.toDouble(), // Use standard ad height
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: const Text(
                          'Ad Loading...',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
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

  // --- Helper methods ---
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

  // --- MODIFIED: This method now correctly integrates the AdWidget ---
  Widget _buildAdvertisementSection() {
    // Only return the AdWidget if the banner ad is loaded
    if (_isBannerAdLoaded && _bannerAd != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          // Ensure the Container has the correct size for the ad
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          decoration: BoxDecoration(
            color: Colors.grey[800], // Background color of the ad container
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
          child: ClipRRect( // Clip to apply borderRadius to the ad
            borderRadius: BorderRadius.circular(10),
            child: AdWidget(ad: _bannerAd!), // This is the crucial line!
          ),
        ),
      );
    } else {
      // This part will ideally not be reached if _isBannerAdLoaded is false,
      // as the `if (_isBannerAdLoaded)` check in the build method handles it.
      // But including it for completeness, or as a fallback for custom non-ad content.
      return const SizedBox.shrink(); // Return an empty widget if ad is not loaded
    }
  }
}