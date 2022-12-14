import 'package:get/get.dart';

import 'package:weather_app/features/search_weather/controllers/search_weather_controller.dart';

class SearchWeatherBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchWeatherController>(() => SearchWeatherController());
  }
}
