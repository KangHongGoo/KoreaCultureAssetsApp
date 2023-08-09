import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmapmap/src/controller/geolacator_controller.dart';
import 'package:mapmapmap/src/controller/national_treasure_list_controller.dart';
import 'package:mapmapmap/src/controller/treasure_list_controller.dart';
import 'package:mapmapmap/src/list/national_treasure_list.dart';
import 'package:mapmapmap/src/list/real_home.dart';

GeolocatorController geolocatorController = Get.put(GeolocatorController());
NationalTreasureListController nationalTreasureListController = Get.put(NationalTreasureListController());
TreasureListController treasureListController = Get.put(TreasureListController());

void main() {

  geolocatorController.checkPermission();
  runApp(MyApp());

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
      title: 'MapMapMap',
      theme: ThemeData(
      fontFamily: 'Goong'
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
  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    RealHome(),
    NationalTreasureList(),

  ];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black54,),
          label: '?',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, color: Colors.black54,),
              label: '국보/보물 위치'
          ),
         /* BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, color: Colors.black54,),
              label: '체험 정보'
          ),*/
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 16,
        unselectedItemColor: Colors.black87,
        unselectedFontSize: 13,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}