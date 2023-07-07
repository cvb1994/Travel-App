class PlaceModel {
  String? id;
  String? name;
  String? location;
  double?  rate;
  String? image;
  double? price;
  String? des;

  PlaceModel({
    this.id,
    this.name, 
    this.location,
    this.rate,
    this.image,
    this.price,
    this.des,
  });

  factory PlaceModel.fromMap(Map<dynamic, dynamic> data) => PlaceModel(
    name: data['name'] as String?,
    location: data['location'] as String?,
    rate: data['rate'] as double?,
    image: data['imageURL'] as String?,
    price: data['price'] as double?,
    des: data['des'] as String?,
  );

}