import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:weather_app/features/search_weather/bindings/search_weather_binding.dart';
import 'package:weather_app/features/search_weather/screens/search_weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: '/searchweather',
            page: () => SearchWeatherScreen(),
            binding: SearchWeatherBinding())
      ],
      initialRoute: '/searchweather',
      debugShowCheckedModeBanner: false,
    );
  }
}
