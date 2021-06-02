import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/locate_and_weather.dart';
import 'package:weather_app/views/creditsScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final LocationController c = Get.put(LocationController());
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue[100],
          floatingActionButton: floatingButtons(width, c),
          body: Obx(
            () => c.isLoading.value
                ? Center(
                    child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/rain_drop.gif"),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fetching your Location..",
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              " Make Sure to turn on your GPS and Internet",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            LinearProgressIndicator(),
                          ],
                        )))
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getImage(
                            c.info.value.weather[0].icon ?? 'default')),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 250,
                                width: 250,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(
                                            c.info.value.name ??
                                                "Your Location",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ))
                                      ],
                                    ),
                                    Text(
                                        c.info.value.main.temp.toString() +
                                                " °C" ??
                                            "Temperature",
                                        style: TextStyle(
                                            fontSize: 0.15 * width,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      c.info.value.weather[0].description,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ), //Description
                                  ],
                                )),
                              ),
                              SizedBox(height: 25),
                              Text(
                                  "Feels Like : " +
                                      c.info.value.main.feelsLike.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 25),
                              Text(
                                  "Max temp : " +
                                      c.info.value.main.tempMax.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 25),
                              Text(
                                  " Min temp : " +
                                      c.info.value.main.tempMin.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 25),
                              Text(
                                  "Pressure : " +
                                      c.info.value.main.pressure.toString() +
                                      " hPa",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 25),
                              Text(
                                  "Humidity: " +
                                      c.info.value.main.humidity.toString() +
                                      "%",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 25),
                              Text(
                                  " Wind Speed : " +
                                      c.info.value.wind.speed.toString() +
                                      "m/s",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Text(
                                    " AQI: " +
                                        c.airInfo.value.list[0].main.aqi
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info_outline),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog(context),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                            ],
                          )
                        ]),
                  ),
          )),
    );
  }

  Widget floatingButtons(double width, LocationController c) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //will break to another line on overflow
      children: <Widget>[
        SizedBox(width: width * 0.1),
        FloatingActionButton(
          heroTag: "credits",
          onPressed: () {
            Get.to(CreditPage());
          },
          child: Icon(
            Icons.copyright,
            color: Colors.black45,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        SizedBox(width: width * 0.6),
        FloatingActionButton(
          heroTag: "refresh",
          onPressed: () {
            c.getCurrentLocation();
          },
          child: Icon(
            Icons.flash_on,
            size: 44.0,
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),

        // Add more buttons here
      ],
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    final LocationController c = Get.put(LocationController());
    var list = [];
    c.airInfo.value.list[0].components.forEach((key, value) {
      list.add(value);
    });

    var height = MediaQuery.of(context).size.height;

    double fontsize = 15.0;
    return AlertDialog(
      titlePadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Concentration level(μg/m\u00B3)",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
          ),
          Spacer(),
          TextButton(
              onPressed: () => Get.back(),
              child: Icon(
                Icons.cancel,
              ))
        ],
      ),
      content: Container(
        height: height * 0.4,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CO (Carbon monoxide)",
                  style: TextStyle(
                      fontSize: fontsize, fontWeight: FontWeight.bold),
                ),
                Text(
                  list[0].toStringAsFixed(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("NO (Nitrogen monoxide)",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold)),
                Text(
                  list[1].toStringAsFixed(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "NO\u2082 (Nitrogen dioxide)",
                  style: TextStyle(
                      fontSize: fontsize, fontWeight: FontWeight.bold),
                ),
                Text(
                  list[2].toStringAsFixed(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("O\u2083 (Ozone)",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold)),
                Text(
                  list[3].toStringAsFixed(2),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "SO\u2082 (Sulphur dioxide)",
                style:
                    TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
              ),
              Text(
                list[4].toStringAsFixed(2),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PM2.5 (Fine Particulate Matter):",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold)),
                Text(
                  list[5].toStringAsFixed(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PM10 (Coarse Particulate):",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold)),
                Text(
                  list[6].toStringAsFixed(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("NH\u2083 (Ammonia)",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold)),
                Text(
                  list[7].toStringAsFixed(2),
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
            Text(
              "Air Quality Index. \nPossible values: 1, 2, 3, 4, 5. \nWhere 1 = Good, 2 = Fair, \n3 = Moderate, 4 = Poor,\n5 = Very Poor.",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getImage(String icon) {
  if (icon == "default") {
    return "assets/images/weather.jpg";
  }

  switch (icon) {
    case "01d":
      return "assets/images/sunny.png";
      break;
    case "01n":
      return "assets/images/clear_night.jpg";
      break;
    case "02d":
      return "assets/images/clouds.jpg";
      break;
    case "02n":
      return "assets/images/cloudy_night.jpg";
      break;
    case "03d":
      return "assets/images/clouds.jpg";
      break;
    case "03n":
      return "assets/images/cloudy_night.jpg";
      break;
    case "04d":
      return "assets/images/clouds.jpg";
      break;
    case "04n":
      return "assets/images/cloudy_night.jpg";
      break;
    case "09d":
      return "assets/images/rain_day.jpg";
      break;
    case "09n":
      return "assets/images/rain_night.jpg";
      break;
    case "10d":
      return "assets/images/rain_day.jpg";
      break;
    case "10n":
      return "assets/images/rain_night.jpg";
      break;
    case "11d":
      return "assets/images/thunder.jpg";
      break;
    case "11n":
      return "assets/images/thunder.jpg";
      break;
    case "13d":
      return "assets/images/snow_day.jpg";
      break;
    case "13n":
      return "assets/images/snow_night.jpg";
      break;
    case "50d":
      return "assets/images/mist.jpg";
      break;
    case "50n":
      return "assets/images/mist.jpg";
      break;
    default:
      return "assets/images/weather.jpg";
  }
}
