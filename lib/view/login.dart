import 'package:flutter/material.dart';
import 'package:flutter_login_firebase/controller/auth_controller.dart';
import 'package:flutter_login_firebase/view/forgot_password.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthController authController = Get.put(AuthController());
  final _form = GlobalKey<FormState>();
  String _userEmail = "";
  String _userPassword = "";
  String _userPhone = "";
  String _userstate = "";
  String _usercity = "";

  TextEditingController _password = TextEditingController();

  var _isLogin = true;
  Future<void> _submit() async {
    final _isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      _form.currentState!.save();
      try {
        await authController.submit(_userEmail.trim(), _userPassword.trim(),
            _userPhone.trim(), _userstate.trim(), _usercity.trim(), _isLogin);
      } catch (error) {
        Get.rawSnackbar(title: 'Error', message: '$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    // print("width : ${Get.width}");
    // // ignore: avoid_print
    // print("height : ${Get.height}");
    return Scaffold(
      body: Obx(() {
        return authController.isLoading.value
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
            : Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * 0.40,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100)),
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
                              right: 30,
                              child: Text(
                                _isLogin ? "Login" : "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: context.isSmallTablet
                            ? Get.width * 0.50
                            : Get.width * 0.85,
                        child: Column(
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
                                        borderSide:
                                            BorderSide(color: Colors.purple)),
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
                                  controller: _password,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)),
                                    hintText: 'Password',
                                    icon: FaIcon(FontAwesomeIcons.key),
                                  ),
                                  onSaved: (value) {
                                    _userPassword = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _isLogin
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.to(ForgotPassword());
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                              color: Colors.purpleAccent),
                                        )),
                                  )
                                : Container(),
                            if (!_isLogin)
                              Column(
                                children: [
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 20, left: 20),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        key: ValueKey('confirm password'),
                                        validator: (value) {
                                          // print("Document" + _password.text);
                                          if (value!.isEmpty ||
                                              value.length < 8 ||
                                              value != _password.text) {
                                            return "Enter correct password";
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple)),
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
                                    height: 15,
                                  ),
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 20, left: 20),
                                      child: TextFormField(
                                        key: ValueKey('phone'),
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple)),
                                          hintText: 'Phone number',
                                          icon: FaIcon(FontAwesomeIcons.phone),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 10) {
                                            return "Phone no must be 10 character long";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _userPhone = value!;
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
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 20, left: 20),
                                      child: TextFormField(
                                        key: ValueKey('State'),
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple)),
                                          hintText: 'State',
                                          icon: FaIcon(
                                              FontAwesomeIcons.placeOfWorship),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter state name";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _userstate = value!;
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
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 20, left: 20),
                                      child: TextFormField(
                                        key: ValueKey('City'),
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple)),
                                          hintText: 'City',
                                          icon: FaIcon(FontAwesomeIcons.city),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter city name";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _usercity = value!;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _isLogin
                                            ? "Don't have an account?"
                                            : "Already have an account?",
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(
                                    _isLogin ? "Sign Up" : "Login",
                                    style:
                                        TextStyle(color: Colors.purpleAccent),
                                  ),
                                ),
                              ],
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
                                      _isLogin ? "LOGIN" : "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
