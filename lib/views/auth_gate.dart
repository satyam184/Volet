import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet/views/dashBoard/dashboard.dart';
import 'package:wallet/views/login_signup_Screen/login_signup.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Dashboard();
          } else {
            return LoginSignup();
          }
        },
      ),
    );
  }
}
