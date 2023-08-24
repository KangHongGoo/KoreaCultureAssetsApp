import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmapmap/src/controller/geolacator_controller.dart';
import 'package:mapmapmap/src/controller/national_treasure_list_controller.dart';
import 'package:mapmapmap/src/controller/treasure_list_controller.dart';
import 'package:mapmapmap/src/mainImage/main_img.dart';
import 'package:mapmapmap/src/mainImage/real_home.dart';

GeolocatorController geolocatorController = Get.put(GeolocatorController());
NationalTreasureListController nationalTreasureListController = Get.put(NationalTreasureListController());
TreasureListController treasureListController = Get.put(TreasureListController());

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  geolocatorController.checkPermission();

  runApp( EasyLocalization(
    saveLocale: true,
    useOnlyLangCode: true,
    supportedLocales: [Locale('en'), Locale('ko')],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    child: MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    nationalTreasureListController.lat1 = geolocatorController.latitude;
    nationalTreasureListController.lng1 = geolocatorController.longitude;
    treasureListController.lat1 = geolocatorController.latitude;
    treasureListController.lng1 = geolocatorController.longitude;

    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'MapMapMap',
      theme: ThemeData(
          fontFamily: 'Goong',
              scaffoldBackgroundColor: Colors.grey[300]
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text('우리나라 문화재'),
          backgroundColor: Colors.blueGrey,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MainImage(),
          ),
          Expanded(
            child: RealHome(),
          ),
        ],
      ),
    );
  }
}