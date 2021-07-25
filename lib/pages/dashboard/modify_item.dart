import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/text_input_widget.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/target_model.dart';

// ignore: must_be_immutable
class ModifyItem extends StatefulWidget {
  Map<String, dynamic> itemData;
  ModifyItem({
    @required this.itemData,
  });
  @override
  _ModifyItemState createState() => _ModifyItemState();
}

class _ModifyItemState extends State<ModifyItem> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController ratingTextController = TextEditingController();
  TextEditingController offerTextController = TextEditingController();
  TextEditingController locationDetailsTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  TextEditingController countTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // new values
  var name,
      phone,
      location,
      locationDetails,
      offer,
      count,
      rating,
      description,
      price;

  bool isProgress = false;

  @override
  void initState() {
    super.initState();
    nameTextController.text = widget.itemData["name"];
    phoneTextController.text = widget.itemData["placephone"];
    locationTextController.text = widget.itemData["location"];
    locationDetailsTextController.text = widget.itemData["locationDetails"];
    countTextController.text = widget.itemData["numOfRooms"].toString();
    priceTextController.text = widget.itemData["price"].toString();
    ratingTextController.text = widget.itemData["rating"].toString();
    offerTextController.text = widget.itemData["offer"].toString();
    descriptionTextController.text = widget.itemData["description"];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var itemProvider = BlocProvider.of<ItemBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                      "Modify Item",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: appFont,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    primary: true,
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.07,
                                width: double.infinity,
                                child: TextInputWidget(
                                  textEditingController: nameTextController,
                                  message: "name",
                                  icon: Icons.add,
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
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.5,
                                    child: TextInputWidget(
                                      textEditingController:
                                          priceTextController,
                                      message: "price",
                                      icon: Icons.add,
                                      onClick: (newValue) {
                                        price = double.parse(newValue);
                                      },
                                      onValidate: (value) {
                                        if (value.isEmpty) {
                                          return "this field is required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.4,
                                    child: TextInputWidget(
                                      textEditingController:
                                          countTextController,
                                      message: "count",
                                      icon: Icons.add,
                                      onClick: (newValue) {
                                        count = int.parse(newValue);
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
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.5,
                                    child: TextInputWidget(
                                      textEditingController:
                                          ratingTextController,
                                      message: "rating",
                                      icon: Icons.add,
                                      onClick: (newValue) {
                                        rating = double.parse(newValue);
                                      },
                                      onValidate: (value) {
                                        if (value.isEmpty) {
                                          return "this field is required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.4,
                                    child: TextInputWidget(
                                      textEditingController:
                                          offerTextController,
                                      message: "offer",
                                      icon: Icons.add,
                                      onClick: (newValue) {
                                        offer = int.parse(newValue);
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
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                height: height * 0.07,
                                width: double.infinity,
                                child: TextInputWidget(
                                  textEditingController: phoneTextController,
                                  message: "phone",
                                  icon: Icons.add,
                                  onClick: (newValue) {
                                    location = newValue;
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
                                height: 15,
                              ),
                              Container(
                                height: height * 0.07,
                                width: double.infinity,
                                child: TextInputWidget(
                                  textEditingController: locationTextController,
                                  message: "location",
                                  icon: Icons.add,
                                  onClick: (newValue) {
                                    phone = newValue;
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
                                height: 15,
                              ),
                              Container(
                                height: height * 0.07,
                                width: double.infinity,
                                child: TextInputWidget(
                                  textEditingController:
                                      locationDetailsTextController,
                                  message: "location details",
                                  icon: Icons.add,
                                  onClick: (newValue) {
                                    locationDetails = newValue;
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
                                height: 15,
                              ),
                              Container(
                                height: height * 0.15,
                                width: double.infinity,
                                child: TextInputWidget(
                                  textEditingController:
                                      descriptionTextController,
                                  message: "description",
                                  icon: Icons.add,
                                  onClick: (newValue) {
                                    description = newValue;
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
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BlocListener<ItemBloc, ItemStates>(
                              listener: (context, state) {
                                if (state is UpdateSuccessed) {
                                  Navigator.of(context).pop();
                                } else if (state is UpdatedFailed) {
                                  snackbarValidate(
                                      "updating process is unsuccessfully",
                                      context);
                                }
                              },
                              child: BlocBuilder<ItemBloc, ItemStates>(
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () {
                                      if (formKey.currentState.validate()) {
                                        setState(() {
                                          isProgress = true;
                                        });
                                        itemProvider.newModel = TargetModel(
                                          name: name,
                                          type: widget.itemData["type"],
                                          id: widget.itemData["id"],
                                          description: description,
                                          location: location,
                                          locationDetails: locationDetails,
                                          image: widget.itemData["image"],
                                          numOfRooms: count,
                                          price: price,
                                          rating: rating,
                                          offer: offer,
                                          reservationList: widget
                                              .itemData["reservationList"],
                                          placePhone: phone,
                                        );
                                        itemProvider.add(UpdateItemEvent());
                                      }
                                    },
                                    child: Container(
                                      width: width * 0.43,
                                      height: height * 0.076,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Update",
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
                            BlocListener<ItemBloc, ItemStates>(
                              listener: (context, state) {
                                if (state is DeletedSuccessed) {
                                  Navigator.of(context).pop();
                                } else if (state is DeletedFailed) {
                                  snackbarValidate(
                                      "deleting process is unsuccessfully",
                                      context);
                                }
                              },
                              child: BlocBuilder<ItemBloc, ItemStates>(
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () {
                                      if (formKey.currentState.validate()) {
                                        setState(() {
                                          isProgress = true;
                                        });
                                        itemProvider.newModel =
                                            widget.itemData["id"];
                                        itemProvider.add(DeleteItemEvent());
                                      }
                                    },
                                    child: Container(
                                      width: width * 0.43,
                                      height: height * 0.076,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Delete",
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
                          ],
                        ),
                      ],
                    ),
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
      isProgress = false;
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
