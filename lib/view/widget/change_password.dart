import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_firebase/controller/auth_controller.dart';
import 'package:flutter_login_firebase/view/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  final _form = GlobalKey<FormState>();
  var _newPassword = "";
  var _confirmPassword = "";
  TextEditingController newPassword = TextEditingController();
  ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _submit() async {
      final _isValid = _form.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (_isValid) {
        print("_submit" + _newPassword.toString());
        _form.currentState!.save();
        try {
          authController.isLoading.value = true;
          await authController.changePassword(_newPassword.trim());
          // .then((value) => FirebaseAuth.instance.signOut().then((value) {
          //       Get.offAll(Login());
          authController.isLoading.value = false;
          // })

          // );
        } catch (error) {
          Get.rawSnackbar(title: 'Error', message: '$error');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Obx(
        () => authController.isLoading.value
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Loading...."),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: context.isSmallTablet
                              ? Get.width * 0.50
                              : Get.width * 0.85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 20, left: 20),
                                  child: TextFormField(
                                    key: ValueKey('password'),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return "Password must be  8 character long";
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    controller: newPassword,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple)),
                                      hintText: 'New Password',
                                      icon: FaIcon(FontAwesomeIcons.key),
                                    ),
                                    onSaved: (value) {
                                      _newPassword = value!;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 20, left: 20),
                                  child: TextFormField(
                                    key: ValueKey('confirm password'),
                                    validator: (value) {
                                      // print("Document" + _password.text);
                                      if (value!.isEmpty ||
                                          value.length < 8 ||
                                          value != newPassword.text) {
                                        return "Password enter correct password";
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple)),
                                      hintText: 'Confirm Password',
                                      icon: FaIcon(FontAwesomeIcons.check),
                                    ),
                                    // onSaved: (value) {
                                    //   _userPassword = value!;
                                    // },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(0.0)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80)))),
                                  onPressed: () {
                                    _submit();
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Colors.purple,
                                            Color(0xffcc3399)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: double.infinity,
                                          minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Submit",
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
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
