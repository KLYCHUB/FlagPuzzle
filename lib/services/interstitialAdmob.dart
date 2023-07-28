// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdmob extends StatefulWidget {
  const InterstitialAdmob({Key? key}) : super(key: key);

  @override
  _InterstitialAdmobState createState() => _InterstitialAdmobState();
}

class _InterstitialAdmobState extends State<InterstitialAdmob> {
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
    // Return a widget here that can trigger the display of the interstitial ad,
    // such as a button or any other interactive widget.
    return ElevatedButton(
      onPressed: _showInterstitialAd,
      child: const Text('Show Interstitial Ad'),
    );
  }
}
