import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider/base_model.dart';

class DetailsScreenViewModel extends BaseModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController editweightController = TextEditingController();

  void edit({required String docId}) {
    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      FirebaseFirestore.instance
          .collection('weights')
          .doc(uid)
          .collection('userWeights')
          .doc(docId)
          .update({'value': editweightController.text});
    }
    editweightController.clear();
  }

  void delete({required String docId}) {
    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      FirebaseFirestore.instance
          .collection('weights')
          .doc(uid)
          .collection('userWeights')
          .doc(docId)
          .delete();
    }
  }
}
