import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/controller/home_page_controller.dart';

import '../widgets/custom_text_form.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add folder'),
                content: Form(
                  key: controller.formState,
                  child: CustomTextForm(
                    hinttext: 'Enter the name of folder',
                    mycontroller: controller.name,
                    validator: (val) {
                      if (val == '') {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                ),
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
                      controller.addFolder();
                      Get.back();
                      controller.name.clear();
                    },
                    child: const Text('Done',
                        style: TextStyle(
                            color: Color.fromARGB(255, 87, 173, 244))),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Color.fromARGB(255, 87, 173, 244)),
      ),
      appBar: AppBar(
        title: Text('All notes'),
        actions: [
          IconButton(
              onPressed: () async {
                controller.signOut();
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.folderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Display a loading indicator
          }
          if (snapshot.hasData) {
            controller.setData(snapshot.data!.docs);
          }

          return GridView.builder(
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 231, 245, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      height: 150,
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Deletion!'),
                                    content: Text(
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
                                          controller.deleteFolder(
                                              controller.data[index].id);
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
                            child: ListTile(
                              tileColor: Colors.grey,
                              leading: Text('Delete folder'),
                            ))
                      ]),
                    ),
                  );
                },
                child: Card(
                  color: Color.fromARGB(255, 231, 245, 255),
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.asset('images/folder.png'),
                      ),
                      SizedBox(height: 10),
                      Text(controller.data[index]['name'].toString()),
                    ],
                  ),
                ),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            padding: EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
