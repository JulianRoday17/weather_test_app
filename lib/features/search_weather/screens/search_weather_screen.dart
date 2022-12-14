import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:weather_app/features/search_weather/controllers/search_weather_controller.dart';
import 'package:weather_app/shared/constants.dart';
import 'package:weather_app/shared/image_resources.dart';
import 'package:weather_app/shared/palettes.dart';
import 'package:weather_app/shared/widgets_utils.dart';

class SearchWeatherScreen extends GetView<SearchWeatherController> {
  final TextEditingController inputCityController = TextEditingController();

  SearchWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(controller.isNight.value
                      ? ImageResources.bakgroundNightImage
                      : ImageResources.bakgroundMorningImage),
                  fit: BoxFit.cover,
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(ConstantData.defaultPadding),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: inputCityController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          label: Text('City name'),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          hintText: 'Input a city name here',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (inputCityController.text == '') {
                                Get.closeAllSnackbars();
                                Get.snackbar("Error",
                                    "You must input a city name to search weather data!",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Palettes.springGreen);
                              } else {
                                controller
                                    .searchWeather(inputCityController.text);
                              }
                            },
                            child: const Text('Search Weather'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              inputCityController.clear();
                              controller.clearData();
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Visibility(
                        visible: controller.weatherData.value != null &&
                            controller.weatherData.value?.countryID != null,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  inputCityController.text,
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: controller.isNight.value
                                          ? Palettes.lightYellow
                                          : Palettes.lightPurple),
                                ),
                                Image.network(
                                  '${ConstantData.flagImageUrl}${controller.weatherData.value?.countryID.toString().toLowerCase()}.png',
                                  height: 30,
                                  width: 30,
                                )
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'Weather',
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            ),
                            Card(
                              color: Palettes.springGreen.withOpacity(0.6),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    ConstantData.defaultPadding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          controller.weatherData.value
                                                  ?.mainInfo ??
                                              '',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                            '(${controller.weatherData.value?.description})'),
                                      ],
                                    ),
                                    FadeInImage(
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          ImageResources.notFoundImage,
                                          fit: BoxFit.fill,
                                          color: Palettes.springGreen,
                                        );
                                      },
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          '${ConstantData.weatherImageUrl}${controller.weatherData.value?.icon}@2x.png'),
                                      placeholder: const AssetImage(
                                          ImageResources.notFoundImage),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                greenCardWithTitle(
                                  'Temperature',
                                  '${controller.weatherData.value?.temperature?.toStringAsFixed(1) ?? ''} ${controller.temperatureType.value}',
                                ),
                                greenCardWithTitle(
                                  'Humidity',
                                  '${controller.weatherData.value?.humidity.toString() ?? '-%'}%',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Wind',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                                const SizedBox(width: 10.0),
                                const Icon(Icons.wind_power),
                                const Icon(Icons.water),
                                const SizedBox(width: 10.0),
                                Card(
                                  color: Palettes.springGreen.withOpacity(0.6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        ConstantData.defaultPadding / 4),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${controller.weatherData.value?.wind.toString()} km/h',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40.0),
                            //Redudant widget,need to move to utils but don't have enough time to move it yet
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Celsius',
                                      style: TextStyle(
                                          color: controller.isNight.value
                                              ? Palettes.lightYellow
                                              : Palettes.lightPurple),
                                    ),
                                    Switch(
                                      value: controller.isCelsius.value,
                                      onChanged: (value) {
                                        controller
                                            .setTemperatureType('celsius');
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Fahrenheit',
                                      style: TextStyle(
                                          color: controller.isNight.value
                                              ? Palettes.lightYellow
                                              : Palettes.lightPurple),
                                    ),
                                    Switch(
                                      value: controller.isFahrenheit.value,
                                      onChanged: (value) {
                                        controller
                                            .setTemperatureType('fahrenheit');
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Kelvin',
                                      style: TextStyle(
                                          color: controller.isNight.value
                                              ? Palettes.lightYellow
                                              : Palettes.lightPurple),
                                    ),
                                    Switch(
                                      value: controller.isKelvin.value,
                                      onChanged: (value) {
                                        controller.setTemperatureType('kelvin');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.isLoading.value,
              child: Container(
                color: Colors.grey.withOpacity(0.7),
                height: double.infinity,
                width: double.infinity,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
