import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/custom_appbar.dart';

class GalleryWidget extends StatefulWidget{
  final String placeId;
  const GalleryWidget({super.key, required this.placeId});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget>{
  int place = 1;
  int get count => listImage.length;
  List<String> listImage = [];

  late Future<String> futureImageUrl;

  @override
  void initState() {
    // TODO: implement initState
    //futureImageUrl = context.read<PlaceProvider>().getPlaceImage(widget.placeId, place);

    super.initState();
  }

  void load() async {
    print("load");
    listImage.add(await context.read<PlaceProvider>().getPlaceImage(widget.placeId, place));
    place++;
    setState(() {
      print("data count = ${listImage.length}");
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    listImage.clear();
    //load();
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    //await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    load();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(funcType: AppBarFuncENum.OTHER),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: LoadMore(
          isFinish: count >= 5,
          onLoadMore: _loadMore,
          whenEmptyLoad: true,
          delegate: const DefaultLoadMoreDelegate(),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Image.network(listImage[index]),
              );
            },
            itemCount: count,
          ),
        ),
      ),
    );
  }

}