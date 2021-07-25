import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_events.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_states.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';
import 'package:online_booking_places/components/setting_components_view.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/auth_screen/register.dart';
import 'package:online_booking_places/pages/cart.dart';
import 'package:online_booking_places/pages/setting_page_components/edit_profile.dart';
import 'package:online_booking_places/pages/setting_page_components/offers.dart';
import 'package:online_booking_places/pages/setting_page_components/old_orders.dart';
import 'package:online_booking_places/pages/setting_page_components/update_password.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name, email, phone, image;
  @override
  Widget build(BuildContext context) {
    var authProvider = BlocProvider.of<AuthBloc>(context);
    var userProvider = BlocProvider.of<UserBloc>(context);
    var height = MediaQuery.of(context).size.height;
    userProvider.model = FirebaseAuth.instance.currentUser.uid;
    print(userProvider.model);
    userProvider.add(GetUserEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.06,
              ),
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: appFont,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              BlocBuilder<UserBloc, UserStates>(
                builder: (context, state) {
                  var response;
                  var result;
                  if (state is UserLoadedState) {
                    response = state.response;
                  } else if (state is UserErrorState) {
                    result = false;
                  }
                  return StreamBuilder<DocumentSnapshot>(
                    stream: response,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        result = false;
                        name = "null";
                        email = "null";
                        phone = "null";
                        image = "null";
                      } else if (snapshot.hasData) {
                        print("object");
                        name = snapshot.data["name"];
                        phone = snapshot.data["phoneNumber"];
                        email = snapshot.data["email"];
                        image = snapshot.data["image"];
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 25.0,
                                child: result == false && image == "null"
                                    ? Image(
                                        image: AssetImage(userImage),
                                      )
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: image,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image(
                                            image: AssetImage(userImage),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            name == "null" && result == false
                                ? "UnKnown"
                                : name,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: appFont,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            "User",
                            style: TextStyle(
                              fontSize: 8.0,
                              fontFamily: appFont,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: appFont,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => EditProfile(
                        name: name,
                        email: email,
                        phone: phone,
                        image: image,
                      ),
                    ),
                  );
                },
                hint: "Edit profile",
                icon: editImage,
                color: Colors.red[500],
              ),
              SizedBox(
                height: 6.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => UpdatePassword(),
                    ),
                  );
                },
                hint: "Change Password",
                icon: changePassword,
                color: Colors.blue[500],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "App",
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: appFont,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  shared("welcome to find your place app", context);
                },
                hint: "Share App",
                icon: shareAppImage,
                color: Colors.orange[500],
              ),
              SizedBox(
                height: 6.0,
              ),
              SettingComponentsView(
                onClick: () {
                  launchUrl();
                },
                hint: "Rate App",
                icon: rateAppImage,
                color: Colors.purple[500],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Others",
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: appFont,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ),
                  );
                },
                hint: "My Cart",
                icon: myCartImage,
                color: Colors.red[500],
              ),
              SizedBox(
                height: 6.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => Offers(),
                    ),
                  );
                },
                hint: "Offers",
                icon: offersImage,
                color: Colors.orange[500],
              ),
              SizedBox(
                height: 6.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OldOrders(),
                    ),
                  );
                },
                hint: "My Orders",
                icon: checkOrder,
                color: Colors.cyan[500],
              ),
              SizedBox(
                height: 6.0,
              ),
              BlocListener<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is LogOutSucessed) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) => Register(),
                      ),
                    );
                  } else if (state is LogOutFailed) {
                    print("failed");
                  }
                },
                child: BlocBuilder<AuthBloc, AuthStates>(
                  builder: (context, state) {
                    return SettingComponentsView(
                      onClick: () {
                        authProvider.add(LogOutEvent());
                      },
                      hint: "LogOut",
                      icon: logoutImage,
                      color: Colors.purple[500],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
