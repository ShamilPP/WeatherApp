import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/screens/splash/splash_screen.dart';
import 'package:weather_app/view_model/auth_provider.dart';
import 'package:weather_app/view_model/user_provider.dart';
import 'package:weather_app/view_model/weather_provider.dart';

import 'constants/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
