import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_events.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_states.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/auth_screen/register.dart';

class DashBoardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = BlocProvider.of<AuthBloc>(context);

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(
                  admin,
                ),
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "admin@gmail.com",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: appFont,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: appFont,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          BlocListener<AuthBloc, AuthStates>(
            listener: (context, state) {
              if (state is LogOutFailed) {
                print("error");
              } else if (state is LogOutSucessed) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (c) => Register(),
                  ),
                );
              }
            },
            child: IconButton(
              onPressed: () {
                authProvider.add(LogOutEvent());
              },
              icon: Image.asset(
                logoutImage,
                height: 16.0,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
