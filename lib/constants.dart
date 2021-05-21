import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

const String appFont = "JosefinSans";
const String adminEMail = "admin@gmail.com";
const String adminPassword = "admin123";
const String sliderTitle1 = "Reservation";
const String sliderTitle2 = "See Feedbacks";
const String sliderTitle3 = "Find your place";
const String description1 =
    "you can book cinema or hotel or restaurant from our app ";
const String description2 =
    "you can add your feedback about any place that you booked it and see all feedbacks about this place before booking";
const String description3 =
    "you can search for the cinema or restaurant or hotel from the app, and the app will show the nearest places to you";

const backgroundImage = "assets/images/background.png";
const lignt1Image = "assets/images/light-1.png";
const light2Image = "assets/images/light-2.png";
const clockImage = "assets/images/clock.png";
const String homePage = "assets/images/home.png";
const String favoritesPage = "assets/images/favorites.png";
const String settingPage = "assets/images/settings.png";
const String userImage = "assets/images/user.png";
const String logoutImage = "assets/images/logout.png";
const String admin = "assets/images/admin.png";
const String group = "assets/images/group.png";
const String adding = "assets/images/adding.png";
const String cinema = "assets/images/cinema.png";
const String restaurant = "assets/images/restaurant.png";
const String hotel = "assets/images/hotel.png";

const String sliderImage1 = "assets/images/location.jpg";
const String sliderImage2 = "assets/images/rating.jpg";
const String sliderImage3 = "assets/images/reservation.jpg";
const String editImage = "assets/images/edit.png";
const String changePassword = "assets/images/changepassword.png";
const String shareAppImage = "assets/images/share.png";
const String rateAppImage = "assets/images/rate.png";
const String myCartImage = "assets/images/cart.png";
const String offersImage = "assets/images/offer.png";
const String logoutmage = "assets/images/logout1.png";
const String emptyData = "assets/images/emptysearch.png";

bool validatePhoneNubmer(String number) {
  if (number.isEmpty) {
    return false;
  } else if (number.length < 11) {
    print("ds");
    return false;
  } else if (number.substring(0, 3) != "011" &&
      number.substring(0, 3) != "010" &&
      number.substring(0, 3) != "012" &&
      number.substring(0, 3) != "015") {
    print(number.substring(0, 3));
    return false;
  } else {
    return true;
  }
}

String _url =
    "https://play.google.com/store/apps/details?id=com.example.online_booking_places&referrer=utm_source%3Dgoogle";
shared(String message, BuildContext context) {
  final RenderBox box = context.findRenderObject();
  Share.share(
    "${message + "the app link on google play : " + _url}",
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}

launchUrl() async {
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw "could not launch $_url";
  }
}
