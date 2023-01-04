import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/weights_model.dart';
import '../../../../viewmodel/details_screen_view_model.dart';
import 'weight_operations.dart';

class ItemRow extends StatelessWidget {
  final WeightsModel weights;
  final String id;
  final DetailsScreenViewModel model;
  const ItemRow(
      {Key? key, required this.weights, required this.id, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weights.value.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    DateFormat.MMMEd().add_jm().format(
                        DateTime.fromMillisecondsSinceEpoch(weights.time)),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      WeightOperations.editWeight(context, model, id);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      elevation: 0,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      WeightOperations.deleteWeight(context, model, id);
                    },
                    child: Icon(
                      Icons.delete_forever_rounded,
                      size: 22,
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.grey,
                      shape: CircleBorder(),
                      elevation: 0,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
