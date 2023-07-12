// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? image;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.image
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'image': image
      };
}
