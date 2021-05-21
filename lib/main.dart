import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/firebase_operations/auth_operations.dart';
import 'package:online_booking_places/backend/firebase_operations/item_operations.dart';
import 'package:online_booking_places/backend/firebase_operations/user_operation.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/reviews_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/pages/dashboard/dash_home.dart';
import 'package:online_booking_places/pages/home.dart';
import 'package:online_booking_places/pages/splash_screen.dart';
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
        BlocProvider<ItemBloc>(
          create: (context) {
            return ItemBloc(
              repositoryModel: ItemOperations(),
            );
          },
        ),
        BlocProvider<ReviewsBloc>(
          create: (context) {
            return ReviewsBloc(
              repositoryModel: ItemOperations(),
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthOperations.instance().checkCurrentUser() == false
            ? SplashScreen()
            : FirebaseAuth.instance.currentUser.email == "admin@gmail.com"
                ? DashHome()
                : Home(),
      ),
    );
  }
}
