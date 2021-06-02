import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/reUsable/hyperLink.dart';

class CreditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(
            Icons.home,
            size: 50.0,
          ),
          onPressed: () => Get.back(),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterTop,
        body: body(),
      ),
    );
  }

  Container body() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Framework and Packages used: ",
                  style: TextStyle(fontSize: 24.0),
                ),
                Hyperlink("https://flutter.dev/", "Flutter"),
                Hyperlink("https://pub.dev/packages/get", "GetX"),
                Hyperlink("https://pub.dev/packages/http", "http"),
                Hyperlink("https://pub.dev/packages/geolocator", "geolocator"),
                Hyperlink(
                    "https://pub.dev/packages/url_launcher", "url_launcher"),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      "Maintained by: ",
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Hyperlink(
                        "https://twitter.com/tweetSUM4N", "Twitter account"),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      "Source Code: ",
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Hyperlink("https://github.com/Suman2023/Flutter_projects",
                        "Github"),
                  ],
                ),
              ]),
        ],
      ),
    );
  }
}
