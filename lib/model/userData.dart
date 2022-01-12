class UserData {
  String? email;
  String? password;
  String? userPhone;
  String? userState;
  String? userCity;

  UserData(
      this.email, this.password, this.userPhone, this.userState, this.userCity);

  UserData.fromMap(map) {
    email = map['email'];
    password = map['password'];
    userCity = map['userCity'];
    userPhone = map['userPhone'];
    userState = map['userState'];
  }
}
