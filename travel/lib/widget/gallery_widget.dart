import 'package:flutter/material.dart';
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
  int place = 3;
  bool _isLoadMoreRunning = false;

  late Future<List<String>> futureImageUrl;

  @override
  void initState() {
    // TODO: implement initState
    futureImageUrl = context.read<PlaceProvider>().getPlaceImage(widget.placeId, place);

    super.initState();
  }

  void wait2secont() async{
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoadMoreRunning = false;
    });
  }

  void loadMore() {
    if(_isLoadMoreRunning) return;
    setState(() {
      _isLoadMoreRunning = true;
    });

    setState(() {
      place+=2;
      futureImageUrl = context.read<PlaceProvider>().getPlaceImage(widget.placeId, place);
      wait2secont();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(funcType: AppBarFuncENum.OTHER),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels <
              scrollInfo.metrics.maxScrollExtent) {
            loadMore();
            return true;
          }
          return false;
        },
        child: FutureBuilder(
          future: futureImageUrl,
          builder: ((context, snapshot){
            List<String> urls = snapshot.data!;
            return ListView.separated(
              itemCount: urls.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index){
                String url = urls[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                  repeat: ImageRepeat.noRepeat,
                  image: NetworkImage(url),
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                    );
                  },
                ));
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              )
            );
          }),
      ),
    ));
  }

}