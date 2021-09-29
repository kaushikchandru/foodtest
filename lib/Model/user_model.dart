import 'package:flutter/material.dart';

class UserModel{
  final String userName;
  final String imgUrl;
  final String mailId;
  final String phoneNumber;
  final String userId;

  UserModel({
    required this.userName,
    required this.imgUrl,
    required this.mailId,
    required this.phoneNumber,
  required this.userId});

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return new UserModel(
        userName: parsedJson['userName'] ?? "",
        imgUrl: parsedJson['imgUrl'] ?? "",
        mailId: parsedJson['mailId'] ?? "",
        phoneNumber: parsedJson['phoneNumber'] ?? "",
      userId: parsedJson['userId'] ?? "",
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'userName': userName,
        'imgUrl': imgUrl,
        'mailId': mailId,
        'phoneNumber': phoneNumber,
        'userId': userId,
      };

}