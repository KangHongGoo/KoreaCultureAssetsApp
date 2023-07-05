import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapmapmap/src/controller/national_treasure_list_controller.dart';
import 'package:get/get.dart';
import 'package:mapmapmap/src/controller/treasure_list_controller.dart';
import 'package:geolocator/geolocator.dart';

class NationalTreasureList extends StatefulWidget {
  NationalTreasureList({Key? key}) : super(key: key);

  @override
  State<NationalTreasureList> createState() => _NationalTreasureListState();
}

final NationalTreasureListController nationalTreasureListController =
    Get.put(NationalTreasureListController());
final TreasureListController treasureListController =
    Get.put(TreasureListController());

class _NationalTreasureListState extends State<NationalTreasureList> {
  String selectedNationalTreasureRegionCode = '서울';
  String selectedTreasureRegionCode = '서울';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Obx(() => nationalTreasureListController.isToggleActive.value
              ? Stack(
                  children: [
                    GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(36.5275, 128.0575),
                          zoom: 7,
                        ),
                        markers:
                            Set<Marker>.from(treasureListController.markers),
                        polylines: Set<Polyline>.from(
                            treasureListController.polylines)),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 22),
                        child: DropdownButton<String>(
                          value: selectedTreasureRegionCode,
                          onChanged: (String? newValue) {
                            selectedTreasureRegionCode = newValue!;
                            String regionCode = treasureListController
                                .treasureRegionData[newValue]!;
                            treasureListController
                                .updateTreasureSelectedRegion(regionCode);
                          },
                          items: treasureListController.treasureRegionData.keys
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.12,
                      right: MediaQuery.of(context).size.width * 0.01,
                      child: FloatingActionButton(
                        onPressed: () {
                          nationalTreasureListController.toggleMarkers();
                        },
                        child: Icon(
                          nationalTreasureListController.isToggleActive.value
                              ? Icons.toggle_on_outlined
                              : Icons.toggle_off_outlined,
                        ),
                      ),
                    )
                  ],
                )
              : Stack(
                  children: [
                    GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(36.5275, 128.0575),
                          zoom: 7,
                        ),
                        markers: Set<Marker>.from(
                            nationalTreasureListController.markers),
                        polylines: Set<Polyline>.from(
                            nationalTreasureListController.polylines)),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 22),
                        child: DropdownButton<String>(
                          value: selectedNationalTreasureRegionCode,
                          onChanged: (String? newValue) {
                            selectedNationalTreasureRegionCode = newValue!;
                            String regionCode = nationalTreasureListController
                                .regionData[newValue]!;
                            nationalTreasureListController
                                .updateSelectedRegion(regionCode);
                          },
                          items: nationalTreasureListController.regionData.keys
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.12,
                      right: MediaQuery.of(context).size.width * 0.01,
                      child: FloatingActionButton(
                        onPressed: () {
                          nationalTreasureListController.toggleMarkers();
                        },
                        child: Icon(
                          nationalTreasureListController.isToggleActive.value
                              ? Icons.toggle_on_outlined
                              : Icons.toggle_off_outlined,
                        ),
                      ),
                    )
                  ],
                )),
        ),
      ],
    ));
  }
}