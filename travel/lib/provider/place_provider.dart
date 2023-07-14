import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/model/place_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PlaceProvider extends ChangeNotifier {
  PlaceProvider();

  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<List<PlaceModel>> getPlaces() async {
    print("load places");
    List<PlaceModel> listplace = [];
    try {
      final sharePref = await SharedPreferences.getInstance();
      String? favPlaceStr = sharePref.getString("favPlace");
      List<String> favPlaces = favPlaceStr!.split(",");

      DatabaseReference refCategory = database.ref("place");
      DataSnapshot snapshot = await refCategory.get();

      if (snapshot.exists) {
        final map = snapshot.value as Map<dynamic, dynamic>;
        map.forEach((key, value) {
          var place = PlaceModel();
          place = PlaceModel.fromMap(value);
          place.id = key;
          if (favPlaces.contains(key)) {
            place.isFav = true;
          } else {
            place.isFav = false;
          }

          listplace.add(place);
        });

        return listplace;
      } else {
        print('No data available.');
        return listplace;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<PlaceModel>> getFavoritePlaces() async {
    List<PlaceModel> listplace = [];
    try {
      final sharePref = await SharedPreferences.getInstance();
      String? favPlaceStr = sharePref.getString("favPlace");
      List<String> favPlaces = favPlaceStr!.split(",");

      DatabaseReference refCategory = database.ref("place");
      DataSnapshot snapshot = await refCategory.get();

      if (snapshot.exists) {
        final map = snapshot.value as Map<dynamic, dynamic>;
        map.forEach((key, value) {
          var place = PlaceModel();
          place = PlaceModel.fromMap(value);
          place.id = key;
          if (favPlaces.contains(key)) {
            place.isFav = true;
            listplace.add(place);
          }
        });

        return listplace;
      } else {
        print('No data available.');
        return listplace;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<PlaceModel> getPlace(String id) async {
    try {
      DatabaseReference refCategory = database.ref("place/$id");
      DataSnapshot snapshot = await refCategory.get();

      final sharePref = await SharedPreferences.getInstance();
      String? favPlaceStr = sharePref.getString("favPlace");
      List<String> favPlaces = favPlaceStr!.split(",");

      if (snapshot.exists) {
        final map = snapshot.value as Map<dynamic, dynamic>;
        var place = PlaceModel();
        place = PlaceModel.fromMap(map);
        place.id = id;
        if (favPlaces.contains(id)) {
          place.isFav = true;
        } else {
          place.isFav = false;
        }

        return place;
      } else {
        print('No data available.');
        return new PlaceModel();
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<String>> getPlaceImage(String id, int place) async {
    List<String> listImage = [];
    try {
      DatabaseReference refCategory = database.ref("image/$id");
      Query query = refCategory.limitToFirst(place);
      DataSnapshot snapshot = await query.get();

      if (snapshot.exists) {
        final map = snapshot.value as List<Object?>;
        for (var m in map) {
          listImage.add(m as String);
        }
        return listImage;
      } else {
        print('No data available.');
        return listImage;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<String>> getFavoritedPlacesId() async {
    List<String> listplace = [];
    try {
      final sharePref = await SharedPreferences.getInstance();
      String userId = sharePref.getString("userId") ?? "";

      DatabaseReference refUserFav = database.ref("users/$userId/favPlace");
      DataSnapshot snapshot = await refUserFav.get();

      final map = snapshot.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        listplace.add(value);
      });

      return listplace;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
