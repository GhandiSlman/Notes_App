import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../const/app_routes.dart';

class LogiController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offNamed(AppRoute.homepage);
  }

  signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      if (credential.user!.emailVerified) {
        Get.offNamed(AppRoute.homepage);
      } else {
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                'Please check your email and press on the link that we have send'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('The password provided is too weak.');
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('The password provided is too weak.'));
      } else if (e.code == 'wrong-password') {
        print('The account already exists for that email.');
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
    }
  }

  sendPassResetEmail() {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(
              'Please check your email and press on the link that we have send.'));
    } catch (e) {
      SnackBar(
          backgroundColor: Colors.red,
          content: Text('The email that you have entered it is not'));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
}
