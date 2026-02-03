import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/data/datasource/firebase_data_car_source.dart';
import 'package:flutter_application_1/data/repositories/car_repository_imp.dart';
import 'package:flutter_application_1/domain/repositories/car_repository.dart';
import 'package:flutter_application_1/domain/usecases/get_cars.dart';
import 'package:flutter_application_1/presentation/bloc/car_bloc.dart';

GetIt getIt = GetIt.instance;

void initInjection() {
  try {
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    getIt.registerLazySingleton<FirebaseDataCarSource>(
      () => FirebaseDataCarSource(firestore: getIt<FirebaseFirestore>()),
    );
    getIt.registerLazySingleton<CarRepository>(
      () => CarRepositoryImp(getIt<FirebaseDataCarSource>()),
    );
    getIt.registerLazySingleton<GetCars>(
      () => GetCars(carRepository: getIt<CarRepository>()),
    );
    getIt.registerFactory(() => CarBloc(getCars: getIt<GetCars>()));
  } catch (e) {
    throw e;
  }
}
