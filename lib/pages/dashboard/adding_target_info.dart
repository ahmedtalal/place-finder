import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/text_input_widget_copy.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/reservation_model.dart';
import 'package:online_booking_places/models/target_model.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

class AddingTargetInfo extends StatefulWidget {
  @override
  _AddingTargetInfoState createState() => _AddingTargetInfoState();
}

class _AddingTargetInfoState extends State<AddingTargetInfo> {
  List<String> targets = ["Cinema", "Rastaurants", "Hotels"];
  var target;
  var formKey = GlobalKey<FormState>();
  bool isProgress = false;
  String imageUrl;
  File imageFile;
  String name, phone, location, locationDetails, description;
  double price, rating;
  int offer, counter;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var itemProvider = BlocProvider.of<ItemBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                    "adding item",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: appFont,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 20.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    chooseImageFile();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height * 0.07,
                                width: width * 0.5,
                                child: TextInputWidgetNoController(
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
                              Container(
                                width: width * 0.4,
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  ),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 5.0,
                                  ),
                                  child: DropdownButton(
                                    items: targets.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontFamily: appFont,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    isDense: true,
                                    iconSize: 20.0,
                                    hint: Text(
                                      "Targets",
                                      style: TextStyle(
                                        fontSize: 9.0,
                                        fontFamily: appFont,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        // you code is here >>>
                                        target = value;
                                      });
                                    },
                                    value: target,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height * 0.07,
                                width: width * 0.5,
                                child: TextInputWidgetNoController(
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
                                child: TextInputWidgetNoController(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height * 0.07,
                                width: width * 0.5,
                                child: TextInputWidgetNoController(
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
                                child: TextInputWidgetNoController(
                                  message: "counter",
                                  icon: Icons.add,
                                  onClick: (newValue) {
                                    counter = int.parse(newValue);
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
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height * 0.07,
                                width: width * 0.46,
                                child: TextInputWidgetNoController(
                                  message: "location",
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
                              Container(
                                height: height * 0.07,
                                width: width * 0.46,
                                child: TextInputWidgetNoController(
                                  message: "phone",
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
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            height: height * 0.07,
                            width: width,
                            child: TextInputWidgetNoController(
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
                            height: 12.0,
                          ),
                          Container(
                            height: height * 0.15,
                            width: width,
                            child: TextInputWidgetNoController(
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
                      height: 12.0,
                    ),
                    Center(
                      child: BlocListener<ItemBloc, ItemStates>(
                        listener: (context, state) {
                          if (state is AddingItemScuessedState) {
                            Navigator.of(context).pop();
                          } else if (state is AddingItemFailedState) {
                            snackbarValidate("the process failed", context);
                          }
                        },
                        child: BlocBuilder<ItemBloc, ItemStates>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  isProgress = true;
                                });
                                if (formKey.currentState.validate()) {
                                  print("Ok");
                                  List<ReservationModel> list = [];
                                  var uId = Uuid().v1();
                                  TargetModel targetModel = TargetModel(
                                    name: name,
                                    type: target,
                                    id: uId,
                                    description: description,
                                    location: location,
                                    locationDetails: locationDetails,
                                    image: imageUrl,
                                    numOfRooms: counter,
                                    price: price,
                                    rating: rating,
                                    offer: offer,
                                    reservationList: list,
                                    placePhone: phone,
                                  );
                                  itemProvider.model = targetModel;
                                  itemProvider.add(AddingItemEvent());
                                }
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
                                    "save",
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
                    ),
                  ],
                ),
              )
            ],
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

  Future chooseImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    uploadImage();
  }

  uploadImage() async {
    String fileName = basename(imageFile.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('ItemImages/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        print(value);
        imageUrl = value;
      });
    });
  }
}
