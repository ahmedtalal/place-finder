import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_events.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/text_input_widget_copy.dart';
import 'package:online_booking_places/constants.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool isProgressed = false;
  String newPassword;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var authProvider = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isProgressed,
        child: Padding(
          padding: EdgeInsets.all(
            12.0,
          ),
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  children: [
                    ActionWidget(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.arrow_back_ios,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: appFont,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.8,
                        height: height * 0.073,
                        child: TextInputWidgetNoController(
                          message: "new password",
                          icon: Icons.lock,
                          onClick: (newValue) {
                            newPassword = newValue;
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
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                BlocListener<AuthBloc, AuthStates>(
                  listener: (context, state) {
                    if (state is UpdatePassSuccessded) {
                      snackbarValidate(
                          'Password has been successfully updated, Now you can logout and try writting the new password',
                          context);
                    } else if (state is UpdatePassFailed) {
                      snackbarValidate('The operation failed', context);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthStates>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isProgressed = true;
                          });
                          print(newPassword);
                          authProvider.model = newPassword;
                          authProvider.add(UpdatePassEvent());
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
                              "Update",
                              style: TextStyle(
                                fontSize: 14.0,
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
              ],
            ),
          ),
        ),
      ),
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
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: appFont,
          ),
        ),
      ),
    );
  }
}
