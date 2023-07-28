import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../thema.dart';

class ShaderMaskNav extends StatefulWidget {
  const ShaderMaskNav({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<ShaderMaskNav> createState() => _ShaderMaskNavState();
}

class _ShaderMaskNavState extends State<ShaderMaskNav> {
  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initAd();
  }

  void _initAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          // Handle ad load failure (if needed)
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isAdLoaded) {
      _interstitialAd.show();
    } else {
      // Ad not loaded yet, handle accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [gradientColor1, gradientColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          _showInterstitialAd();
          widget.onPressed();
        },
        iconSize: 24.0,
        color: Colors.white,
      ),
    );
  }
}
