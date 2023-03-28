// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/google_auth_service.dart';

class LoginWithMobile extends StatelessWidget {
  const LoginWithMobile({super.key});

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
                FontAwesomeIcons.mobileScreen,
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
                      SizedBox(
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 50),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                              hintText: 'Mobile No.',
                              hintStyle:
                                  TextStyle(fontSize: 15, letterSpacing: 1.2)),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 20, horizontal: 50),
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.number,
                      //     obscureText: false,
                      //     obscuringCharacter: '*',
                      //     style: const TextStyle(
                      //       fontSize: 17,
                      //     ),
                      //     decoration: const InputDecoration(
                      //         hintText: 'OTP',
                      //         hintStyle:
                      //             TextStyle(fontSize: 15, letterSpacing: 1.2)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/otp_verification_screen');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Send OTP',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              signInWithGoogle();
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
                              Navigator.pushNamed(context, '/');
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              fixedSize: const Size(60, 60),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.circleUser,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 113, 113, 113)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/second');
                            },
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 29, 93, 158))),
                          ),
                        ],
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
