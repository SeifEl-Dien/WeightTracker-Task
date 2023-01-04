import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/weights_model.dart';
import '../../../provider/base_view.dart';
import '../../../viewmodel/details_screen_view_model.dart';
import 'components/item_row.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details-screen';
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsScreenViewModel>(
        onModelReady: (model) => {},
        builder: (context, model, child) {
          return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 15,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Recent History',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('weights')
                              .doc(model.auth.currentUser?.uid)
                              .collection('userWeights')
                              .orderBy('time', descending: true)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> orderSnapshot) {
                            if (orderSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              final size = orderSnapshot.data!.docs.length;
                              if (size != 0) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: size,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot orderData =
                                        orderSnapshot.data!.docs[index];
                                    String docId = orderData.id;
                                    WeightsModel weights = weightsModelFromJson(
                                        orderData.data()
                                            as Map<String, dynamic>);
                                    return ItemRow(
                                      weights: weights,
                                      id: docId,
                                      model: model,
                                    );
                                  },
                                );
                              } else
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'No Weights added , add some now ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                            }
                          }),
                    ],
                  ),
                ),
              ));
        });
  }
}
