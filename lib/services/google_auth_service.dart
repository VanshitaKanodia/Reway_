import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



//Determine if the user is authenticated.
// handleAuthState() {
//   return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.hasData) {
//           return _handleSignIn();
//           //   Scaffold(
//           //   body: Container(
//           //     color: Colors.white,
//           //     width: MediaQuery.of(context).size.width,
//           //     child: Column(
//           //       mainAxisAlignment: MainAxisAlignment.center,
//           //       children: <Widget>[
//           //         Text(
//           //           FirebaseAuth.instance.currentUser!.displayName!,
//           //           style: const TextStyle(
//           //               fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
//           //         ),
//           //         const SizedBox(
//           //           height: 10,
//           //         ),
//           //         Text(
//           //           FirebaseAuth.instance.currentUser!.email!,
//           //           style: const TextStyle(
//           //               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//           //         ),
//           //         const SizedBox(
//           //           height: 30,
//           //         ),
//           //         MaterialButton(
//           //           padding: const EdgeInsets.all(10),
//           //           color: Colors.green,
//           //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//           //           child: const Text(
//           //             'LOG OUT',
//           //             style: TextStyle(color: Colors.white, fontSize: 15),
//           //           ),
//           //           onPressed: () {
//           //             signOut();
//           //           },
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // );
//         } else {
//           return const LoginScreen();
//         }
//       }
//       );
// }


final GoogleSignIn googleUser = GoogleSignIn(
scopes: <String>["email"]);


signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"]).signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}






//Sign out
signOut() async {
  await googleUser.signOut();
  await FirebaseAuth.instance.signOut();
}