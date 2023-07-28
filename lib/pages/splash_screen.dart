import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flag_puzzle/thema.dart';
import 'package:flag_puzzle/utils/constants.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: MediaQuery.of(context).size.width / 4.5,
      logo: Image.asset("assets/images/logo.jpeg", fit: BoxFit.cover),
      title: const Text(
        "FLAG PUZZLE",
        style: TextStyle(
            fontSize: customHeadlineSmall,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: backgroundColor),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Loading..."),
      navigator: const HomePage(),
      durationInSeconds: 4,
    );
  }
}
