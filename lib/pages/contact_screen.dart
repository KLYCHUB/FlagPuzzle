// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flag_puzzle/thema.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants.dart';
import '../utils/strings.dart';
import '../services/admob_bottom_nav_bar.dart';
import '../widgets/custom_shader_mask.dart';
import '../widgets/link_button.dart';
import '../widgets/mail_button.dart';
import '../widgets/shader_mask_nav.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        leading: ShaderMaskNav(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CustomShaderMask(
          shaderMaskText: 'contact'.tr(),
          shaderMaskFontSize: customTitleLarge,
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomShaderMask(
                shaderMaskText: googlePlayStore,
                shaderMaskFontSize: customTitleLarge,
              ),
              LinkButton(
                url: urlGooglePlayStore,
                linkButtonText: 'explore'.tr(),
                faIcons: const FaIcon(FontAwesomeIcons.googlePlay),
              ),
              CustomShaderMask(
                shaderMaskText: 'web_sitesi'.tr(),
                shaderMaskFontSize: customTitleLarge,
              ),
              LinkButton(
                url: urlWebSite,
                linkButtonText: 'visit'.tr(),
                // ignore: deprecated_member_use
                faIcons: const FaIcon(FontAwesomeIcons.earth),
              ),
              const CustomShaderMask(
                shaderMaskText: mailText,
                shaderMaskFontSize: customTitleLarge,
              ),
              MailButton(
                mail: mail,
                mailButtonText: 'send'.tr(),
                faIcons: const FaIcon(FontAwesomeIcons.solidMessage),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarAdmob(),
    );
  }
}
