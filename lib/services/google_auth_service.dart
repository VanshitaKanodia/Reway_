import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleUser = GoogleSignIn(scopes: <String>["email"]);

final GoogleSignIn _googleSignIn = GoogleSignIn();

//Sign out
signOut() async {
  await googleUser.signOut();
  await FirebaseAuth.instance.signOut();
}

Future<void> signInWithGoogle(
    BuildContext context, VoidCallback onSuccess) async {
  try {
    // "trying");
    log('starting google accounting choosing');
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    log('[account choosing done]');
    if (googleUser == null) {
      log('[user didnt choose an account]');
      // User canceled the sign-in process
      return;
    }
    // Use the `googleUser` object to access the user's name and email
    final String name = googleUser.displayName ?? '';
    final String email = googleUser.email;
    log('[username]: $name');
    log('[user-email]: $email');

    // Use the `googleUser` object to obtain an authentication token
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Use the authentication token to sign in to Firebase
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    log('[credentials]: $credential');
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      if (userCredential.additionalUserInfo!.isNewUser) {
        // postDetailsToFirestore()
        onSuccess.call();
      }
      // navigate to home
      onSuccess.call();
    }
    // Navigate to the next screen after the sign-in process is complete
  } on FirebaseAuthException catch (e) {
    log(e.message!); // Displaying the error message
  }
}
