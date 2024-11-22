import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/services/remote/firestore/firebase_service.dart';
import 'package:weather_app/view/screens/login/login_details_screen.dart';

import '../model/result.dart';
import '../model/user.dart';
import '../services/local/local_service.dart';
import '../view/screens/home/home_screen.dart';

class UserProvider extends ChangeNotifier {
  Future login(BuildContext context, int phone) async {
    try {
      var user = await FirebaseService.getUserWithPhone(phone);
      if (user.status == ResultStatus.success && user.data != null) {
        // Save user in SharedPreferences
        LocalService.saveUser(user.data!.id!);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginDetailsScreen(phone: phone)), (route) => false);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<Result<User>> createUser(BuildContext context, User user) async {
    var uploadUserResult = await FirebaseService.uploadUser(user);
    if (uploadUserResult.status == ResultStatus.success) {
      // Save user in SharedPreferences
      LocalService.saveUser(uploadUserResult.data!.id!);
      return Result.success(uploadUserResult.data!);
    } else {
      return Result.error(uploadUserResult.message);
    }
  }

  Future setUserIdToLocal(String id) async {
    await LocalService.saveUser(id);
  }

  Future<String?> getUserIdFromLocal() async {
    String? docId = await LocalService.getUser();
    return docId;
  }
}
