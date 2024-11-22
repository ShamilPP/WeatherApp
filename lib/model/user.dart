import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String name;
  int phone;
  String email;

  User({this.id, required this.name, required this.phone, required this.email});

  // From Document Snapshot
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id, // Getting the document ID
      name: doc['name'],
      phone: doc['phone'],
      email: doc['email'],
    );
  }

  // To JSON (Serialization)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}
