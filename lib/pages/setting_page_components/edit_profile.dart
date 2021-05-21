import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/text_input_widget.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  String name, email, phone, image;
  EditProfile({
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.image,
  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File imageFile;
  String userName, phone;
  bool isProgressed = false;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    userName = widget.name;
    phone = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isProgressed,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.all(
              10.0,
            ),
            child: SingleChildScrollView(
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
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: appFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 105.0,
                          child: Stack(
                            children: [
                              Container(
                                height: 70.0,
                                width: 75.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: 25.0,
                                    child: widget.image == "null"
                                        ? Image(
                                            image: AssetImage(userImage),
                                          )
                                        : ClipOval(
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: widget.image,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image(
                                                image: AssetImage(userImage),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    chooseImageFile();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.035,
                        ),
                        Form(
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.8,
                                height: height * 0.073,
                                child: TextInputWidget(
                                  textEditingController: nameController,
                                  message: "userName",
                                  icon: Icons.person,
                                  onClick: (newValue) {
                                    userName = newValue;
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
                              Container(
                                width: width * 0.8,
                                height: height * 0.073,
                                child: TextInputWidget(
                                  textEditingController: emailController,
                                  message: "Email",
                                  icon: Icons.email,
                                  onClick: (newValue) {},
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
                              Container(
                                width: width * 0.8,
                                height: height * 0.073,
                                child: TextInputWidget(
                                  textEditingController: phoneController,
                                  message: "phone",
                                  icon: Icons.phone,
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
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                        BlocListener<UserBloc, UserStates>(
                          listener: (context, state) {
                            if (state is UserUpdatedState) {
                              Navigator.of(context).pop();
                            } else if (state is UserErrorState) {
                              snackbarValidate(state.error, context);
                            }
                          },
                          child: BlocBuilder<UserBloc, UserStates>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    isProgressed = true;
                                  });
                                  UserModel userModel = UserModel(
                                    name: userName,
                                    email: emailController.text,
                                    id: FirebaseAuth.instance.currentUser.uid,
                                    image: imageUrl,
                                    phoneNumber: phone,
                                  );
                                  userProvider.model = userModel;
                                  userProvider.add(UpdateUserEvent());
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
                      ],
                    ),
                  )
                ],
              ),
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
        FirebaseStorage.instance.ref().child('usersImages/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        print(value);
        imageUrl = value;
      });
    });
  }
}
