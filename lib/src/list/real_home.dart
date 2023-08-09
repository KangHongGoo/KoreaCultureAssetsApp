import 'package:flutter/material.dart';
import 'package:mapmapmap/src/mainImage/main_img.dart';
import 'package:url_launcher/url_launcher.dart';



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
        ],
      ),
    );

  }



}

