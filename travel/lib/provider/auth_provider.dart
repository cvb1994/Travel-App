import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:travel/model/auth_model.dart';
import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();

  AuthModel? authModel;

  Future<ResponseModel> signup(String email, String pass) async {
    ResponseModel resp;
    try {
      FirebaseAuth instance = FirebaseAuth.instance;

      final auth = await instance.createUserWithEmailAndPassword(
          email: email, password: pass);

      resp = ResponseModel(responseCode: ResponseCodeEnum.SUCCESS);
    } on FirebaseAuthException catch (e) {
      resp = ResponseModel(
          responseCode: ResponseCodeEnum.FAIL, message: e.message);
    }
    return resp;
  }

  Future<ResponseModel> login(String email, String pass) async {
    ResponseModel resp;
    try {
      FirebaseAuth instance = FirebaseAuth.instance;

      final auth = await instance.signInWithEmailAndPassword(
          email: email, password: pass);

      resp = ResponseModel(responseCode: ResponseCodeEnum.SUCCESS);
    } on FirebaseAuthException catch (e) {
      resp = ResponseModel(
          responseCode: ResponseCodeEnum.FAIL, message: e.message);
    }
    return resp;
  }
}