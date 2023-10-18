import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/routes.dart';
import 'package:notes/view/screens/add_folder.dart';
import 'package:notes/view/screens/auth/login.dart';
import 'package:notes/view/screens/auth/signup.dart';
import 'package:notes/view/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 87, 173, 244),
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 87, 173, 244)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.grey[50])
      ),
      getPages: routes, 
      home: (FirebaseAuth.instance.currentUser != null )? HomePage() : Login(),
    );
  }
}
