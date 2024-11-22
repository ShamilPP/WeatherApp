import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/view/screens/home/widgets/home_bottom_section.dart';
import 'package:weather_app/view/screens/home/widgets/home_top_section.dart';
import 'package:weather_app/view_model/weather_provider.dart';

import '../../../model/result.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// Shows Malappuram city's weather on app launch.
      Provider.of<WeatherProvider>(context, listen: false).loadWeather('Malappuram');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: searchController,
                cursorColor: AppColors.white,
                style: TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.primaryColor,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: AppColors.white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: AppColors.white),
                    onPressed: () => _searchCity(context),
                  ),
                ),
                onSubmitted: (text) => _searchCity(context),
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: Consumer<WeatherProvider>(
        builder: (ctx, provider, child) {
          switch (provider.weather.status) {
            case ResultStatus.success:
              return Column(
                children: [
                  HomeTopSection(weather: provider.weather.data!),
                  Expanded(child: HomeBottomSection(weather: provider.weather.data!)),
                ],
              );
            case ResultStatus.loading:
              return Center(child: SpinKitFadingCube(color: AppColors.primaryColor, size: 25));
            case ResultStatus.failed:
              return Center(child: Text('Error : ${provider.weather.message}'));
            case ResultStatus.idle:
              return const SizedBox();
          }
        },
      ),
    );
  }

  void _searchCity(BuildContext context) {
    if (searchController.text.isNotEmpty) Provider.of<WeatherProvider>(context, listen: false).loadWeather(searchController.text);
  }
}
