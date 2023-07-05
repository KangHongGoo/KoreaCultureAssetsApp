import 'dart:convert';

import 'package:intl/intl.dart';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
  String boardId;
  String name;
  DateTime reservationDate;
  int count;
  String phoneNum;

  Reservation({
    required this.boardId,
    required this.name,
    required this.reservationDate,
    required this.count,
    required this.phoneNum,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    String dateString = json["reservationDate"];
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime dateTime = format.parse(dateString);
    // 문자열을 DateTime으로 파싱

    return Reservation(
      boardId: json["bid"],
      name: json["username"],
      reservationDate: dateTime,
      count: json["numberOfPeople"],
      phoneNum: json["phoneNum"],
    );
  }


  Map<String, dynamic> toJson() => {
    "bid": boardId,
    "username": name,
    "reservationDate": "${reservationDate.year.toString().padLeft(4, '0')}-${reservationDate.month.toString().padLeft(2, '0')}-${reservationDate.day.toString().padLeft(2, '0')}",
    "numberOfPeople": count.toString(),
    "phoneNum": phoneNum,
  };

  @override
  String info() {
    return 'Reservation{boardId: $boardId, name: $name, reservationDate: $reservationDate, count: $count, phoneNum: $phoneNum}';
  }
}


// dataSource.dart 파일

