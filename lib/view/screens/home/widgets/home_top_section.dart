import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather.dart';

import '../../../../constants/app_colors.dart';

class HomeTopSection extends StatelessWidget {
  final Weather weather;

  HomeTopSection({super.key, required this.weather});

  // Format the date and time
  String formattedDateTime = DateFormat("hh:mm a - EEEE, dd MMM ''yy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.only(left: 16, top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${weather.temp}°',
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: AppColors.white),
          ),
          Text(
            weather.name,
            style: const TextStyle(fontSize: 20, color: AppColors.white),
          ),
          const SizedBox(height: 10),
          Text(
            formattedDateTime,
            style: const TextStyle(fontSize: 14, color: AppColors.white),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
