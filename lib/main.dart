import 'dart:async';
import 'package:cienfuegos_folklore/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Timer(Duration(seconds: 3), () {
    FlutterNativeSplash.remove();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leyendas de Cienfuegos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/animated_splash_screen.gif',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        centered: true,
        nextScreen: HomeScreen(),
        duration: 7000,
        backgroundColor: Colors.white,
        splashIconSize: double.infinity,
      ),
    );
  }
}
