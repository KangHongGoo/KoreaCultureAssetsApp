import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapmapmap/src/datatypes/reservation.dart';


class DataSource {
  Future<Reservation> createReservation(String? boardId, String name, DateTime reservationDate, int count, String phoneNum) async {
    try {
      final url = Uri.parse("http://10.0.2.2:9000/reserve-service/reserve"); // 각자 본인 컴퓨터의 localhost로 설정

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        'bid': boardId,
        'username': name,
        'reservationDate': "${reservationDate.year.toString().padLeft(4, '0')}"
            "-${reservationDate.month.toString().padLeft(2, '0')}"
            "-${reservationDate.day.toString().padLeft(2, '0')}",
        'numberOfPeople': count.toString(),
        'phoneNum':phoneNum,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonBody=jsonDecode(response.body);
        Reservation reservation = Reservation.fromJson(jsonBody["result"]);
        return reservation;
      } else {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("예약에 실패했습니다.");
    }
  }

  Future<List<Reservation>> findReservation(String name, String phoneNum) async {
    try {
      final url = Uri.parse("http://10.0.2.2:9000/reserve-service/${name}/${phoneNum}"); // 각자 본인 컴퓨터의 localhost로 설정
      print(url);
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        List<Reservation> reservationList = [];
        var jsonBody=jsonDecode(response.body);
        var jsonResult = jsonBody["result"];

        for (var jsonReservation in jsonResult) {
          Reservation reservation = Reservation.fromJson(jsonReservation);
          reservationList.add(reservation);
        }

        return reservationList;
      } else {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("예약 취소 실패");
    }
  }

  Future<void> deleteReservation(List<dynamic> list, String name, String phoneNum) async {
    try {
      final url = Uri.parse("http://10.0.2.2:9000/reserve-service");

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        'username': name,
        'phoneNum':phoneNum,
        'list':list,
      });

      final response = await http.delete(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('에러 : ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      throw Exception("예약 취소에 실패했습니다.");
    }
  }
}



// reservation_detail.dart 파일

