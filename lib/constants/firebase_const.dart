import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
User? currentuser = auth.currentUser;

var usercollection = "Users";
var recyclersCollection = "Recyclers";
