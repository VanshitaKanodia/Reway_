import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       'https://www.citypng.com/public/uploads/small/11639594314mvt074h0zt5cijvfdn7gqxbrya72bzqulyd5bhqhemb5iasfe7gbydmr2jxk8lcclcp6qrgaoiuiavf4sendwc3jvwadddqmli2d.png'),
              //   backgroundColor: Colors.transparent,
              // ),

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
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
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
                              onPressed: () {
                                // signInWithGoogle();
                                _handleSignIn();
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {
                        //         signInWithGoogle();
                        //         // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                        //         // provider.googleLogIn();
                        //         // print('Logged in');
                        //         // Navigator.pushNamed(context, '/home');
                        //       },
                        //       icon: FaIcon(
                        //         FontAwesomeIcons.google,
                        //         size: 50,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 60,
                        //     ),
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: FaIcon(
                        //         FontAwesomeIcons.whatsapp,
                        //         size: 50,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 50,
                        //     ),
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: FaIcon(
                        //         FontAwesomeIcons.instagram,
                        //         size: 50,
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                              onPressed: () {
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
