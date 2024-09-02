import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  Future<void> register({
     required String email,
     required String password
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
    } on FirebaseAuthException catch (e) {
      String message = ' ';
      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email.";
        case 'wrong-password':
          message = "Wrong password provided for that user.";
        case 'invalid-email':
          message = "The email address is badly formatted.";
        default:
          message = "An error occurred. Please try again.";
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  Future<String> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return "login berhasil";
    } on FirebaseAuthException catch (e) {
      String message = ' ';
      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email.";
        case 'wrong-password':
          message = "Wrong password provided for that user.";
        case 'invalid-email':
          message = "The email address is badly formatted.";
        default:
          message = "An error occurred. Please try again.";
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      return message;
    }
  }

  Future<void> logout({
    required BuildContext context
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
  }

  Future updateProfile(String newFullname, String newNumber) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      'fullname': newFullname,
      'newNumber': newNumber
    });
  }


}
