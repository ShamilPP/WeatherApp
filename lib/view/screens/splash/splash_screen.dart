import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/screens/login/login_screen.dart';

import '../../../view_model/user_provider.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the init method
      init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 200),
      ),
    );
  }

  void init(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    String? userId = await userProvider.getUserIdFromLocal();
    if (userId != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }
}
