import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';




class PerformanceList extends StatelessWidget{

  PerformanceList({Key? key}) : super(key: key);

  //xml->json 변환
  Future<List<Map<String, dynamic>>> loadTitleData() async {
    try{
      String url = "http://www.cha.go.kr/cha/openapi/selectEventListOpenapi.do?searchYear=2023&searchMonth=6";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final getXmlData = response.body;
      final Xml2JsonData = Xml2Json()..parse(getXmlData);
      final jsonData = Xml2JsonData.toParker();

      Map<String, dynamic> data = jsonDecode(jsonData);

//데이터 불러옴
      List<Map<String, dynamic>> dataList = [];

      //불러온 데이터 중에서 필요한 요소 선택
      for (dynamic item in data['result']['item']) {
        Map<String, dynamic> moreData = {
          'title' : item['subTitle'],
          'StartDate' : int.tryParse(item['sDate'] ?? '') ?? 0,
          'EndDate' : int.tryParse(item['eDate'] ?? '') ?? 0,
          'subDate' : item['subDate']
        };

//선택요소 관련 조건문 : eDate값이 0인 경우 제외
        if (moreData['EndDate'] != 0) {
          dataList.add(moreData);
        }
      }

      dataList = removeDuplicates(dataList);

      return dataList;

    } catch (error) {
      print(error);
      throw Exception("Failed to load title data"); // 오류 발생 시 예외를 던져줌
    }

  }

//중복되는 것 삭제
  List<Map<String, dynamic>> removeDuplicates(List<Map<String, dynamic>> list) {
    Map<String, Map<String, dynamic>> uniqueMap = {};

    for (var item in list) {
      String title = item['title'];
      int endDate = item['EndDate'];

      if (!uniqueMap.containsKey(title) || endDate > uniqueMap[title]!['EndDate']) {
        uniqueMap[title] = item;
      }
    }

    List<Map<String, dynamic>> uniqueList = uniqueMap.values.toList();
    uniqueList.sort((a, b) => a['EndDate'].compareTo(b['EndDate'])); // 마감일 오름차순으로 정렬

    return uniqueList;
  }



//화면에 나타나는 구조
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadTitleData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            return ListView.builder(
              itemExtent: 50, // 각 ListTile의 높이
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = dataList[index];
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(30, 5, 20, 24), // 내용 주위 여백 조정, B:title-subtitle간격!
                  title: Text(item['title']),
                  subtitle: Align(alignment: Alignment.bottomRight,
                    child: Text(
                        '${item['subDate']}',

                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error"); // 데이터 로딩 중 오류가 발생한 경우 오류 메시지 출력
          } else {
            return CircularProgressIndicator(); // 데이터 로딩 중일 때 로딩 표시기 표시
          }
        },
      ),
    );
  }

}