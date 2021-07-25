import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/components/item_view.dart';

// ignore: must_be_immutable
class FavoriteView extends StatelessWidget {
  List items;
  FavoriteView({@required this.items});

  @override
  Widget build(BuildContext context) {
    var itemProvider = BlocProvider.of<ItemBloc>(context);
    itemProvider.specilaModel = items;
    itemProvider.add(FetchSpecialItemEvents());

    return BlocBuilder<ItemBloc, ItemStates>(
      builder: (context, state) {
        var result = [];
        if (state is ItemsLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SpecialItemsLoadedState) {
          result = state.response;
        }
        return ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            return StreamBuilder<DocumentSnapshot>(
              stream: result[index],
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var response = snapshot.data.data();
                  return ItemView(
                    targetMap: response,
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
