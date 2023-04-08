import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


final GoogleSignIn googleUser = GoogleSignIn(
scopes: <String>["email"]);

final GoogleSignIn _googleSignIn = GoogleSignIn();

//Sign out
signOut() async {
  await googleUser.signOut();
  await FirebaseAuth.instance.signOut();
}

// final GoogleSignIn _googleSignIn = GoogleSignIn();

signiInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User canceled the sign-in process
      return;
    }
    // Use the `googleUser` object to access the user's name and email
    final String name = googleUser.displayName ?? '';
    final String email = googleUser.email;

    // Use the `googleUser` object to obtain an authentication token
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Use the authentication token to sign in to Firebase
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Navigate to the next screen after the sign-in process is complete
    // Navigator.pushNamed(context, '/home');
  } catch (e) {
    // Handle sign-in errors here
    print('Failed to sign in with Google: $e');
  }
}