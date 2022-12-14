// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

class WeatherModel {
  WeatherModel({
    this.icon,
    this.mainInfo,
    this.description,
    this.temperature,
    this.humidity,
    this.countryID,
    this.wind,
  });

  String? icon;
  String? mainInfo;
  String? description;
  double? temperature;
  int? humidity;
  String? countryID;
  double? wind;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        icon: json['weather'][0]['icon'] ?? '',
        mainInfo: json['weather'][0]['main'] ?? '',
        description: json['weather'][0]['description'] ?? '',
        temperature: json['main']['temp'] ?? 0.0, //kelvin
        humidity: json['main']['humidity'] ?? 0,
        countryID: json['sys']['country'] ?? '',
        wind: json['wind']['speed'] ?? 0.0,
      );
}
