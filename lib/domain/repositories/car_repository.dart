import 'package:flutter_application_1/data/models/car.dart';

abstract class CarRepository {
  Future<List<Car>> getCars();
}
