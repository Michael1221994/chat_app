import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Services/Auth/login_or_register.dart';
import 'package:minimal_chat_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){

            //user is logged in
            if(snapshot.hasData){
              return  HomePage();
            }

            //if the user is not logged in
            else{
              return const LoginOrRegister();
            }
          },
        ),
    );
  }
}