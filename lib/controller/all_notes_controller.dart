import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllNotesControlller extends GetxController {
  final id = Get.arguments['id'];
  final name = Get.arguments['name'];
  late final TextEditingController note;
  late final TextEditingController editNote;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> formState2 = GlobalKey<FormState>();
  Future<void> addNote() async {
    if (formState.currentState!.validate()) {
      CollectionReference notes = FirebaseFirestore.instance
          .collection('folders')
          .doc(id)
          .collection('note');
      notes
          .add({
            'note': note.text,
          })
          .then((value) => print("note Added"))
          .catchError((error) => print("Failed to add note: $error"));
    }
  }

  deleteNote(String noteID) {
    FirebaseFirestore.instance
        .collection('folders')
        .doc(id)
        .collection('note')
        .doc(noteID)
        .delete();
    Get.back();
  }

  Future editNotes(String noteId) async {
    if (formState2.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('folders')
          .doc(id)
          .collection('note')
          .doc(noteId)
          .update({'note': editNote.text}).then((value) => editNote.clear());
    }
  }

  RxList<QueryDocumentSnapshot> data = <QueryDocumentSnapshot>[].obs;

  void setData(List<QueryDocumentSnapshot> newData) {
    data.value = newData;
  }

  Stream<QuerySnapshot> getNotes(String folederId) {
    Stream<QuerySnapshot> folderStream = FirebaseFirestore.instance
        .collection('folders')
        .doc(folederId)
        .collection('note')
        .snapshots();
    return folderStream;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
    editNote.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    note = TextEditingController();
    editNote = TextEditingController();
  }
}
