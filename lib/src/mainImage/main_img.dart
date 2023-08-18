
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmapmap/src/controller/main_image_controller.dart';
import 'package:mapmapmap/src/detail/national_treasure_detail.dart';
import 'package:mapmapmap/src/detail/treasure_detail.dart';



class MainImage extends StatefulWidget {
  const MainImage({Key? key});

  @override
  State<MainImage> createState() => _MainImageState();
}
MainImageController mainImageController = Get.put(MainImageController());

class _MainImageState extends State<MainImage> {
  int current = 0;
  final CarouselController controller = CarouselController();

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
              ],
            ),

          ),
        ],
      ),
    )
    );
  }

  Widget sliderWidget(MainImageController mainImageController) {
    final objectList = [
      {"imgUrl": mainImageController.imgUrl1,
        "ccbaCtcd": mainImageController.ccbaCtcd1,
        "ccbaAsno": mainImageController.ccbaAsno1,
        "name" : mainImageController.nameUrl1
      },
      {"imgUrl": mainImageController.imgUrl2,
        "ccbaCtcd": mainImageController.ccbaCtcd2,
        "ccbaAsno": mainImageController.ccbaAsno2,
        "name" : mainImageController.nameUrl2
      },
      {"imgUrl": mainImageController.imgUrl3,
        "ccbaCtcd": mainImageController.ccbaCtcd3,
        "ccbaAsno": mainImageController.ccbaAsno3,
        "name" : mainImageController.nameUrl3
      },
      {"imgUrl": mainImageController.imgUrl4,
        "ccbaCtcd": mainImageController.ccbaCtcd4,
        "ccbaAsno": mainImageController.ccbaAsno4,
        "name" : mainImageController.nameUrl4
      },

    ];

    return CarouselSlider(
      carouselController: controller,
      items: objectList.asMap().entries
          .map((entry)  {
            int index = entry.key;
            final url = entry.value["imgUrl"];
            final name = entry.value["name"];
        return Padding(
          padding: EdgeInsets.fromLTRB(13, 13, 13, 8),
          child: GestureDetector(
            child: SafeArea(
              child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(url.toString()
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: Offset(1.1, 1.1),
                          )
                        ]
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(195, 189, 0, 0),
                        child: Stack(
                          children: [
                            Image(
                                image: AssetImage("assets/black.png"),
                                width: 210,
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 48, 0, 0),
                                  child: StrokeText(
                                       text: name.toString(),
                                       textStyle: TextStyle(
                                       fontSize:name.toString().length.toDouble() > 16 ? 14 : 30 - name.toString().length.toDouble() ,
                                       color: Color.fromRGBO(255, 255, 255, 1)
                                    ),
                                       strokeColor: Color.fromRGBO(0, 0, 0, 1),
                                       strokeWidth: 5.5,
                                            ),
                                ),
                              ),
                                  ],
                        ),
                      ),
                    ),


                  ],
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
          ),
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


class StrokeText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color strokeColor;
  final double strokeWidth;

  StrokeText({
    required this.text,
    required this.textStyle,
    this.strokeColor = Colors.white,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text
        Text(
          text,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),

        // Solid text
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}

