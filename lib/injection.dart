import 'package:get_it/get_it.dart';
import 'package:tesproix/cubit/activity/activity_cubit.dart';
import 'package:tesproix/repository/activity/activity_repository.dart';
import 'package:tesproix/repository/activity/base_activity_repository.dart';
import 'package:tesproix/usecase/get_activity.dart';

final locator = GetIt.instance;

void initialize() {
  //cubit or bloc
  locator.registerFactory(() => ActivityCubit(locator()));

  //use case
  locator.registerFactory(() => GetActivity(repository: locator()));

  //repository
  locator.registerLazySingleton<BaseActivityRepository>(
    () => ActivityRepository(),
  );
}
