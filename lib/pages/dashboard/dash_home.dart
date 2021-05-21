import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_booking_places/components/dahsboard_body.dart';
import 'package:online_booking_places/components/dashboard_header.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/dashboard/adding_target_info.dart';
import 'package:online_booking_places/pages/dashboard/show_targets.dart';
import 'package:online_booking_places/pages/dashboard/show_users.dart';

class DashHome extends StatefulWidget {
  @override
  _DashHomeState createState() => _DashHomeState();
}

class _DashHomeState extends State<DashHome> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.06,
              ),
              DashBoardHeader(),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                  child: GridView.count(
                childAspectRatio: 1.0,
                crossAxisCount: 2,
                padding: EdgeInsets.only(left: 16, right: 16),
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                children: [
                  DashBoardBody(
                    title: "Adding",
                    icon: adding,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => AddingTargetInfo(),
                        ),
                      );
                    },
                  ),
                  DashBoardBody(
                    title: "Users",
                    icon: group,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => ShowUsers(),
                        ),
                      );
                    },
                  ),
                  DashBoardBody(
                    title: "cinemas",
                    icon: cinema,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => ShowTargets(target: "Cinema"),
                        ),
                      );
                    },
                  ),
                  DashBoardBody(
                    title: "Hotels",
                    icon: hotel,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => ShowTargets(target: "Hotels"),
                        ),
                      );
                    },
                  ),
                  DashBoardBody(
                    title: "restaurants",
                    icon: restaurant,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => ShowTargets(target: "Rastaurants"),
                        ),
                      );
                    },
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
