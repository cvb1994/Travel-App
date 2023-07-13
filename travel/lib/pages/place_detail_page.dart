import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/booking/booking_page.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/SubMenuWidget.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/provider/category_provider.dart';
import 'package:travel/widget/gallery_widget.dart';
import 'package:travel/widget/placeWidget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PlaceDetailPage extends StatefulWidget {
  static const routerName = "/placeDetail";
  final PlaceModel dto;
  const PlaceDetailPage({super.key, required this.dto});

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  late List<CategoryModel> listCategory;
  late PlaceModel place;
  late List<String> images;
  int countCompleted = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void fetchData() async{
    listCategory = await context.read<CategoryProvider>().getCategories().whenComplete(() {
      countCompleted++;
      setState(() {});
    });
    place = await context.read<PlaceProvider>().getPlace(widget.dto.id!).whenComplete(() {
      countCompleted++;
      setState(() {});
    });
    images = await context.read<PlaceProvider>().getPlaceImage(widget.dto.id!, 3).whenComplete(() {
      countCompleted++;
      setState(() {});
    });
    
  }

  @override
  Widget build(BuildContext context) {

    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;
    if(countCompleted < 3){
      EasyLoading.show(status: 'loading...');
      return Container();
    }

    EasyLoading.dismiss();
    return Scaffold(
      appBar: CustomAppBar.withTitleFunc(funcType: AppBarFuncENum.FAV, title: widget.dto.name, placeId: widget.dto.id!, isFav: place.isFav,),
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
              child: Padding(padding: EdgeInsets.all(10), child: CustomButton(title: 'Booking', color: Colors.yellow, func: () { 
                Navigator.of(context).pushNamed(BookingPage.routerName, arguments: place);
              }),),
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
                child: PlaceWidget(imagePath: place.image!, name:  place.name!, location:  place.location!, rate:  place.rate!, width: double.infinity,)
                //child: PlaceWidget(imagePath: place.image!, name:  place.name!, location:  place.location!, rate:  place.rate!, width: double.infinity,),
              ),
              const SubRowMenu(name: "What's Included", buttonName: "",),
              SizedBox(
                height: 70,
                child: LayoutBuilder(
                  builder: ((context, builder){
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(width: 15,),
                      scrollDirection: Axis.horizontal,
                      itemCount: listCategory.length,
                      itemBuilder: (BuildContext context, int index){
                        CategoryModel model = listCategory[index];
                        return CategoryWidget(name: model.name!, imagePath: model.image!,);
                      }, 
                    );
                  })
                ),
              ),
              const SubRowMenu(name: "About Trip", buttonName: "",),
              Text(place.des!),
              const SubRowMenu(name: "Gallery Photo", buttonName: "",),
              
              SizedBox( 
                height: 100,
                child: LayoutBuilder(
                  builder: ((context, builder){
                    if(images.isEmpty) return Container();
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
                                  image: DecorationImage(image: NetworkImage(images[0]), fit: BoxFit.cover))
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
                                  image: DecorationImage(image: NetworkImage(images[1]), fit: BoxFit.cover))
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
                                  image: DecorationImage(image: NetworkImage(images[2]), fit: BoxFit.cover))
                              ))
                        )),
                        
                      ],
                    );
                  })
                )
              ),
              const SubRowMenu(name: "Location", buttonName: "",),
              
            ],
          ),
        ),
      ),
    );
  }
}

