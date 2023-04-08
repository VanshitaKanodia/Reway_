import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reway/services/google_auth_service.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
//
class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email ="";
    String password = "";

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Image.asset('assets/image/Rewaysamplelogogreen.png',
                    height: 275, width: 275, alignment: Alignment.topCenter),
              ),
              const FaIcon(
                FontAwesomeIcons.circleUser,
                size: 55,
                color: Color.fromARGB(255, 24, 121, 37),
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 50),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                          decoration: const InputDecoration(
                              hintText: 'Username or Email',
                              hintStyle:
                                  TextStyle(fontSize: 15, letterSpacing: 1.2)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 50),
                        child: TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle:
                                  TextStyle(fontSize: 15, letterSpacing: 1.2)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                  password: password
                              );
                              Navigator.pushNamed(context, '/home');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'LOG IN',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                await signiInWithGoogle();
                                Navigator.pushNamed(context, '/home');
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  fixedSize: const Size(60, 60)),
                              child: Image.network(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Text('or'),
                            const SizedBox(
                              width: 40,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/login_with_mobile');
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                fixedSize: const Size(60, 60),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.mobileScreenButton,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 113, 113, 113)),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pushNamed(context, '/second');
                              },
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 29, 93, 158))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


