import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/app_routes.dart';
import 'package:notes/controller/all_notes_controller.dart';

import '../widgets/custom_text_form.dart';

class EditNote extends StatelessWidget {
  EditNote({super.key});

  final noteId = Get.arguments['id'];
  final noteName = Get.arguments['note'];
  @override
  Widget build(BuildContext context) {
    AllNotesControlller controller = Get.put(AllNotesControlller());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Center(
                  child: CircularProgressIndicator(),
                );
                controller.editNotes(noteId).then((value) => Get.back());
              },
              icon: Icon(
                Icons.done_rounded,
              ))
        ],
        // Add your app bar content here
        title: const Text('Note'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formState2,
                child: TextFormField(
                  decoration: InputDecoration(
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                  controller: controller.editNote,
                  validator: (val) {
                    if (val == '') {
                      return "can't be empty";
                      //Get.back();
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
