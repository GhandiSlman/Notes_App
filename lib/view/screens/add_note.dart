import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/app_routes.dart';
import 'package:notes/controller/all_notes_controller.dart';

import '../widgets/custom_text_form.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  AllNotesControlller controller = Get.put(AllNotesControlller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.addNote().then(
                      (value) => Get.back(),
                    );
                
              },
              icon: Icon(
                Icons.done_rounded,
              ))
        ],
        // Add your app bar content here
        title: Text("Add Note"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formState,
                child: TextFormField(
                  
                  decoration: InputDecoration(
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                  controller: controller.note,
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
