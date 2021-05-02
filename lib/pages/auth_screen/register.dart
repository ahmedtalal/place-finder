import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_events.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_states.dart';
import 'package:online_booking_places/components/text_input_widget.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/user_model.dart';
import 'package:online_booking_places/pages/auth_screen/login.dart';
import 'package:online_booking_places/pages/home.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, password, phone;

  var formKey = GlobalKey<FormState>();

  bool isProgressed = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isProgressed,
        child: SafeArea(
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
                            height: height * 0.3,
                            width: width * 0.2,
                          ),
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
                            height: height * 0.08,
                          ),
                        ),
                        Positioned(
                            top: height * 0.25,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                "Register",
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
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: form(context, height, width, provider),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Center(
                          child: BlocListener<AuthBloc, AuthStates>(
                            listener: (context, state) {
                              if (state is AuthFailed) {
                                snackbarValidate(state.error, context);
                              } else if (state is AuthSucessed) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (c) => Home(),
                                  ),
                                );
                              }
                            },
                            child: BlocBuilder<AuthBloc, AuthStates>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      var uId = Uuid();
                                      if (formKey.currentState.validate()) {
                                        isProgressed = true;
                                        provider.model = UserModel(
                                          name: name,
                                          email: email,
                                          password: password,
                                          id: uId.v1(),
                                          image: null,
                                          phoneNumber: phone.toString(),
                                        );
                                        provider.add(RegisterEvent());
                                      }
                                    });
                                  },
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
                                        "Register",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: appFont,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                                  "Do you have an account?",
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
                                        builder: (c) => Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Login",
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
      ),
    );
  }

  Widget form(
      BuildContext context, double height, double width, AuthBloc provider) {
    return Column(
      children: [
        Container(
          width: width * 0.8,
          height: height * 0.08,
          child: TextInputWidget(
            message: "Name",
            icon: Icons.person,
            onClick: (newValue) {
              name = newValue;
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
          height: height * 0.02,
        ),
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
          height: height * 0.02,
        ),
        Container(
          width: width * 0.8,
          height: height * 0.08,
          child: TextInputWidget(
            message: "phone",
            icon: Icons.phone,
            onClick: (newValue) {
              phone = newValue;
            },
            onValidate: (value) {
              if (validatePhoneNubmer(value.toString()) == false) {
                return "phone number is wrong";
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: height * 0.02,
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
      ],
    );
  }

  void snackbarValidate(String s, BuildContext context) {
    setState(() {
      isProgressed = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
      ),
    );
  }
}
