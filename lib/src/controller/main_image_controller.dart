import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:mapmapmap/src/datatypes/national_treasure_list.dart';
import 'package:mapmapmap/src/datatypes/treasure_list.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class MainImageController extends GetxController {
  List<NationalTreasure> nationalTreasureList = [];
  List<Treasure> treasureList = [];
  RxBool isLoading = false.obs;

  RxString imgUrl1 = "".obs;
  RxString imgUrl2 = "".obs;
  RxString imgUrl3 = "".obs;
  RxString imgUrl4 = "".obs;

  RxString nameUrl1 = "".obs;
  RxString nameUrl2 = "".obs;
  RxString nameUrl3 = "".obs;
  RxString nameUrl4 = "".obs;

  RxString ccbaCtcd1 = "".obs;
  RxString ccbaAsno1 = "".obs;

  RxString ccbaCtcd2 = "".obs;
  RxString ccbaAsno2 = "".obs;

  RxString ccbaCtcd3 = "".obs;
  RxString ccbaAsno3 = "".obs;

  RxString ccbaCtcd4 = "".obs;
  RxString ccbaAsno4 = "".obs;

  Future<void> loadImgUrls() async {
    isLoading.value = true;

    // 국보 리스트
    final nationalResponse = await http.get(
      Uri.parse(
          "http://www.cha.go.kr/cha/SearchKindOpenapiList.do?ccbaKdcd=11&pageUnit=357"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final getXmlData = nationalResponse.body;
    final Xml2JsonData = Xml2Json()..parse(getXmlData);
    final jsonData = Xml2JsonData.toParker();

    Map<String, dynamic> data = jsonDecode(jsonData);
    List<dynamic> listJson = data['result']['item'];
    List<NationalTreasure> nationalTreasureList = List<NationalTreasure>.from(
        listJson.map((x) => NationalTreasure.fromJson(x)));

    //보물 리스트
    final treasureResponse = await http.get(
      Uri.parse(
          "http://www.cha.go.kr/cha/SearchKindOpenapiList.do?ccbaKdcd=12&pageUnit=2439"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final getXmlDataT = treasureResponse.body;
    final Xml2JsonDataT = Xml2Json()..parse(getXmlDataT);
    final jsonDataT = Xml2JsonDataT.toParker();

    Map<String, dynamic> dataT = jsonDecode(jsonDataT);
    List<dynamic> tListJson = dataT['result']['item'];
    List<Treasure> treasureList =
        List<Treasure>.from(tListJson.map((x) => Treasure.fromJson(x)));

    // 사진 랜덤으로 가져올것
    var random = Random();
    int randomNumber1 = random.nextInt(357) + 1;
    int randomNumber2 = random.nextInt(813) + 1;
    int randomNumber3 = random.nextInt(813) + 813;
    int randomNumber4 = random.nextInt(813) + 1626;

    ccbaAsno1.value = nationalTreasureList[randomNumber1].ccbaAsno;
    ccbaCtcd1.value = nationalTreasureList[randomNumber1].ccbaCtcd;
    ccbaAsno2.value = treasureList[randomNumber2].ccbaAsno;
    ccbaCtcd2.value = treasureList[randomNumber2].ccbaCtcd;
    ccbaAsno3.value = treasureList[randomNumber3].ccbaAsno;
    ccbaCtcd3.value = treasureList[randomNumber3].ccbaCtcd;
    ccbaAsno4.value = treasureList[randomNumber4].ccbaAsno;
    ccbaCtcd4.value = treasureList[randomNumber4].ccbaCtcd;

    String url1 =
        "https://www.cha.go.kr/cha/SearchKindOpenapiDt.do?ccbaKdcd=11&ccbaAsno=${nationalTreasureList[randomNumber1].ccbaAsno}&ccbaCtcd=${nationalTreasureList[randomNumber1].ccbaCtcd}";
    String url2 =
        "https://www.cha.go.kr/cha/SearchKindOpenapiDt.do?ccbaKdcd=12&ccbaAsno=${treasureList[randomNumber2].ccbaAsno}&ccbaCtcd=${treasureList[randomNumber2].ccbaCtcd}";
    String url3 =
        "https://www.cha.go.kr/cha/SearchKindOpenapiDt.do?ccbaKdcd=12&ccbaAsno=${treasureList[randomNumber3].ccbaAsno}&ccbaCtcd=${treasureList[randomNumber3].ccbaCtcd}";
    String url4 =
        "https://www.cha.go.kr/cha/SearchKindOpenapiDt.do?ccbaKdcd=12&ccbaAsno=${treasureList[randomNumber4].ccbaAsno}&ccbaCtcd=${treasureList[randomNumber4].ccbaCtcd}";

    final response1 = await http
        .get(Uri.parse(url1), headers: {"Content-Type": "application/json"});
    final getXmlDataUrl1 = response1.body;
    final Xml2JsonDataUrl1 = Xml2Json()..parse(getXmlDataUrl1);
    final jsonDataUrl1 = Xml2JsonDataUrl1.toParker();

    Map<String, dynamic> dataUrl1 = jsonDecode(jsonDataUrl1);

    imgUrl1.value = dataUrl1['result']['item']['imageUrl'];

    //////////////////////////////////////

    final response2 = await http
        .get(Uri.parse(url2), headers: {"Content-Type": "application/json"});
    final getXmlDataUrl2 = response2.body;
    final Xml2JsonDataUrl2 = Xml2Json()..parse(getXmlDataUrl2);
    final jsonDataUrl2 = Xml2JsonDataUrl2.toParker();

    Map<String, dynamic> dataUrl2 = jsonDecode(jsonDataUrl2);

    imgUrl2.value = dataUrl2['result']['item']['imageUrl'];

    /////////////////////////////////////

    final response3 = await http
        .get(Uri.parse(url3), headers: {"Content-Type": "application/json"});
    final getXmlDataUrl3 = response3.body;
    final Xml2JsonDataUrl3 = Xml2Json()..parse(getXmlDataUrl3);
    final jsonDataUrl3 = Xml2JsonDataUrl3.toParker();

    Map<String, dynamic> dataUrl3 = jsonDecode(jsonDataUrl3);

    imgUrl3.value = dataUrl3['result']['item']['imageUrl'];

    //////////////////////////////////

    final response4 = await http
        .get(Uri.parse(url4), headers: {"Content-Type": "application/json"});
    final getXmlDataUrl4 = response4.body;
    final Xml2JsonDataUrl4 = Xml2Json()..parse(getXmlDataUrl4);
    final jsonDataUrl4 = Xml2JsonDataUrl4.toParker();

    Map<String, dynamic> dataUrl4 = jsonDecode(jsonDataUrl4);

    imgUrl4.value = dataUrl4['result']['item']['imageUrl'];


    /////////////////////////////

    final response5 = await http.get(Uri.parse(url1), headers: {"Content-Type" : "application/json"} );
    final getXmlDataUrl5 = response5.body;
    final Xml2JsonDataUrl5 = Xml2Json()..parse(getXmlDataUrl5);
    final jsonDataUrl5 = Xml2JsonDataUrl5.toParker();

    Map<String, dynamic> dataUrl5 = jsonDecode(jsonDataUrl5);

    nameUrl1.value = dataUrl5['result']['item']['ccbaMnm1'];

    /////////////////////////////

    final response6 = await http.get(Uri.parse(url2), headers: {"Content-Type" : "application/json"} );
    final getXmlDataUrl6 = response6.body;
    final Xml2JsonDataUrl6 = Xml2Json()..parse(getXmlDataUrl6);
    final jsonDataUrl6 = Xml2JsonDataUrl6.toParker();

    Map<String, dynamic> dataUrl6 = jsonDecode(jsonDataUrl6);

    nameUrl2.value = dataUrl6['result']['item']['ccbaMnm1'];

    //////////////////////////////

    final response7 = await http.get(Uri.parse(url3), headers: {"Content-Type" : "application/json"} );
    final getXmlDataUrl7 = response7.body;
    final Xml2JsonDataUrl7 = Xml2Json()..parse(getXmlDataUrl7);
    final jsonDataUrl7 = Xml2JsonDataUrl7.toParker();

    Map<String, dynamic> dataUrl7 = jsonDecode(jsonDataUrl7);

    nameUrl3.value = dataUrl7['result']['item']['ccbaMnm1'];

    ////////////////////////////

    final response8 = await http.get(Uri.parse(url4), headers: {"Content-Type" : "application/json"} );
    final getXmlDataUrl8 = response8.body;
    final Xml2JsonDataUrl8 = Xml2Json()..parse(getXmlDataUrl8);
    final jsonDataUrl8 = Xml2JsonDataUrl8.toParker();

    Map<String, dynamic> dataUrl8 = jsonDecode(jsonDataUrl8);

    nameUrl4.value = dataUrl8['result']['item']['ccbaMnm1'];

    isLoading.value = false;
  }
}
