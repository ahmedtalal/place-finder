const String appFont = "JosefinSans";
const backgroundImage = "assets/images/background.png";
const lignt1Image = "assets/images/light-1.png";
const light2Image = "assets/images/light-2.png";
const clockImage = "assets/images/clock.png";

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
