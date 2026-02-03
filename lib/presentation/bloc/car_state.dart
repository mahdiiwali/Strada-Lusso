import 'package:flutter_application_1/data/models/car.dart';

abstract class CarState {}

class CarLoadingState extends CarState {}

class CarLoadedState extends CarState {
  final List<Car> cars;
  CarLoadedState({required this.cars});
}

class CarErrorState extends CarState {
  final String message;
  CarErrorState({required this.message});
}
