import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/firebase_options.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/booking/booking_page.dart';
import 'package:travel/pages/place_detail_page.dart';
import 'package:travel/pages/searching_page.dart';
import 'package:travel/pages/welcome_page.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel/pages/dashboard.dart';
import 'package:travel/pages/favorite_page.dart';
import 'package:travel/pages/profile/profile_page.dart';
import 'package:travel/provider/category_provider.dart';
import 'package:travel/provider/place_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PlaceProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter'
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      builder: EasyLoading.init(),
      onGenerateRoute: (settings){
        if (settings.name == Dashboard.routerName) {
          return MaterialPageRoute(
            builder: (context) {
              return const Dashboard();
            },
          );
        }
        if (settings.name == FavoritePage.routerName) {
          return MaterialPageRoute(
            builder: (context) {
              return const FavoritePage();
            },
          );
        }
        if (settings.name == ProfilePage.routerName) {
          return MaterialPageRoute(
            builder: (context) {
              return const ProfilePage();
            },
          );
        }
        if (settings.name == PlaceDetailPage.routerName) {
          final dto = settings.arguments as PlaceModel;

          return MaterialPageRoute(
            builder: (context) {
              return PlaceDetailPage(dto: dto);
            },
          );
        }
        if (settings.name == BookingPage.routerName) {
          final dto = settings.arguments as PlaceModel;

          return MaterialPageRoute(
            builder: (context) {
              return BookingPage(place: dto);
            },
          );
        }
        if (settings.name == SearchingPage.routerName) {
          return MaterialPageRoute(
            builder: (context) {
              return const SearchingPage();
            },
          );
        }
        return null;
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Unknown router with name ${settings.name}'),
          ),
        ),
      ),
    );
  }
}
