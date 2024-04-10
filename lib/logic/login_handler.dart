import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:google_sign_in_sample/screen/homescreen.dart';

class LoginProvider extends ChangeNotifier {
  bool _isAnimate = false;
  UserCredential? _userCredential;
  bool get isAnimate => _isAnimate;

  final bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  UserCredential? get userCredential => _userCredential;

  Future<void> animateLogo() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isAnimate = true;
    notifyListeners();
  }

  Future<void> handleGoogleButtonClick(BuildContext context) async {
    try {

      _userCredential = await _signInWithGoogle();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(userCredential: _userCredential!)));

    } catch (e) {
      print('SignInFailed $e');

    }
    notifyListeners();
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('SignInFailed $e');
      throw Exception('SignInFailed $e');
    }
  }
}

class Dialogs {
  static void showProgressbar(BuildContext context) {}
}