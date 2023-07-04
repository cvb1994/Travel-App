import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/model/auth_model.dart';
import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();

  AuthModel? authModel;
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<ResponseModel> signup(
      String email, String pass, String firstName, String lastName) async {
    ResponseModel resp;
    try {
      final sharePref = await SharedPreferences.getInstance();
      final auth = await instance.createUserWithEmailAndPassword(
          email: email, password: pass);

      await sharePref.setString("userId", auth.user!.uid);

      DatabaseReference refUser = database.ref("users/${auth.user!.uid}");
      await refUser
          .set({"email": email, "firstName": firstName, "lastName": lastName});
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
      final prefs = await SharedPreferences.getInstance();

      final auth = await instance.signInWithEmailAndPassword(
          email: email, password: pass);

      await prefs.setString("userId", auth.user!.uid);
      await prefs.setString("userName", auth.user!.uid);

      resp = ResponseModel(responseCode: ResponseCodeEnum.SUCCESS);
    } on FirebaseAuthException catch (e) {
      resp = ResponseModel(
          responseCode: ResponseCodeEnum.FAIL, message: e.message);
    }
    return resp;
  }

  Future<ResponseModel> updateUserInterest(List<String> places) async {
    ResponseModel resp;
    try {
      final sharePref = await SharedPreferences.getInstance();
      String userId = sharePref.getString("userId") ?? "";

      DatabaseReference refUserInterest = database.ref("users/$userId");
      await refUserInterest.update({"place": places});

      resp = ResponseModel(responseCode: ResponseCodeEnum.SUCCESS);
    } on FirebaseAuthException catch (e) {
      resp = ResponseModel(
          responseCode: ResponseCodeEnum.FAIL, message: e.message);
    }
    return resp;
  }
}
