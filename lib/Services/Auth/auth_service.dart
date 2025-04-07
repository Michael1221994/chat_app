import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {

  //instance of auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in
  Future<UserCredential> signinwithEmailandPassword(String email, String password) async {
    try{
      //sign user in 
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //save user info if it doesn't already exist
      _firestore.collection("users").doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid,
         'email': email,
        },);


      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signupwithEmailandPassword(String email, String password) async {
      try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    

    //save user info in a separate document
      _firestore.collection("users").doc(userCredential.user!.uid).set(
        {
         'uid': userCredential.user!.uid,
         'email': email,
        },);

      return userCredential;
      } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
        

  }

  //sign out
  void  signout() async {
    try{
     await _auth.signOut();
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  
  }
  //errors
}