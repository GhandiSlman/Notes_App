import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class HomePageController extends GetxController {
  late final TextEditingController name;
  late final TextEditingController editName;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> formState2 = GlobalKey<FormState>();
  CollectionReference folders =
      FirebaseFirestore.instance.collection('folders');
  RxList<QueryDocumentSnapshot> data = <QueryDocumentSnapshot>[].obs;
  Future<void> addFolder() async {
    if (formState.currentState!.validate()) {
      return folders
          .add({
            'name': name.text,
            'id': FirebaseAuth.instance.currentUser!.uid,
          })
          .then((value) => print("folder Added"))
          .catchError((error) => print("Failed to add folder: $error"));
    }
  }

  Future editFolder(String id) async {
    if (formState2.currentState!.validate()) {
      await folders.doc(id).update({'name': editName.text});
    }
  }

  deleteFolder(String id) {
    FirebaseFirestore.instance.collection('folders').doc(id).delete();
    Get.back();
  }

  void setData(List<QueryDocumentSnapshot> newData) {
    data.value = newData;
  }

  Stream<QuerySnapshot> folderStream = FirebaseFirestore.instance
      .collection('folders')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    // googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    Get.offNamed('login');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    name = TextEditingController();
    editName = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    editName.dispose();
    print('=======================');
  }
}
