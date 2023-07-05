import 'dart:convert';

List<Treasure> treasureFromJson(String str) => List<Treasure>.from(json.decode(str).map((x) => Treasure.fromJson(x)));

class Treasure {
  int sn;
  int no;
  String ccmaName;
  String crltsnoNm;
  String ccbaMnm1;
  String ccbaMnm2;
  String ccbaCtcdNm;
  String ccsiName;
  String ccbaAdmin;
  String ccbaKdcd;
  String ccbaCtcd;
  String ccbaAsno;
  String ccbaCncl;
  String ccbaCpno;
  double longitude;
  double latitude;

  Treasure({
    required this.sn,
    required this.no,
    required this.ccmaName,
    required this.crltsnoNm,
    required this.ccbaMnm1,
    required this.ccbaMnm2,
    required this.ccbaCtcdNm,
    required this.ccsiName,
    required this.ccbaAdmin,
    required this.ccbaKdcd,
    required this.ccbaCtcd,
    required this.ccbaAsno,
    required this.ccbaCncl,
    required this.ccbaCpno,
    required this.longitude,
    required this.latitude,
  });

  factory Treasure.fromJson(Map<String, dynamic> json) =>
      Treasure(
        sn: int.parse(json["sn"]),
        no: int.parse(json["no"]),
        ccmaName: json["ccmaName"],
        crltsnoNm: json["crltsnoNm"],
        ccbaMnm1: json["ccbaMnm1"],
        ccbaMnm2: json["ccbaMnm2"],
        ccbaCtcdNm: json["ccbaCtcdNm"],
        ccsiName: json["ccsiName"],
        ccbaAdmin: json["ccbaAdmin"],
        ccbaKdcd: json["ccbaKdcd"],
        ccbaCtcd: json["ccbaCtcd"],
        ccbaAsno: json["ccbaAsno"],
        ccbaCncl: json["ccbaCncl"]!,
        ccbaCpno: json["ccbaCpno"],
        longitude: double.parse(json["longitude"]),
        latitude: double.parse(json["latitude"]),
      );

}