import 'package:flutter/foundation.dart';
import 'package:travel/model/response_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:travel/model/category_model.dart';

class CategoryProvider extends ChangeNotifier{
  CategoryProvider();

  FirebaseDatabase database = FirebaseDatabase.instance;


  Future<List<CategoryModel>> getCategories() async{
    List<CategoryModel> listCate = [];
    try {
      DatabaseReference refCategory = database.ref("categories");
      DataSnapshot snapshot = await refCategory.get();
      
      if (snapshot.exists) {
          final map = snapshot.value as List<Object?>;
          
          for (var m in map) {
            if(m == null) continue;
            final item = m as Map<dynamic, dynamic>;
              var category = CategoryModel();
              item.forEach((key, value) {
                if(key == "name"){
                  category.name = value;
                } else {
                  category.image = value;
                }
              });
              listCate.add(category);
          }

          print(listCate);
          return listCate;
      } else {
          print('No data available.');
          return listCate;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
    
  }
}