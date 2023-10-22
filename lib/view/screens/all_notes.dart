import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/const/app_routes.dart';
import 'package:notes/controller/all_notes_controller.dart';
import 'package:notes/controller/home_page_controller.dart';
import 'package:notes/view/screens/add_note.dart';
import 'package:notes/view/screens/edit_note.dart';

import '../widgets/custom_text_form.dart';

class AllNotes extends StatelessWidget {
  AllNotes({
    super.key,
  });
  AllNotesControlller controller = Get.put(AllNotesControlller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // Get.toNamed(AppRoute.addnote,);
          Get.to(AddNote());
        },
        child: const Icon(Icons.add, color: Color.fromARGB(255, 87, 173, 244)),
      ),
      appBar: AppBar(
        title: Text(controller.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.getNotes(controller.id),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Display a loading indicator
                }
                if (snapshot.hasData) {
                  controller.setData(snapshot.data!.docs);
                }

                return ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.editnote, arguments: {
                            'id': controller.data[index].id,
                            'note':controller.data[index]['note']
                          });
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Deletion!'),
                                content: const Text(
                                    'Are you sure you want to delete?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.deleteNote(
                                        controller.data[index].id,
                                      );
                                    },
                                    child: const Text('Ok',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 87, 173, 244))),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(controller.data[index]['note']),
                            ),
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
