import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/result.dart';
import '../../../model/user.dart';

class FirebaseService {
  static CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('users');

  static Future<Result<User?>> getUserWithPhone(int phone) async {
    var user = await collection.where('phone', isEqualTo: phone).get();
    if (user.docs.isNotEmpty) {
      var usr = User.fromDocument(user.docs.first);
      return Result.success(usr);
    } else {
      return Result.success(null);
    }
  }

  static Future<Result<User>> uploadUser(User user) async {
    var result = await collection.add(user.toJson());
    user.id = result.id;
    return Result.success(user);
  }
}
