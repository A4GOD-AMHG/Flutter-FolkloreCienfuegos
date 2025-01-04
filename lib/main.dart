import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cienfuegos_folklore/home_screen.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    setWindowSize(400, 800);
  }

  runApp(MyApp());
}

void setWindowSize(double width, double height) {
  if (Platform.isWindows || Platform.isLinux) {
    final channel = const MethodChannel('flutter/window');
    channel.invokeMethod('setWindowSize', {'width': width, 'height': height});
    channel.invokeMethod('setWindowResizable', {'resizable': false});
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
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
