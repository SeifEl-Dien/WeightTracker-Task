import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../provider/base_model.dart';

class AuthScreenViewModel extends BaseModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = 'An error occured please check your credentials!';
  String userEmail = '';
  String userName = '';
  String userPassword = '';
  var isLogin = false;
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();

  changePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  changeLoginType() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<bool> trySubmit(BuildContext context) async {
    bool _isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      formKey.currentState!.save();
      return submitAuthForm(
        userEmail.trim(),
        userPassword.trim(),
        userName.trim(),
        isLogin,
        context,
      );
    }
    return false;
  }

  Future<bool> submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential currentuser;
    try {
      if (isLogin) {
        currentuser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        Fluttertoast.showToast(msg: 'Welcome back !');
        return true;
      } else {
        currentuser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentuser.user!.uid)
            .set({
          'name': username,
          'email': email,
        });

        Fluttertoast.showToast(msg: 'Welcome $username!');
        return true;
      }
    } catch (err) {
      errormessage = err.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errormessage),
          action: SnackBarAction(
            onPressed: () {},
            label: 'undo',
          ),
          backgroundColor: Colors.black,
        ),
      );
      return false;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
