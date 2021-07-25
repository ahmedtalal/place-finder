import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_bloc.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_events.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_states.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/cart_model.dart';
import 'package:online_booking_places/pages/cart.dart';

// ignore: must_be_immutable
class CartView extends StatelessWidget {
  Map<String, dynamic> data;
  CartView({
    @required this.data,
  });
  int newQunantity;
  @override
  Widget build(BuildContext context) {
    var cartProvider = BlocProvider.of<CartBloc>(context);
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 3.0,
          right: 2.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                height: 40,
                width: 40,
                fit: BoxFit.fill,
                imageUrl: data["itemImage"],
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image(
                  image: AssetImage(emptyData),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    data["itemName"],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: appFont,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    data["newPrice"].toString() + " LE",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: appFont,
                      color: Colors.amber,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2.0,
                      decorationColor: Colors.amberAccent,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Edit Qauntity"),
                            content: TextFormField(
                              onChanged: (value) {
                                newQunantity = int.parse(value);
                              },
                              initialValue: data["quantity"].toString(),
                              decoration: InputDecoration(
                                labelText: "Quantity",
                                labelStyle: TextStyle(
                                  fontFamily: appFont,
                                  color: Colors.grey[500],
                                  fontSize: 15.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.4,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.4,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.4,
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontFamily: appFont,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              BlocListener<CartBloc, CartStates>(
                                listener: (context, state) {
                                  if (state is CartUpdatedSuccessfullyState) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Cart(),
                                      ),
                                    );
                                  } else if (state is CartUpdatedFailedState) {
                                    snackBarValidate(
                                        "Error in operation", context);
                                  }
                                },
                                child: ElevatedButton(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontFamily: appFont,
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO:implement edit quantity function
                                    print(newQunantity);
                                    double newPrice =
                                        data["price"] * newQunantity;
                                    cartProvider.model = CartModel(
                                      itemId: data["itemId"],
                                      itemImage: data["itemImage"],
                                      itemName: data["itemName"],
                                      itemCartId: data["itemCartId"],
                                      price: data["price"],
                                      newPrice: newPrice,
                                      quantity: newQunantity,
                                    );
                                    cartProvider.add(UpdateCartInfo());
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                  BlocListener<CartBloc, CartStates>(
                    listener: (context, state) {
                      if (state is CartDeletedSuccessfullyState) {
                        snackBarValidate("deleted successfully", context);
                      } else if (state is CartDeletedFailedState) {
                        snackBarValidate("deleted failed", context);
                      }
                    },
                    child: BlocBuilder<CartBloc, CartStates>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            cartProvider.id = data["itemCartId"];
                            cartProvider.add(DeleteCartInfo());
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 18.0,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void snackBarValidate(String s, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
      ),
    );
  }
}
