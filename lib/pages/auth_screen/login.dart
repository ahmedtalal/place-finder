import 'package:flutter/material.dart';
import 'package:online_booking_places/components/text_input_widget.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/auth_screen/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        backgroundImage,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20.0,
                        child: Image(
                          image: AssetImage(
                            lignt1Image,
                          ),
                        ),
                        height: height * 0.3,
                        width: width * 0.2,
                      ),
                      Positioned(
                        left: width * 0.3,
                        child: Image(
                          image: AssetImage(
                            light2Image,
                          ),
                          height: height * 0.2,
                          width: width * 0.2,
                        ),
                      ),
                      Positioned(
                        right: width * 0.07,
                        top: height * 0.1,
                        child: Image(
                          image: AssetImage(
                            clockImage,
                          ),
                        ),
                        height: height * 0.08,
                      ),
                      Positioned(
                          top: height * 0.25,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: width * 0.057,
                                fontFamily: appFont,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.5,
                  child: Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.8,
                              height: height * 0.08,
                              child: TextInputWidget(
                                message: "email",
                                icon: Icons.email,
                                onClick: (newValue) {
                                  email = newValue;
                                },
                                onValidate: (value) {
                                  if (value.isEmpty) {
                                    return "this field is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Container(
                              width: width * 0.8,
                              height: height * 0.08,
                              child: TextInputWidget(
                                message: "Password",
                                icon: Icons.lock,
                                onClick: (newValue) {
                                  password = newValue;
                                },
                                onValidate: (value) {
                                  if (value.isEmpty) {
                                    return "this field is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: width * 0.8,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: appFont,
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.033,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: width * 0.7,
                            height: height * 0.076,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: appFont,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Do not have an account?",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: appFont,
                                ),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (c) => Register(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: appFont,
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
