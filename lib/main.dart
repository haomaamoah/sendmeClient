import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../view/screens/SplashScreen.dart';
import 'model/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: MyApp()));
}


class MyApp extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef widget) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SEND★ME",
      theme: ThemeData(
        primarySwatch: Constants.myColor,
        accentColor: Color(0xFFF54D6E),
        primaryColor: Color(0xFFF54D6E),
      ),
      // home: SplashScreen(),
      home: SplashScreen(),

    );
  }
}
