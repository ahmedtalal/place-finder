import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/user_view_adapter.dart';
import 'package:online_booking_places/constants.dart';

class ShowUsers extends StatefulWidget {
  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  @override
  Widget build(BuildContext context) {
    var userProvider = BlocProvider.of<UserBloc>(context);
    userProvider.add(FetchUsersEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActionWidget(
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back_ios,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  "Users",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: appFont,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserStates>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserLoadedState) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: state.response,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            String image = snapshot.data.docs[index]["image"];
                            return UserViewAdapter(
                              name: snapshot.data.docs[index]["name"],
                              email: snapshot.data.docs[index]["email"],
                              phone: snapshot.data.docs[index]["phoneNumber"],
                              image: image == "null" ? userImage : image,
                            );
                          },
                        );
                      },
                    );
                  } else if (state is UserErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
