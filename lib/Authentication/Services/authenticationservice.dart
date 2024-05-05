import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import "package:flutter/material.dart";


class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 

  final CollectionReference usercollect =
      FirebaseFirestore.instance.collection("User");

  
  Future<void> signinwithEmail(
      {required context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("signed in");
      

    } catch (e) {
      rethrow;
    }
  }

  Future <void>  signupwithEmail(
      {required context,
      required String email,
      required String password,
      }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);
      try {
        final uid = _auth.currentUser!.uid;
        await usercollect.doc(uid).set({'Email':email
        });
      } catch (e) {
        print(e);
      }

      print("signed up");
    } catch (e) {
      rethrow;
    }
  }

  Future <void> siginOut() async {
    await _auth.signOut();
   
  }

  Future <void>  passwordReset({required context, required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }
 
}
