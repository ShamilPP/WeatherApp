import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/model/result.dart';

import '../../../model/user.dart';
import '../../../view_model/user_provider.dart';
import '../splash/splash_screen.dart';

class LoginDetailsScreen extends StatelessWidget {
  final int phone;

  LoginDetailsScreen({super.key, required this.phone});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Let's get to know each other! What's your name?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 15),
            TextField(
              style: const TextStyle(color: Colors.black, fontSize: 16),
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Hey! Let's catch up soon! What's your email?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            TextField(
              style: const TextStyle(color: Colors.black, fontSize: 16),
              controller: emailsController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  String name = nameController.text;
                  String email = emailsController.text;
                  if (name.isNotEmpty && email.isNotEmpty) {
                    //show loading dialog
                    showDialog(context: context, builder: (ctx) => const Center(child: CircularProgressIndicator()));
                    // Upload user
                    User user = User(name: name, phone: phone, email: email);
                    var uploadResult = await Provider.of<UserProvider>(context, listen: false).createUser(context, user);
                    //Dismiss loading dialog
                    Navigator.pop(context);
                    // If success goto home screen
                    if (uploadResult.status == ResultStatus.success) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SplashScreen()));
                    } else {
                      Fluttertoast.showToast(msg: 'Error: ${uploadResult.message}', backgroundColor: Colors.red);
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Fill all empty box', backgroundColor: Colors.red);
                  }
                },
                child: const Text('Verify'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
