import 'package:flutter_application_1/data/models/car.dart';
import 'package:flutter_application_1/domain/repositories/car_repository.dart';

class GetCars {
  final CarRepository carRepository;

  GetCars({required this.carRepository});

  Future<List<Car>> call() async {
    return await carRepository.getCars();
  }
}
