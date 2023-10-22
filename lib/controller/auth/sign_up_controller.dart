import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/app_routes.dart';

class SignUpController extends GetxController {
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;

  createAccountWithEmailAndPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text('Hello, You need to login now')));
      Get.offNamed(AppRoute.login);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.red,
        //     content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.red,
        //     content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
  }
}
