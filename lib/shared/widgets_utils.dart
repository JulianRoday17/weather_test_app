import 'package:flutter/material.dart';

import 'package:weather_app/shared/constants.dart';
import 'package:weather_app/shared/palettes.dart';

Widget greenCardWithTitle(String title, String body) => Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Card(
          color: Palettes.springGreen.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(ConstantData.defaultPadding / 2),
            child: Column(
              children: [
                Text(
                  body,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
