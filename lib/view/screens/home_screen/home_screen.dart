import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../provider/base_view.dart';
import '../../../viewmodel/auth_screen_view_model.dart';
import '../../../viewmodel/home_screen_view_model.dart';
import '../auth_screen/auth_screen.dart';
import '../details_screen/components/weight_operations.dart';
import '../details_screen/details_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
        onModelReady: (model) => {},
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Weight Tracker'),
              actions: [
                IconButton(
                    onPressed: () {
                      AuthScreenViewModel().signOut();
                      Fluttertoast.showToast(msg: 'Signout Success');
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    },
                    icon: Icon(Icons.output))
              ],
            ),
            body: DetailsScreen(),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                WeightOperations.addWeight(context, model);
              },
              child: Text(
                'Add Weight',
                style: TextStyle(
                  fontSize: 15,
                  color: ThemeData().scaffoldBackgroundColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.all(10),
              ),
            ),
          );
        });
  }
}
