
import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mapmapmap/src/controller/main_image_controller.dart';
import 'package:mapmapmap/src/detail/national_treasure_detail.dart';
import 'package:mapmapmap/src/detail/treasure_detail.dart';
import 'package:xml2json/xml2json.dart';



class MainImage extends StatefulWidget {
  const MainImage({Key? key});

  @override
  State<MainImage> createState() => _MainImageState();
}
MainImageController mainImageController = Get.put(MainImageController());

class _MainImageState extends State<MainImage> {
  int current = 0;
  final CarouselController controller = CarouselController();

  List imageList = [
    "assets/img11.jpg",
    "assets/img14.jpg",
    "assets/img13.jpg",
    "assets/img12.jpg",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainImageController.loadImgUrls();
  }

  @override
  Widget build(BuildContext context) {


    return  Obx(() =>
        Scaffold(
        body: Column(
          children: [
           SizedBox(
              height: 360,
              child: mainImageController.isLoading.value ?
              Image.asset("assets/gbg.jpg")
                  :
              Stack(

                children: [
                  sliderWidget(mainImageController),
                sliderIndicator(),
              ],
            ),
             
          ),
        ],
      ),
    )
    );
  }


  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList
            .asMap()
            .entries
            .map((e) => GestureDetector(
          onTap: () => controller.animateToPage(e.key),
          child: Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
                  .withOpacity(current == e.key ? 1.0 : 0.4),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  Widget sliderWidget(MainImageController mainImageController) {
    final objectList = [
      {"imgUrl": mainImageController.imgUrl1,
        "ccbaCtcd": mainImageController.ccbaCtcd1,
        "ccbaAsno": mainImageController.ccbaAsno1,
      },
      {"imgUrl": mainImageController.imgUrl2,
        "ccbaCtcd": mainImageController.ccbaCtcd2,
        "ccbaAsno": mainImageController.ccbaAsno2,
      },
      {"imgUrl": mainImageController.imgUrl3,
        "ccbaCtcd": mainImageController.ccbaCtcd3,
        "ccbaAsno": mainImageController.ccbaAsno3,
      },
      {"imgUrl": mainImageController.imgUrl4,
        "ccbaCtcd": mainImageController.ccbaCtcd4,
        "ccbaAsno": mainImageController.ccbaAsno4,
      },

    ];

    return CarouselSlider(
      carouselController: controller,
      items: objectList.asMap().entries
          .map((entry)  {
            int index = entry.key;
            final url = entry.value["imgUrl"];
        return GestureDetector(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(url.toString()),

              ),
          ),
          onTap: () {
            if(index == 0 ) {
              Get.to(NationalTreasureDetail(
                  ccbaAsno: entry.value["ccbaAsno"].toString(), ccbaCtcd: entry.value["ccbaCtcd"].toString()));
            }else {
              Get.to(TreasureDetail(ccbaAsno: entry.value["ccbaAsno"].toString(), ccbaCtcd: entry.value["ccbaCtcd"].toString()));
            }
          },
        );
      }).toList(),
      options: CarouselOptions(
          height: 400,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10),
          onPageChanged: (index, reason) {
            setState(() {
              current = index;
            });
          }),

    );
  }
}



