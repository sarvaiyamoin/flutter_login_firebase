import 'package:flutter/material.dart';
import 'package:flutter_login_firebase/model/userData.dart';
import 'package:flutter_login_firebase/view/widget/change_password.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final UserData userData;
  const Profile(this.userData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: FaIcon(
                FontAwesomeIcons.userCircle,
                size: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Email : " + userData.email.toString()),
            Text("Phone no : " + userData.userPhone.toString()),
            Text("State : " + userData.userState.toString()),
            Text("City  : " + userData.userCity.toString()),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(0.0)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80)))),
                onPressed: () {
                  // _submit();
                  Get.to(ChangePassword());
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Color(0xffcc3399)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints: const BoxConstraints(
                        maxWidth: double.infinity, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Change Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
