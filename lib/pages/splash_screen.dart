import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_booking_places/components/slider_widget.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/auth_screen/register.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            12.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: height * 0.6,
                  child: Carousel(
                    dotSize: 5.0,
                    dotSpacing: 20.0,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    dotVerticalPadding: 5.0,
                    dotIncreasedColor: Colors.blue,
                    dotColor: Colors.grey,
                    animationDuration: Duration(milliseconds: 1000),
                    images: [
                      SliderWidget(
                        image: sliderImage3,
                        title: sliderTitle1,
                        description: description1,
                      ),
                      SliderWidget(
                        image: sliderImage2,
                        title: sliderTitle2,
                        description: description2,
                      ),
                      SliderWidget(
                        image: sliderImage1,
                        title: sliderTitle3,
                        description: description3,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) => Register(),
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      height: height * 0.067,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: appFont,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
