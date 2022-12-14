import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'package:weather_app/features/search_weather/models/weather_model.dart';
import 'package:weather_app/shared/constants.dart';
import 'package:weather_app/shared/palettes.dart';

class SearchWeatherService extends GetConnect {
  Duration get timeOut => const Duration(seconds: 10);

  Future<WeatherModel> getWeatherDetails(String city) async {
    WeatherModel tempData =
        WeatherModel(icon: '', description: '', mainInfo: '', temperature: 0.0);
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        var finalUrl =
            '${ConstantData.apiUrl}?q=$city&appid=${ConstantData.apiKey}';
        var response = await get(finalUrl).timeout(timeOut);

        if (response.statusCode == 200) {
          tempData = WeatherModel.fromJson(response.body);
        } else if (response.statusCode == 404) {
          Get.snackbar("Error", "City not found, please input a valid city",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Palettes.springGreen);
        }
      } else {
        Get.snackbar("No Connection", 'No internet connection detected',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Palettes.springGreen);
      }
    } on TimeoutException catch (_) {
      Get.snackbar("Timeout", 'Timeout, please try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palettes.springGreen);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palettes.springGreen);
    }

    return tempData;
  }
}
