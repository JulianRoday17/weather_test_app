import 'package:get/get.dart';

import 'package:weather_app/features/search_weather/models/weather_model.dart';
import 'package:weather_app/features/search_weather/services/search_weather_service.dart';

class SearchWeatherController extends GetxController {
  final SearchWeatherService searchWeatherService = SearchWeatherService();
  final weatherData = Rxn<WeatherModel>();
  final isLoading = false.obs;
  final temperatureType = '°F'.obs;
  final isCelsius = false.obs;
  final isFahrenheit = true.obs;
  final isKelvin = false.obs;
  final _permanentTemperatureKelvin = 0.0.obs;
  final isNight = false.obs;

  void searchWeather(city) async {
    clearData();
    isLoading(true);
    weatherData.value = await searchWeatherService.getWeatherDetails(city);
    _permanentTemperatureKelvin.value = weatherData.value?.temperature ?? 0.0;
    var tempIcon = weatherData.value?.icon ?? '';
    if (tempIcon.endsWith('n')) {
      isNight(true);
    } else {
      isNight(false);
    }
    isLoading(false);
  }

  void setTemperatureType(String type) {
    if (type == 'celsius') {
      weatherData.value?.temperature =
          _permanentTemperatureKelvin.value - 273.15;
      isCelsius(true);
      isFahrenheit(false);
      isKelvin(false);
      temperatureType.value = '°C';
    } else if (type == 'fahrenheit') {
      weatherData.value?.temperature =
          9 / 5 * (_permanentTemperatureKelvin.value - 273.15) + 32;
      isCelsius(false);
      isFahrenheit(true);
      isKelvin(false);
      temperatureType.value = '°F';
    } else {
      weatherData.value?.temperature = _permanentTemperatureKelvin.value;
      isCelsius(false);
      isFahrenheit(false);
      isKelvin(true);
      temperatureType.value = 'K';
    }
  }

  void clearData() {
    weatherData.value = null;
    isCelsius(false);
    isFahrenheit(false);
    isKelvin(true);
  }
}
