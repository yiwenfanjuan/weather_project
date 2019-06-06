
import 'package:flutter/material.dart';
import 'package:weather_project/ui/SplashRoute.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "天气",
      home: SplashPage(),
    );
  }
  
}