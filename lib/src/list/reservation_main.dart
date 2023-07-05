import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmapmap/model/reservation.dart';
import 'package:mapmapmap/src/detail/performance_date_detail.dart';
import 'package:mapmapmap/src/detail/reservation_detail.dart';

import 'package:intl/intl.dart';

class ReservationMain extends StatefulWidget {
  @override
  _ReservationMainState createState() => _ReservationMainState();
}

class _ReservationMainState extends State<ReservationMain> {
  DateTime selectedDate = DateTime.now();
  DataSource dataSource=DataSource();

  String? boardId = "";
  String name = "";
  int count = 0;
  String phoneNum= "";
  String? selectedLocation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: buildReservationContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReservationContainer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: buildContainerDecoration(),
          child: Align(
            alignment: Alignment.center,
            child: buildReservationContent(),
          ),
        ),
      ],
    );
  }

  BoxDecoration buildContainerDecoration() {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      // 키보드가 나타날 때는 bottom의 테두리를 삭제
      return BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 90, // 가로 테두리 두께
          ),
          bottom: BorderSide.none,
          left: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 30, // 가로 테두리 두께
          ),
          right: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 30, // 세로 테두리 두께
          ),
        ),
        color: Colors.transparent,
      );
    } else {

      return BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 90, // 가로 테두리 두께
          ),
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 70, // 세로 테두리 두께
          ),
          left: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 30, // 가로 테두리 두께
          ),
          right: BorderSide(
            color: Colors.black.withOpacity(0.4),
            width: 30, // 세로 테두리 두께
          ),
        ),
        color: Colors.transparent,
      );
    }
  }


  Widget buildReservationContent() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white.withOpacity(0.7),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            "문화 체험 예약 안내",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "문화 체험 예약을 원하시는 분들께서는 "
                        "하단의 예약하기 버튼을 클릭해주십시오.\n\n"
                        "결제가 필요한 프로그램은 당일 현장에서 "
                        "예약 내역 확인 후 이루어집니다.\n\n"
                        "상세 가격은 각 프로그램 관련 홈페이지를 참고하세요.\n\n"
                        "취소는 체험 전날까지 가능합니다.\n\n많은 관심 바랍니다.\n\n",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildReservationButton(),
              buildReservationCancelButton(),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildReservationButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          DateTime? dateTime = await showDatePicker(
            context: context,
            initialDate: DateTime.now().add(Duration(days: 1)),
            firstDate: DateTime.now().add(Duration(days: 1)), // 현재 날짜부터 선택할 수 있게
            lastDate: DateTime.now().add(Duration(days: 100)), // 현재 날짜로부터 100일 후까지 선택 가능
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.blueGrey,
                  colorScheme: ColorScheme.light(primary: Colors.blueGrey),
                ),
                child: child!,
              );
            },
          );
          if (dateTime != null) {
            setState(() {
              selectedDate = dateTime;
            });
            showReservationInfoDialog();
          }
        },
        child: Text("예약하기"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[700],
        ),
      ),
    );
  }

  Future<void> showReservationInfoDialog() async {

    boardId=null;
    count=0;
    phoneNum="";
    name="";
    selectedLocation = null;


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("예약 정보 입력"),
          content: buildDialogContent(),
          actions: buildDialogActions(),
        );
      },
    );
  }

  Widget buildDialogContent() {
    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSidoDropdownButton(setState),
              SizedBox(height: 10),
              buildProgramDropdownButton(setState),
              buildNameTextField(),
              SizedBox(height: 10),
              buildCountTextField(),
              SizedBox(height: 10),
              buildPhonenumTextField(),
            ],
          ),
        );
      },
    );
  }

  Widget buildSidoDropdownButton(Function setState) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FutureBuilder<List<DropdownMenuItem<String>>>(
        future: buildDropdownSidos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              child: Container(
                child: DropdownButton<String>(
                  items: snapshot.data,
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                      print(selectedLocation);
                    });
                  },
                  value: selectedLocation,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0, // 텍스트의 크기
                  ), // DropdownButton의 텍스트 스타일
                  underline: Container(
                    height: 1.0,
                    color: Colors.grey, // 기본 언더라인 색상
                  ),
                  dropdownColor: Colors.white, // 드롭다운 메뉴의 배경색
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down), // 드롭다운 아이콘
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator(); // 로딩 중인 표시
          }
        },
      ),
    );
  }


  Future<List<DropdownMenuItem<String>>> buildDropdownSidos() async {
    PerformanceDateDetail performanceDateDetail = PerformanceDateDetail();
    List<DropdownMenuItem<String>> dropdownItems = [];

    try {
      List<dynamic> uniqueSidoList =
      await performanceDateDetail.UniqueSidoList(selectedDate.year.toString(), selectedDate.month.toString());

      dropdownItems.add(
        DropdownMenuItem(
          value: null,
          child: Text(
            "위치",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );

      for (dynamic item in uniqueSidoList) {
        String sido = item.toString(); // sido 값 가져오기

        dropdownItems.add(
          DropdownMenuItem(
            value: sido,
            child: Text(sido),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      // 에러 처리
    }

    return dropdownItems;
  }

  Widget buildProgramDropdownButton(Function setState) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FutureBuilder<List<DropdownMenuItem<String>>>(
        future: buildDropdownPrograms(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              child: Container(
                child: DropdownButton<String>(
                  items: snapshot.data,
                  onChanged: (value) {
                    setState(() {
                      boardId = value;
                      print(boardId);
                    });
                  },
                  value: boardId,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0, // 텍스트의 크기
                  ), // DropdownButton의 텍스트 스타일
                  underline: Container(
                    height: 1.0,
                    color: Colors.grey, // 기본 언더라인 색상
                  ),
                  dropdownColor: Colors.white, // 드롭다운 메뉴의 배경색
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down), // 드롭다운 아이콘
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator(); // 로딩 중인 표시
          }
        },
      ),
    );
  }

  Future<List<DropdownMenuItem<String>>> buildDropdownPrograms() async {
    PerformanceDateDetail performanceDateDetail = PerformanceDateDetail();
    List<DropdownMenuItem<String>> dropdownItems = [];

    try {
      List<dynamic> uniqueSubtitleList =
      await performanceDateDetail.UniqueSubtitleList(selectedDate.year.toString(), selectedDate.month.toString(), selectedDate.day, selectedLocation.toString(),);

      dropdownItems.add(
        DropdownMenuItem(
          value: null,
          child: Text(
            "프로그램명",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );

      for (dynamic item in uniqueSubtitleList) {
        String subtitle = item.toString(); // sido 값 가져오기

        dropdownItems.add(
          DropdownMenuItem(
            value: subtitle,
            child: Text(subtitle),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      // 에러 처리
    }

    return dropdownItems;
  }

  Widget buildNameTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp("[0-9]")), // 숫자 입력 방지
        LengthLimitingTextInputFormatter(10), // 최대 글자 수 제한
      ],
      decoration: InputDecoration(
        hintText: "이름",
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        contentPadding: EdgeInsets.only(bottom: -15.0),
      ),
    );
  }

  Widget buildCountTextField(){
    return TextField(
      onChanged: (value) {
        final onlyNumbers = RegExp(r'^[1-9][0-9]*$');
        if (onlyNumbers.hasMatch(value)) {
          setState(() {
            count = int.parse(value);
          });
        }
      },
      decoration: InputDecoration(
        hintText: "예약 인원",
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        contentPadding: EdgeInsets.only(bottom: -15.0),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter(
          RegExp(r'^[1-9]\d{0,1}$'),
          allow: true,
          replacementString: '',
        ),
      ],
    );
  }



  Widget buildPhonenumTextField() {
    var phoneNumberFormatter = PhoneNumberFormatter();

    return TextField(
      onChanged: (value) {
        setState(() {
          phoneNum = value;
        });
      },
      decoration: InputDecoration(
        hintText: "휴대폰 번호",
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        contentPadding: EdgeInsets.only(bottom: -15.0),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(13), // 최대 길이 제한
        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능하도록 필터링
        phoneNumberFormatter, // 휴대폰 번호 형식 포맷터 추가
      ],
    );
  }

  List<Widget> buildDialogActions() {
    return [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: Text("취소"),
        ),
      ),
      TextButton(
        onPressed: () {
          if (name.isEmpty ||
              count <= 0 ||
              phoneNum.isEmpty ||
              selectedLocation==null||
              boardId == null ||
              name == null ||
              phoneNum == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("경고"),
                  content: Text("모든 정보를 입력해야 합니다."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("확인"),
                    ),
                  ],
                );
              },
            );
          } else {
            Navigator.of(context).pop();
            createReservation();
          }
        },
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: Text("완료"),
        ),
      ),
    ];
  }

  void createReservation() async {
    try {
      Reservation reservation = await dataSource.createReservation(
        boardId,
        name,
        selectedDate,
        count,
        phoneNum,
      );
      print('예약이 성공적으로 생성되었습니다.');
      print('예약 정보: '+reservation.info());
    } catch (error) {
      print('예약 생성 오류: $error');
      // 예약 생성 오류 처리 로직 추가
    }
  }

  Widget buildReservationCancelButton(){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (){
          showReservationCancelInfoDialog();
        },
        child: Text("예약정보확인"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[700],
        ),
      ),
    );
  }

  Future<void> showReservationCancelInfoDialog() async {

    phoneNum="";
    name="";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("예약자 정보 입력"),
          content: buildCancelContent(),
          actions: buildCancelActions(),
        );
      },
    );
  }

  Widget buildCancelContent() {
    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildNameTextField(),
              SizedBox(height: 10),
              buildPhonenumTextField(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> buildCancelActions() {
    return [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: Text("취소"),
        ),
      ),
      TextButton(
        onPressed: () {
          if (phoneNum.isEmpty ||
              name.isEmpty||
              name == null ||
              phoneNum == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("경고"),
                  content: Text("모든 정보를 입력해야 합니다."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("확인"),
                    ),
                  ],
                );
              },
            );
          } else {
            Navigator.of(context).pop();
            findAndDeleteReservation();
          }
        },
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: Text("완료"),
        ),
      ),
    ];
  }

  void findAndDeleteReservation() async {
    try {
      List reservations = await dataSource.findReservation(
        name,
        phoneNum,
      );
      List<bool> selectedItems = List.generate(reservations.length, (index) => false); // 초기 선택 상태 리스트

      // 예약 내역 리스트를 화면에 표시
      showDialog(
          context: context,
          builder: (BuildContext context) {
            if (reservations.isEmpty) {
              // 예약 내역이 없는 경우 메시지를 표시
              return AlertDialog(
                title: Text('예약 내역'),
                content: Text('예약 내역이 없습니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('닫기'),
                  ),
                ],
              );
            } else {
              // 예약 내역이 있는 경우 예약 내역을 표시하는 다이얼로그
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('예약 내역'),
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedItems[index] =
                              !selectedItems[index]; // 선택 상태 토글
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedItems[index] ? Colors.grey[300] : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(reservations[index].boardId),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      DateFormat('yyyy-MM-dd').format(reservations[index].reservationDate),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text('${reservations[index].count}명', style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        child: Text("닫기"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('알림'),
                              content: Text('예약을 취소하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // 알림 창 닫기
                                  },
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    child: Text("취소"),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // 선택된 아이템 처리 로직 추가
                                    List<int> selectedReservations = [];
                                    for (int i = 0; i < selectedItems.length; i++) {
                                      if (selectedItems[i]) {
                                        selectedReservations.add(i);
                                      }
                                    }
                                    deleteReservation(selectedReservations, name, phoneNum);
                                    Navigator.of(context).pop(); // 다이얼로그 닫기
                                    Navigator.of(context).pop();
                                  },
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    child: Text("확인"),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        child: Text('예약 취소'),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      );
    } catch (error) {
      print('예약 확인 오류: $error');
      // 예약 생성 오류 처리 로직 추가
    }
  }

  Future<void> deleteReservation(List<dynamic> selectedReservations, String name, String phoneNum) async {
    try {
      await dataSource.deleteReservation(
          selectedReservations, name, phoneNum
      );
      await Future.delayed(Duration(seconds: 1)); // 임의의 지연 시간을 설정하여 확인할 수 있도록 함

      // 삭제 완료 후 알림 창 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text('예약이 취소되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 알림 창 닫기
                },
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  child: Text("닫기"),
                ),
              ),
            ],
          );
        },
      );
      print('예약이 성공적으로 삭제되었습니다.');
    } catch (error) {
      print('예약 삭제 오류: $error');
      // 예약 생성 오류 처리 로직 추가
    }
  }
}



class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newText.length >= 4 && newText[3] != '-') {
      newText = newText.substring(0, 3) + '-' + newText.substring(3);
    }
    if (newText.length >= 9 && newText[8] != '-') {
      newText = newText.substring(0, 8) + '-' + newText.substring(8);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length), // 커서를 맨 뒤로 설정
    );
  }
}