import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/const/app_routes.dart';
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
        child: const Icon(Icons.add, color: Color.fromARGB(255, 87, 173, 244)),
      ),
      appBar: AppBar(
        title: Text('All folders'),
        actions: [
          IconButton(
              onPressed: () async {
                controller.signOut();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.folderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

          return GridView.builder(
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 231, 245, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      height: 150,
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {
                              Get.back();
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
                            child: const ListTile(
                              tileColor: Colors.grey,
                              leading: Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                              ),
                              title: Text('Delete folder'),
                            )),
                        const Divider(
                          endIndent: 20,
                          indent: 20,
                          color: Colors.black,
                        ),
                        InkWell(
                            onTap: () {
                              Get.back();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit!'),
                                    content: Form(
                                      key: controller.formState2,
                                      child: CustomTextForm(
                                        hinttext: 'Enter new name',
                                        mycontroller: controller.editName,
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
                                          controller.editFolder(
                                              controller.data[index].id);
                                          Get.back();
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
                            child: const ListTile(
                              tileColor: Colors.grey,
                              leading: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                              title: Text('Edit folder'),
                            ))
                      ]),
                    ),
                  );
                },
                child: InkWell(
                  onTap: () {
                  
                    Get.toNamed(AppRoute.allnotes,arguments: {
                      'id':controller.data[index].id,
                      'name': controller.data[index]['name']
                    },);
                    
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 231, 245, 255),
                    elevation: 10,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.asset('images/folder.png'),
                        ),
                        const SizedBox(height: 10),
                        Text(controller.data[index]['name'].toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            padding: const EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
