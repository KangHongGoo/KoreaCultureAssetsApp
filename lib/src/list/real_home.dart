import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapmapmap/src/list/performance_list.dart';
import 'package:mapmapmap/src/mainImage/main_img.dart';

import 'package:xml2json/xml2json.dart';


class RealHome extends StatelessWidget {
  const RealHome({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: MainImage(),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("공지사항",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),


          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 2),
              ),
              // child: DataSourceBoard(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("이달의 행사",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 2),
              ),
              child: PerformanceList(),
            ),
          ),

        ],
      ),
    );
  }
}
