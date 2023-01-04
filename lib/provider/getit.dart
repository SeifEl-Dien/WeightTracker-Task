import 'package:get_it/get_it.dart';

import '../service/navigation_service.dart';
import '../viewmodel/auth_screen_view_model.dart';
import '../viewmodel/details_screen_view_model.dart';
import '../viewmodel/home_screen_view_model.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => DetailsScreenViewModel());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => AuthScreenViewModel());
}
