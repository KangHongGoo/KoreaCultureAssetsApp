import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapmapmap/src/controller/geolacator_controller.dart';
import 'package:mapmapmap/src/list/culture_assets_list.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RealHome extends StatefulWidget {
  const RealHome({Key? key}) : super(key: key);

  @override
  State<RealHome> createState() => _RealHomeState();
}

class _RealHomeState extends State<RealHome> {

  final GeolocatorController geolocatorController = Get.put(
      GeolocatorController());


   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 100,
              child: FutureBuilder<Map<String, dynamic>> (
                future: weatherData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else{
                    final weather = snapshot.data;

                    final temperature = weather?['main']['temp'];
                    final celsiusTemp = convert(temperature);
                    final humidity = weather?['main']['humidity'];
                    final nowWeather = weather?['weather'][0]['main'] as String?;
                    final imageUrl = "http://openweathermap.org/img/w/" + weather?['weather'][0]['icon'] + ".png" ;
                    return Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 10, 10),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 10,
                              offset: Offset(1.1, 1.1),
                            )]
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                                imageUrl,
                              width: 80, // 이미지 너비 지정
                              height: 80, // 이미지 높이 지정
                            ),
                            SizedBox(width: 30),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("날씨 : ${nowWeather}"),
                                  Text("현재기온 : ${celsiusTemp.toStringAsFixed(2)}°C"),
                                  Text("습도 : ${humidity}%"),
                                ],
                              ),],
                        ),
                      ),
                    );
                  }
                  },
              )
          ),
          Text('문화재 위치 알아보기'),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                  width: 1
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 10,
                    offset: Offset(1.1, 1.1)
                  )
                ]
              ),
              child: Center(
                child: InkWell(
                  child: Image.asset('assets/main_img.png'),
                  onTap: () {
                    Get.to(CultureAssetsList());
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> weatherData() async {
    String url = "https://api.openweathermap.org/data/2.5/weather?lat=${geolocatorController.latitude.value}&lon=${geolocatorController.longitude.value}&appid=d765639421cd68b579439638ef7da4b7";

    final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        }
    );
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  }
  double convert(dynamic value) {
    if (value is int) {
      return (value.toDouble() - 273.15);
    } else if (value is double) {
      return (value - 273.15);
    } else {
      throw Exception('Unexpected data type for temperature');
    }
  }
}

