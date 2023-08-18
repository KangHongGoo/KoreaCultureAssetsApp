import 'package:flutter/material.dart';
import 'package:mapmapmap/src/list/culture_assets_list.dart';
import 'package:mapmapmap/src/mainImage/main_img.dart';
import 'package:get/get.dart';


class RealHome extends StatelessWidget {
  const RealHome({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MainImage(),
          ),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(onTap: (){
                    Get.to(NationalTreasureList());
                  }, child: Image.asset(
                    'assets/map.jpg',
                    height: 395,
                    width: 395,
                  ),

                  ),
                ],
              )
          )
        ],
      ),
    );

  }



}

