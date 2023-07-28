import 'dart:async';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flag_puzzle/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../thema.dart';
import '../utils/strings.dart';
import '../widgets/admob_bottom_nav_bar.dart';
import '../widgets/custom_shader_mask.dart';
import '../widgets/shader_mask_nav.dart';
import 'game_mode_select.dart';

class GameScreen extends StatefulWidget {
  const GameScreen(
      {super.key, required this.countries, required this.questionsNum});
  final List<Country> countries;
  final int questionsNum;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool showCorrectFlashbang = false;
  bool showWrongFlashbang = false;

  int? selectedOptionIndex;

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Şu anki sorunun indexi
  int currentIndex = 0;
  // Doğru cevap sayısı
  int score = 0;
  // Seçeneklerin indexleri
  List<int> options = [];
  // Rastgele sayı üretmek için
  Random random = Random();

  @override
  void initState() {
    super.initState();
    // Seçenekleri belirle
    setOptions();
  }

  void setOptions() {
    // Seçenekleri temizle
    options.clear();
    // Doğru cevabı ekle
    options.add(currentIndex);
    // Diğer seçenekleri rastgele ekle
    while (options.length < 4) {
      int index = random.nextInt(widget.questionsNum);
      if (!options.contains(index)) {
        options.add(index);
      }
    }
    // Seçenekleri karıştır
    options.shuffle();
  }

  void nextQuestion() {
    // Sonraki soruya geç
    setState(() {
      currentIndex++;
      //soru sayısı !!!!!!!!!!!!!!!!!!!!!
      if (currentIndex < widget.questionsNum) {
        // Seçenekleri belirle
        setOptions();
      } else {
        // Quiz bitti, sonucu göster
        showResult();
      }
    });
  }

  void showResult() {
    // Sonucu göstermek için bir diyalog aç
    showDialog(
      context: context,
      builder: (context) => Container(
        // Burada Container widget'ı kullan
        decoration: const BoxDecoration(
          // Burada decoration özelliği ver
          gradient: LinearGradient(
            // Burada gradient özelliği ver
            colors: [
              gradientColor1,
              gradientColor2
            ], // Burada istediğiniz renkleri ver
          ),
        ),
        child: AlertDialog(
          backgroundColor:
              backgroundColor, // Burada backgroundColor özelliği ver
          title: CustomShaderMask(
            shaderMaskText: 'quiz_finish'.tr(),
            shaderMaskFontSize: 16.0,
          ),
          content: CustomShaderMask(
            shaderMaskText:
                '${'number_of_correct_answers'.tr()} $score / ${widget.questionsNum}',
            shaderMaskFontSize: 16.0,
          ), //"D
          actions: [
            TextButton(
              onPressed: () {
                // Diyalogu kapat
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
                // Önceki ekrana dön
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              },
              child: CustomShaderMask(
                shaderMaskText: "ok".tr(),
                shaderMaskFontSize: 16.0,
              ), //
            ),
          ],
        ),
      ),
    );
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  void checkAnswer(int index) {
    if (index == currentIndex) {
      // Correct answer
      setState(() {
        score++;
        showCorrectFlashbang = true;
        assetsAudioPlayer.open(
          Audio(correctSound),
        );
      });
    } else {
      // Wrong answer
      setState(() {
        showWrongFlashbang = true;
        assetsAudioPlayer.open(
          Audio(wrongSound),
        );
      });
    }

    // Reset the flashbang flags after a short delay (e.g., 600 milliseconds)
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        showCorrectFlashbang = false;
        showWrongFlashbang = false;
      });
      nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double flagWidht = MediaQuery.of(context).size.width / 1.35;
    final double flagHeight = MediaQuery.of(context).size.height / 4;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        leading: ShaderMaskNav(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ));
          },
        ), //,
        title: CustomShaderMask(
          shaderMaskText:
              "${'game_question_num'.tr()} $currentIndex / ${widget.questionsNum}",
          shaderMaskFontSize: 22.0,
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              // Flashbang effect for correct answer
              AnimatedOpacity(
                opacity: showCorrectFlashbang ? 1.0 : 0.0,
                duration:
                    const Duration(milliseconds: 150), // Decreased duration
                child: AnimatedContainer(
                  color: const Color.fromARGB(255, 0, 255, 8).withOpacity(.3),
                  duration:
                      const Duration(milliseconds: 150), // Decreased duration
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),

              // Flashbang effect for wrong answer
              AnimatedOpacity(
                opacity: showWrongFlashbang ? 1.0 : 0.0,
                duration:
                    const Duration(milliseconds: 150), // Decreased duration
                child: AnimatedContainer(
                  color: const Color.fromARGB(255, 255, 17, 0).withOpacity(.3),
                  duration:
                      const Duration(milliseconds: 150), // Decreased duration
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  mediaQueryQuestionSpace(context),
                  Center(
                    //
                    child: CustomShaderMask(
                      shaderMaskText: '${'true'.tr()} $score',
                      shaderMaskFontSize: 22.0,
                    ),
                  ),
                  mediaQueryQuestionSpace(context),
                  if (currentIndex < widget.questionsNum)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                          width: 15,
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [gradientColor1, gradientColor2],
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                      ),
                      width: flagWidht,
                      height: flagHeight,
                      child: SvgPicture.asset(
                        widget.countries[currentIndex].flag,
                        fit: BoxFit.contain,
                      ),
                    ),
                  mediaQueryQuestionSpace(context),
                  Expanded(
                    child: SizedBox(
                      width: flagWidht,
                      height: flagHeight,
                      child: Wrap(
                        spacing: 8, // horizontal spacing between buttons
                        runSpacing: 20, // vertical spacing between buttons
                        children: List.generate(4, (index) {
                          if (currentIndex >= widget.questionsNum) {
                            return Container();
                          }
                          return InkWell(
                            overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent,
                            ),
                            onTap: () {
                              setState(() {
                                selectedOptionIndex = index;
                              });
                              checkAnswer(options[index]);

                              // Start the timer for 1 second (1000 milliseconds)
                              _timer?.cancel();
                              _timer =
                                  Timer(const Duration(milliseconds: 400), () {
                                setState(() {
                                  selectedOptionIndex = null;
                                });
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: index ==
                                          selectedOptionIndex // Check if this button is selected
                                      ? [
                                          Colors.white,
                                          Colors.white,
                                        ] // Change colors for selected button
                                      : [
                                          gradientColor1,
                                          gradientColor2
                                        ], // Regular colors for other buttons
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: flagWidht / 20),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  widget.countries[options[index]].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarAdmob(),
    );
  }

  SizedBox mediaQueryWidth(BuildContext context) =>
      SizedBox(width: MediaQuery.of(context).size.width / 8);

  SizedBox mediaQueryWidthMid(BuildContext context) =>
      SizedBox(width: MediaQuery.of(context).size.width / 20);

  SizedBox mediaQueryHeight(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height / 40);

  SizedBox mediaQuerySpace(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height / 6);

  SizedBox mediaQueryQuestionSpace(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height / 20);
}