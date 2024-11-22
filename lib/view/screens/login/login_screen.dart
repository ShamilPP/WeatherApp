import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/screens/login/widgets/login_text_field.dart';

import '../../../constants/app_colors.dart';
import '../../../model/result.dart';
import '../../../view_model/auth_provider.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login screen'),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(),
                SignInLoginSection(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ? ", style: TextStyle(fontSize: 14)),
                    InkWell(
                      splashColor: Colors.blue,
                      child: const Text(
                        'Sign up here',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      onTap: () {
                        Fluttertoast.showToast(msg: 'You can login without sign up');
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Weather app',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'roboto'),
          ),
          SizedBox(height: 10),
          Text(
            'Please sign in to continue',
            style: TextStyle(fontSize: 15, fontFamily: 'roboto'),
          ),
        ],
      ),
    );
  }
}

class SignInLoginSection extends StatefulWidget {
  SignInLoginSection({Key? key}) : super(key: key);

  @override
  State<SignInLoginSection> createState() => _SignInLoginSectionState();
}

class _SignInLoginSectionState extends State<SignInLoginSection> {
  final TextEditingController phoneController = TextEditingController();

  bool isPhoneValid = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Login TextField
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: AppColors.black.withOpacity(.4), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: LoginTextField(
              hint: 'Phone number',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              errorText: !isPhoneValid ? 'Please enter a valid phone number' : null,
              onChanged: (text) {
                if (!isPhoneValid) {
                  setState(() {
                    isPhoneValid = true;
                  });
                }
              },
            ),
          ),

          const SizedBox(height: 40),

          // Login button
          SizedBox(
            width: 130,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
              onPressed: signIn,
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signIn() async {
    int? phone = int.tryParse(phoneController.text);
    setState(() {
      isPhoneValid = phone != null && phoneController.text.length == 10;
    });
    if (isPhoneValid) {
      showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
      var result = await Provider.of<FirebaseAuthProvider>(context, listen: false).sendOTP(phone!);
      if (result.status == ResultStatus.success) {
        String verificationId = result.data!;
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => OtpVerificationScreen(phone: phone, verificationId: verificationId)));
      } else {
        Fluttertoast.showToast(msg: 'Failed : ${result.message}');
      }
    } else {
      Fluttertoast.showToast(msg: 'Failed to enter phone number. Please try again', backgroundColor: Colors.red);
    }
  }
}
