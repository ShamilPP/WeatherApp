import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/result.dart';
import '../services/remote/auth/firebase_authentication.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  Future<Result<String>> sendOTP(int phone) async {
    try {
      var result = await FirebaseAuthentication.sendOTP(phone);
      return result;
    } catch (e) {
      return Result.error('$e');
    }
  }

  Future<Result<UserCredential>> authenticate(String verificationId, String otp) async {
    try {
      var result = await FirebaseAuthentication.authenticate(verificationId, otp);
      return result;
    } catch (e) {
      return Result.error('$e');
    }
  }
}
