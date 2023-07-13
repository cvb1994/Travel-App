import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:travel/model/user_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();

  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  final storage = FirebaseStorage.instance;

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

      DatabaseReference refUser = database.ref("users/${auth.user!.uid}");
      DataSnapshot snapshot = await refUser.get();
      if (snapshot.exists) {
        final map = snapshot.value as Map<dynamic, dynamic>;
        final LocalStorage storage = new LocalStorage('userJson');
        storage.setItem("user", map);
      }
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

  Future<ResponseModel> updateUser(String firstName, String lastName, String phone, String adreess) async {
    ResponseModel resp;
    try {
      final sharePref = await SharedPreferences.getInstance();
      String userId = sharePref.getString("userId") ?? "";

      DatabaseReference refUserInterest = database.ref("users/$userId");
      await refUserInterest.update({"firstName": firstName, "lastName": lastName, "phone": phone, "address": adreess});

      resp = ResponseModel(responseCode: ResponseCodeEnum.SUCCESS);
    } on FirebaseAuthException catch (e) {
      resp = ResponseModel(
          responseCode: ResponseCodeEnum.FAIL, message: e.message);
    }
    return resp;
  }

  void addUserFavorite(String placeId) async {
    try {
      final sharePref = await SharedPreferences.getInstance();
      String userId = sharePref.getString("userId") ?? "";

      DatabaseReference refUserFav = database.ref("users/$userId/favPlace");
      DatabaseReference favRef = refUserFav.push();

      favRef.set(placeId);

    } on FirebaseAuthException {
    }
  }

  void removeUserFavorite(String placeId) async {
    try {
      final sharePref = await SharedPreferences.getInstance();
      String userId = sharePref.getString("userId") ?? "";

      DatabaseReference refUserFav = database.ref("users/$userId/favPlace");
      DataSnapshot snapshot = await refUserFav.get();
      
      final map = snapshot.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        if(value == placeId){
          DatabaseReference refUserFav = database.ref("users/$userId/favPlace/$key");
          refUserFav.remove();
        }
      });

    } on FirebaseAuthException {
    }
  }

  // UserModel getUser() {
  //   try {
  //     final LocalStorage storage = new LocalStorage('userJson');
  //     Map<dynamic, dynamic> userMap = storage.getItem("user");
  //     var user = UserModel();
  //     user = UserModel.fromJson(userMap);
  //     return user;
  //   } catch (err) {
  //     print(err);
  //     rethrow;
  //   }
  // }

  Future<UserModel> getUser() async {
    try {
      final sharePref = await SharedPreferences.getInstance();
      String userId = sharePref.getString("userId") ?? "";

      DatabaseReference refUser = database.ref("users/$userId");
      DataSnapshot snapshot = await refUser.get();

      if (snapshot.exists) {
        final map = snapshot.value as Map<dynamic, dynamic>;
        var user = UserModel();
        user = UserModel.fromJson(map);
        user.id = userId;

        return user;
      } else {
        print('No data available.');
        return new UserModel();
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  void uploadImage(File file, String fileName) {
    final storageRef = FirebaseStorage.instance.ref("/images/$fileName");

    try {
      UploadTask result = storageRef.putFile(file);
      result.whenComplete(() async {
        String url =  (await storageRef.getDownloadURL()).toString();

        final sharePref = await SharedPreferences.getInstance();
        String userId = sharePref.getString("userId") ?? "";

        DatabaseReference refUserInterest = database.ref("users/$userId");
        await refUserInterest.update({"image": url});
      });
      
    } on FirebaseException {
      // ...
    }
  }
}
