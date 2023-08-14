import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapmapmap/src/detail/national_treasure_detail.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

class NationalTreasureListController extends GetxController {
  RxDouble lat1 = 0.0.obs;
  RxDouble lng1 = 0.0.obs;

  var isToggleActive = false.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  var regionData = <String, String>{
    '서울': '11',
    '부산': '21',
    '광주': '24',
    '울산': '26',
    '경기': '31',
    '강원': '32',
    '충북': '33',
    '충남': '34',
    '전북': '35',
    '전남': '36',
    '경북': '37',
    '경남': '38',
  };

  String selectedNationalTreasureRegionCode = '11';

  // ccbaCtcd = 시도코드
  void updateSelectedRegion(String ccbaCtcd) {
    selectedNationalTreasureRegionCode = ccbaCtcd;
    polylines.clear(); // 지역 변경 할 때 마다 폴리라인 초기화
    loadData();
  }

  void toggleMarkers() {
    isToggleActive.value = !isToggleActive.value;
  }

  Future<void> loadData() async {
    markers.value =
        await LoadNationalTreasureList(selectedNationalTreasureRegionCode);
  }

  void clearMarkers() {
    markers.clear();
  }
      // lat1, lng1 과 lat2 , lng2 두 지점 사이에 경로를 찾기 위한 함수
  Future<List<dynamic>> LoadPositions(
      double lat1, double lng1, double lat2, double lng2) async {
    String url =
        'https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start=${lat1},${lng1}&goal=${lat2},${lng2}&option=traoptimal';

    final response = await http.get(Uri.parse(url), headers: {
      "X-NCP-APIGW-API-KEY-ID": "ywb9wu3rko",
      "X-NCP-APIGW-API-KEY": "cQn8PC5mMhXlaB8LRu7RBdT1zPdj1pgYl0VaiCGL",
    });
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    Map<String, dynamic> data1 = data['route'];

    List<dynamic> data2 = data1['traoptimal'];

    List<dynamic> positions = data2[0]['path'];

    return positions;
  }

  Future<Set<Marker>> LoadNationalTreasureList(String ccbaCtcd) async {

    // 지역별로 나누기 위해 지역코드인 ccbaCtcd를 변수로 선언
    String url =
        "http://www.cha.go.kr/cha/SearchKindOpenapiList.do?ccbaKdcd=11&pageUnit=400&ccbaCtcd=${ccbaCtcd}";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );
    // API가 XML형식이어서 JSON으로 변환
    final getXmlData = response.body;
    final Xml2JsonData = Xml2Json()..parse(getXmlData);
    final jsonData = Xml2JsonData.toParker();

    Map<String, dynamic> data = jsonDecode(jsonData);

    List<dynamic> items = data['result']['item'];

    Set<Marker> markers = {};
    Set<Marker> tempMarkers = {};

    for (var item in items) {
      String ccbaAsno = item['ccbaAsno'];
      String ccbaCtcd = item['ccbaCtcd'];

      //커스텀 마커를 생성
      BitmapDescriptor customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(1, 1)),
        'assets/pin_last.png',
      );

      Marker marker = Marker(
          markerId: MarkerId(item['no']),
          infoWindow: InfoWindow(           // 마커를 탭하면 정보 창 표시
              title: "${item['ccbaMnm1']}", // 문화재 명
              snippet: "${item['ccbaAdmin']}", // 지역 or 보관장소
              onTap: () {                     // 정보 창을 탭 했을 시 자세히보기로 넘어감
                Get.to(NationalTreasureDetail(
                    ccbaAsno: ccbaAsno, ccbaCtcd: ccbaCtcd
                )
                );
              }
              ),
          position: LatLng(
              double.parse(item['latitude']), double.parse(item['longitude']) // 마커의 위치에 필요한 좌표값
          ),
          icon: customMarkerIcon,
          onTap: () async {    // 마커를 탭 할 시에 지정된 마커의 위치와 현재 위치 사이에 경로를 가져옴
            List<dynamic> coordinatesData = await LoadPositions(
                lng1.toDouble(),
                lat1.toDouble(),
                double.parse(item['longitude']),
                double.parse(item['latitude']));

            List<List<double>> newData = coordinatesData   // 위에서 가져온 좌표를 List<double> 형태로 변환
                .map<List<double>>((e) => List<double>.from(e))
                .toList();
            List<LatLng> positions =              // 변환된 좌표 데이터를 LatLng 객체로 변환하여 저장
                newData.map((e) => LatLng(e[1], e[0])).toList();
            polylines.value = {                   // 폴리라인 생성 및 디자인
              (Polyline(
                polylineId: PolylineId("1"),
                points: positions,
                width: 4,
                color: Color.fromRGBO(255, 0, 0, 0.5),
                patterns: [PatternItem.dash(10), PatternItem.gap(10)],
              ))
            };
          });

      tempMarkers.add(marker);
    }
    markers = tempMarkers;
    return markers;
  }
}
