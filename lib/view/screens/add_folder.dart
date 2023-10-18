import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notes/view/widgets/custom_button_auth.dart';
import 'package:notes/view/widgets/custom_text_form.dart';

class AddFolder extends StatefulWidget {
  const AddFolder({super.key});

  @override
  State<AddFolder> createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Folder',
        ),
      ),
      body: Form(
        key: formState,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextForm(
                hinttext: 'Enter the name of folder',
                mycontroller: name,
                validator: (val) {
                  if (val == '') {
                    return "Can't be empty";
                  }
                },
              ),
              SizedBox(height: 20,),
              CustomButtonAuth(title: 'Add',onPressed: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
