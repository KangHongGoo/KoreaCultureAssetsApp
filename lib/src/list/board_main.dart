import 'package:flutter/material.dart';
import '../../model/board.dart';
import '../detail/board_detail.dart';

class BoardWidget extends StatelessWidget {
  final dataSource = DataSourceBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Board>>(
        future: dataSource.findAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Board> dataList = snapshot.data!;
            return ListView.builder(
              itemExtent: 50, // 각 ListTile의 높이
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                Board board = dataList[index];
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(30, 5, 20, 24), // 내용 주위 여백 조정, B:title-subtitle간격!
                  title: Text(board.title),
                  subtitle: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(board.createAt.toString()),
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