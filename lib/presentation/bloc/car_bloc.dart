import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/get_cars.dart';
import 'package:flutter_application_1/presentation/bloc/car_event.dart';
import 'package:flutter_application_1/presentation/bloc/car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetCars getCars;

  CarBloc({required this.getCars}) : super(CarLoadingState()) {
    on<LoadCarsEvent>((event, emit) async {
      emit(CarLoadingState());
      try {
        final cars = await getCars.call();
        emit(CarLoadedState(cars: cars));
      } catch (e) {
        emit(CarErrorState(message: e.toString()));
      }
    });
  }
}
