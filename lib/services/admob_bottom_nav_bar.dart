import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomNavBarAdmob extends StatefulWidget {
  const BottomNavBarAdmob({Key? key}) : super(key: key);

  @override
  State<BottomNavBarAdmob> createState() => _BottomNavBarAdmobState();
}

class _BottomNavBarAdmobState extends State<BottomNavBarAdmob> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initBannerAd();
  }

  @override
  void dispose() {
    _bannerAd.dispose(); // Dispose the banner ad to avoid memory leaks.
    super.dispose();
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', // Replace with your test ad unit ID or real ad unit ID
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {},
      ),
      request: const AdRequest(), // Use AdRequest for test ads
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? SizedBox(
            height: _bannerAd.size.height.toDouble(),
            width: _bannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : const SizedBox();
  }
}
