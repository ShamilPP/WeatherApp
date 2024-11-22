import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

import '../../../../constants/app_colors.dart';

class HomeBottomSection extends StatelessWidget {
  final Weather weather;

  const HomeBottomSection({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade300, Colors.orange.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather Condition and Icon
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(weather.main, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.white)),
                      Text(weather.description, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white))
                    ],
                  ),
                ),
                Image.network(
                  'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              label: 'Temp max',
              value: '${weather.tempMax}°',
              icon: Icons.thermostat_outlined,
              iconColor: Colors.red,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              label: 'Temp min',
              value: '${weather.tempMin}°',
              icon: Icons.thermostat_outlined,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              label: 'Humidity',
              value: '${weather.humidity}%',
              icon: Icons.water_drop_outlined,
              iconColor: AppColors.white,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              label: 'Cloudy',
              value: '${weather.cloudiness}%',
              icon: Icons.cloud_outlined,
              iconColor: AppColors.white,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              label: 'Wind',
              value: '${weather.windSpeed.toStringAsFixed(1)} Km/h',
              icon: Icons.air_outlined,
              iconColor: AppColors.white,
            ),
            const SizedBox(height: 20),
            Divider(color: AppColors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: AppColors.white)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 16, color: AppColors.white)),
        const SizedBox(width: 8),
        Icon(icon, size: 20, color: iconColor),
      ],
    );
  }
}
