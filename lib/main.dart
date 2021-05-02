import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/firebase_operations/auth_operations.dart';
import 'package:online_booking_places/backend/firebase_operations/user_operation.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/pages/auth_screen/register.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // is used to interact with firebase engine >>
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(
              authRepoModel: AuthOperations(
                repositoryModel: UserOperation(),
              ),
            );
          },
        ),
        BlocProvider<UserBloc>(
          create: (context) {
            return UserBloc(
              repositoryModel: UserOperation(),
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Register(),
      ),
    );
  }
}
