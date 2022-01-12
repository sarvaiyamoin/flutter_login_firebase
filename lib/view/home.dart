import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_firebase/controller/auth_controller.dart';
import 'package:flutter_login_firebase/view/widget/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/userData.dart';
import 'package:get/get.dart';
import '../view/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController authController = Get.put(AuthController());
  // Map? userData = {};
  // List userData = [];
  final collecttionData = FirebaseFirestore.instance.collection('user');
  @override
  void initState() {
    // var document = FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(authController.uid.value);
    // document.get().then((document) {
    // print("Document" + document.data().toString());
    // Map a = document.data() as Map<String, dynamic>;
    // userData.add(a);
    // print("Document" + userData[0]['email']);
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await authController.userSignOut();
                // await FirebaseAuth.instance.signOut();
                // authController.isLoading.value = false;
                // Get.to(Login());
              },
              icon: const FaIcon(FontAwesomeIcons.signOutAlt))
        ],
        title: Text("Profile"),
      ),
      body: FutureBuilder(
          future: collecttionData.doc(authController.uid.value).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data as DocumentSnapshot;
              UserData userData = UserData.fromMap(data);
              return Profile(userData);
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }),
    );
  }
}
