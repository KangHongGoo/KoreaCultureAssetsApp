import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../datatypes/board.dart';

class DataSourceBoard {

  Future<List<Board>> findAll() async {
    try {
      final url = Uri.parse("http://10.0.2.2:9000/board-service/list"); // 각자 본인 컴퓨터의 localhost로 설정
      print(url);
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        List<Board> boardList = [];
        var jsonBody=jsonDecode(response.body);

        var jsonResult = jsonBody["result"];
        for (var jsonBoard in jsonResult) {
          Board board = Board.fromJson(jsonBoard);

          boardList.add(board);
        }
        return boardList;
      } else {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("공지사항 가져오기 실패");
    }
  }
}





// board_detail.dart 파일 // getx폴더에 넣고 사용