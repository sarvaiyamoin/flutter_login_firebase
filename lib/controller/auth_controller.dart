import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_firebase/view/home.dart';
import 'package:flutter_login_firebase/view/login.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var uid = "".obs;
  Future<void> submit(String email, String password, String userPhone,
      String userState, String userCity, bool isLogin) async {
    UserCredential userCredential;
    print("Hello");
    try {
      isLoading.value = true;
      if (isLogin) {
        print("login");
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid)
            .set({
          'email': email,
          'password': password,
          'userPhone': userPhone,
          'userState': userState,
          'userCity': userCity,
        });
      }
      uid.value = userCredential.user!.uid;
      isLoading.value = false;
      Get.offAll(Home());
    } on FirebaseAuthException catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        case "wrong-password":
          errorMessage = "Wrong email/password combination.";
          break;
        case "user-not-found":
          errorMessage = "No user found with this email.";
          break;
        case "user-disabled":
          errorMessage = "User disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Too many requests to log into this account.";
          break;
        case "operation-not-allowed":
          errorMessage = "Server error, please try again later.";
          break;
        case "invalid-email":
          errorMessage = "Email address is invalid.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Get.rawSnackbar(title: 'Error', message: errorMessage);
      isLoading.value = false;
    }
    // print(message);
    catch (error) {
      // print(error);

      isLoading.value = false;
      // rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.rawSnackbar(
          title: 'Email send', message: 'Forgot Password email has been sent');
    } on FirebaseAuthException catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your Email is Wrong";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Get.rawSnackbar(title: 'Error', message: errorMessage);
    } catch (error) {}
  }

  Future<void> changePassword(String password) async {
    try {
      print("change Password");
      print(isLoading.value);
      // isLoading.value = true;
      await _auth.currentUser!.updatePassword(password);
      await FirebaseAuth.instance.signOut().then((value) {
        isLoading.value = false;

        Get.offAll(Login());
      });

      // isLoading.value = false;12345
      Get.rawSnackbar(
          title: 'Successful', message: 'Password change successfully');
    } on FirebaseAuthException catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your Email is Wrong";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        default:
          errorMessage = "Something went wrong.";
      }
      Get.rawSnackbar(title: 'Error', message: errorMessage);
    } catch (error) {}
  }

  Future<void> userSignOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(Login());
    isLoading.value = false;
  }
}
