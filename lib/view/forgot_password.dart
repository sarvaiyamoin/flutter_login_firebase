import 'package:flutter/material.dart';
import 'package:flutter_login_firebase/controller/auth_controller.dart';
import 'package:flutter_login_firebase/view/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthController authController = Get.put(AuthController());
  final _form = GlobalKey<FormState>();
  var _userEmail = "";

  Future<void> _submit() async {
    final _isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      print("_submit" + _userEmail);
      _form.currentState!.save();
      try {
        await authController
            .forgotPassword(_userEmail.trim())
            .then((value) => null);
      } catch (error) {
        Get.rawSnackbar(title: 'Error', message: '$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100)),
                    gradient: LinearGradient(
                        colors: [Colors.purple, Color(0xffcc3399)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: const FractionalOffset(0.9 / 2, 0.3),
                        child: IconButton(
                            onPressed: () {},
                            icon: const FaIcon(FontAwesomeIcons.userAlt,
                                size: 70, color: Colors.white)),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 20,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            autocorrect: true,
                            key: ValueKey('email'),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple)),
                              hintText: 'Email',
                              icon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter correct email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userEmail = value!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: () => Get.to(Login()),
                              child: Text("Login"))),
                      const SizedBox(
                        height: 15,
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
    );
  }
}
