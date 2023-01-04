import 'package:flutter/material.dart';
import 'getit.dart';

import '../service/enum/view_state.dart';
import '../service/navigation_service.dart';

class BaseModel extends ChangeNotifier {
  final navigationService = getIt<NavigationService>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
