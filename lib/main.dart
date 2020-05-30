import 'package:bmi_calculator/screens/input_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.black, // status bar color
    ),
  );
  runApp(
    EasyLocalization(
      // https://pub.dev/packages/easy_localization for internationalizing
      supportedLocales: [Locale('en', 'US'), Locale('pt', 'BR')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: BMICalculator(),
    ),
  );
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // https://pub.dev/packages/get for Navigate and more
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: BotToastInit(), // call BotToastInit
      navigatorObservers: [
        BotToastNavigatorObserver() // registered route observer
      ],
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      // home: InputPage(), // no Flare Animation for Splash Screen
      home: SplashScreen.navigate(
        // https://pub.dev/packages/flare_splash_screen
        name: 'assets/animations/intro.flr',
        next: (context) => InputPage(),
        backgroundColor: Color(0xFF0A0E21),
        // if intro.flr longer than Duration it will override the value
        until: () => Future.delayed(Duration(milliseconds: 350)),
        startAnimation: '1',
      ),
      // InputPage(),
    );
  }
}
