import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../provider/base_model.dart';

class HomeScreenViewModel extends BaseModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController addweightController = TextEditingController();
  int selectedIndex = 0;
  final PageController pageController = PageController();

  void save() {
    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      db.collection('weights').doc(uid).collection("userWeights").add({
        'value': addweightController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        'docId': db
            .collection('weights')
            .doc(uid)
            .collection("userWeights")
            .doc()
            .id,
      });
    }
    addweightController.clear();
  }
}
