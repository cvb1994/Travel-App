import 'package:flutter/foundation.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/model/response_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PlaceProvider extends ChangeNotifier{
  PlaceProvider();

  FirebaseDatabase database = FirebaseDatabase.instance;


  Future<List<PlaceModel>> getPlaces() async{
    List<PlaceModel> listplace = [];
    try {
      DatabaseReference refCategory = database.ref("place");
      DataSnapshot snapshot = await refCategory.get();
      
      if (snapshot.exists) {
          final map = snapshot.value as Map<dynamic, dynamic>;
          map.forEach((key, value) {
            var place = PlaceModel();
            place = PlaceModel.fromMap(value);
            place.id = key;
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

  Future<PlaceModel> getPlace(String id) async {
    try {
      DatabaseReference refCategory = database.ref("place/$id");
      DataSnapshot snapshot = await refCategory.get();
      
      if (snapshot.exists) {
          final map = snapshot.value as Map<dynamic, dynamic>;
          var place = PlaceModel();
          place = PlaceModel.fromMap(map);
          place.id = id;

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

  Future<String> getPlaceImage(String id, int place) async {
    try {
      DatabaseReference refCategory = database.ref("image/$id");
      Query query = refCategory.limitToLast(place);
      DataSnapshot snapshot = await query.get();
      
      if (snapshot.exists) {
          final map = snapshot.value as Map<dynamic, dynamic>;

          return map.values as String;

      } else {
          print('No data available.');
          return "nothing";
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

}