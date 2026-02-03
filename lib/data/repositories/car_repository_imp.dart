import 'package:flutter_application_1/data/models/car.dart';
import 'package:flutter_application_1/data/datasource/firebase_data_car_source.dart';
import 'package:flutter_application_1/domain/repositories/car_repository.dart';

class CarRepositoryImp implements CarRepository {
  final FirebaseDataCarSource dataSource;
  CarRepositoryImp(this.dataSource);

  @override
  Future<List<Car>> getCars() {
    return dataSource.getCars();
  }
}
