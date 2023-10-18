import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/app_routes.dart';
import 'package:notes/controller/auth/sign_up_controller.dart';

import '../../widgets/custom_button_auth.dart';
import '../../widgets/custom_logo_auth.dart';
import '../../widgets/custom_text_form.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 30),
              const CustomLogoAuth(),
              Container(height: 20),
              const Text("SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("SignUp To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your username",
                  mycontroller: controller.name),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: controller.email),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: controller.password),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButtonAuth(
              title: "SignUp",
              onPressed: () {
                controller.createAccountWithEmailAndPassword();
              }),
          const SizedBox(
            height: 20,
          ),

          //Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Get.toNamed(AppRoute.login);
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 87, 173, 244),
                        fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
