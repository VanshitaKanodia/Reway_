import 'package:flutter/material.dart';
import 'package:reway/services/google_auth_service.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: handleAuthState(),
    );
  }
}
