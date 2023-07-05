import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class PerformanceDateDetail {
  final headers = {'Content-Type': 'application/json'};

  Future<List<dynamic>> UniqueSidoList(String searchYear, String searchMonth) async {
    final url = Uri.parse("https://www.cha.go.kr/cha/openapi/selectEventListOpenapi.do?searchYear=${searchYear}&amp;searchMonth=${searchMonth}");

    final response = await http.get(url, headers: headers);

    final getXmlData = response.body;
    final Xml2JsonData = Xml2Json()..parse(getXmlData);
    final jsonData = Xml2JsonData.toParker();

    Map<String, dynamic> data = jsonDecode(jsonData);

    List<dynamic> uniqueSidoList = [];

    for (dynamic item in data['result']['item']) {
      uniqueSidoList.add(item['sido']);
    }

    uniqueSidoList = removeDuplicates(uniqueSidoList);

    return uniqueSidoList;
  }

  Future<List<dynamic>> UniqueSubtitleList(String searchYear, String searchMonth, int searchDay, String sido) async {
    final url = Uri.parse("https://www.cha.go.kr/cha/openapi/selectEventListOpenapi.do?searchYear=${searchYear}&amp;searchMonth=${searchMonth}");

    final response = await http.get(url, headers: headers);

    final getXmlData = response.body;
    final Xml2JsonData = Xml2Json()..parse(getXmlData);
    final jsonData = Xml2JsonData.toParker();

    Map<String, dynamic> data = jsonDecode(jsonData);

    List<dynamic> uniqueSubtitleList = [];

    for (dynamic item in data['result']['item']) {
      final getSido = item['sido'];
      final getSubtitle = item['subTitle'];
      final getSDate = item['sDate'];
      final getEDate = item['eDate'];

      if(getSDate.isNotEmpty&&getEDate.isNotEmpty){
        final sDay = int.parse(getSDate.replaceAll(' ', '').substring(6));
        final eDay = int.parse(getEDate.replaceAll(' ', '').substring(6));

        if(getSido==sido&&
            getSubtitle!=null&&
            sDay<=searchDay&&
            eDay>=searchDay){
          uniqueSubtitleList.add(getSubtitle);
        }
      }
    }

    uniqueSubtitleList = removeDuplicates(uniqueSubtitleList);

    return uniqueSubtitleList;
  }

  List<T> removeDuplicates<T>(List<T> list) {
    Set<T> itemSet = Set<T>.from(list);
    return itemSet.toList()..sort();
  }
}