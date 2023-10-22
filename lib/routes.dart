import 'package:get/get.dart';
import 'package:notes/view/screens/add_note.dart';
import 'package:notes/view/screens/all_notes.dart';
import 'package:notes/view/screens/auth/login.dart';
import 'package:notes/view/screens/auth/signup.dart';
import 'package:notes/view/screens/edit_note.dart';
import 'package:notes/view/screens/home_page.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => Login()),
  GetPage(name: '/signup', page: () => SignUp()),
  GetPage(name: '/homepage', page: () => HomePage()),
  GetPage(name: '/allnotes', page: () => AllNotes()),
  GetPage(name: '/addnote', page: () => AddNote()),
   GetPage(name: '/editnote', page: () => EditNote())
];
