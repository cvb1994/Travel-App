import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/SubMenuWidget.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';
import 'package:travel/provider/category_provider.dart';
import 'package:travel/widget/gallery_widget.dart';
import 'package:travel/widget/package_booking.dart';
import 'package:travel/widget/placeWidget.dart';

class PlaceDetailPage extends StatefulWidget {
  static const routerName = "/placeDetail";
  final PlaceModel dto;
  const PlaceDetailPage({super.key, required this.dto});

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  late Future<List<CategoryModel>> futureListCategory;
  late Future<PlaceModel> futurePlace;
  late Future<List<String>> futureImage;
  
  @override
  void initState() {
    // TODO: implement initState
    futureListCategory = context.read<CategoryProvider>().getCategories();
    futurePlace = context.read<PlaceProvider>().getPlace(widget.dto.id!);
    futureImage = context.read<PlaceProvider>().getPlaceImage(widget.dto.id!, 3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar.withTitleFunc(funcType: AppBarFuncENum.FAV, title: widget.dto.name,),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$${widget.dto.price}",
                      style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(
                      text: '/Person',
                    )
                  ]
                )
              ),
            )),
            Expanded(child: Center(
              child: Padding(padding: EdgeInsets.all(10), child: CustomButton(title: 'Booking', color: Colors.yellow, func: () {  },),),
            ))
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(198, 245, 244, 243),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth, vertical: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 220,
                child: FutureBuilder(
                  future: futurePlace,
                  builder: ((context, snapshot) {
                    PlaceModel place = snapshot.data!;
                    return PlaceWidget(imagePath: place.image!, name:  place.name!, location:  place.location!, rate:  place.rate!, width: double.infinity,);
                  }),
                )
                //child: PlaceWidget(imagePath: place.image!, name:  place.name!, location:  place.location!, rate:  place.rate!, width: double.infinity,),
              ),
              const SubRowMenu(name: "What's Included", buttonName: "",),
              SizedBox(
                height: 70,
                child: FutureBuilder(
                  future: futureListCategory,
                  builder: ((context, snapshot) {
                    List<CategoryModel> categories = snapshot.data!;
                    return ListView.separated(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index){
                        CategoryModel model = categories[index];
                        return CategoryWidget(name: model.name!, imagePath: model.image!,);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      )
                    );
                  }),
                )
              ),
              const SubRowMenu(name: "About Trip", buttonName: "",),
              Container(
                child: FutureBuilder(
                  future: futurePlace,
                  builder: ((context, snapshot) {
                    PlaceModel place = snapshot.data!;
                    return Text(place.des!);
                  }),
                ),
              ),
              const SubRowMenu(name: "Gallery Photo", buttonName: "",),
              SizedBox(
                height: 100,
                child: FutureBuilder(
                  future: futureImage,
                  builder: ((context, snapshot){
                    List<String> urls = snapshot.data!;
                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5), 
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GalleryWidget(placeId: widget.dto.id!),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: NetworkImage(urls[0]), fit: BoxFit.cover))
                              ))
                        )),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5), 
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GalleryWidget(placeId: widget.dto.id!),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: NetworkImage(urls[1]), fit: BoxFit.cover))
                              ))
                        )),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5), 
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GalleryWidget(placeId: widget.dto.id!),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: NetworkImage(urls[2]), fit: BoxFit.cover))
                              ))
                        )),
                        
                      ],
                    );
                  }),
                ),
              ),
              const SubRowMenu(name: "Location", buttonName: "",),
              
            ],
          ),
        ),
      ),
    );
  }
}

