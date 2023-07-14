import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/custom_appbar.dart';

class GalleryWidget extends StatefulWidget {
  final String placeId;
  const GalleryWidget({super.key, required this.placeId});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int place = 4;
  bool isLoading = true;
  bool _isLoadMoreRunning = false;

  late List<String> images;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void fetchData() async {
    images = await context
        .read<PlaceProvider>()
        .getPlaceImage(widget.placeId, place)
        .whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void wait2secont() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoadMoreRunning = false;
    });
  }

  void loadMore() async {
    if (_isLoadMoreRunning) return;
    place += 2;
    images = await context
        .read<PlaceProvider>()
        .getPlaceImage(widget.placeId, place);
    setState(() {
      wait2secont();
      _isLoadMoreRunning = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      EasyLoading.show(status: 'loading...');
      return Container();
    }

    EasyLoading.dismiss();
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
          child: ListView.separated(
              itemCount: images.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                String url = images[index];
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(
                      repeat: ImageRepeat.noRepeat,
                      image: NetworkImage(url),
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ));
                      },
                    ));
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  )),
        ));
  }
}
