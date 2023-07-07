import 'package:flutter/foundation.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/model/response_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PlaceProvider extends ChangeNotifier{
  PlaceProvider();

  FirebaseDatabase database = FirebaseDatabase.instance;


  Future<List<PlaceModel>> getPlace() async{
    List<PlaceModel> listplace = [];
    try {
      DatabaseReference refCategory = database.ref("place");
      DataSnapshot snapshot = await refCategory.get();
      
      if (snapshot.exists) {
          final map = snapshot.value as Map<dynamic, dynamic>;
          map.forEach((key, value) {
            var place = PlaceModel();
            place.id = key;

            place = PlaceModel.fromMap(value);
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
}