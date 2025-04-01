import 'package:equatable/equatable.dart';
import 'package:myweather/core/models/weather_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherState {}
class WeatherLoadingState extends WeatherState {}
class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;

  const WeatherLoadedState(this.weather);
  
  @override
  List<Object?> get props => [weather];
}
class WeatherErrorState extends WeatherState {
  final String message;

  const WeatherErrorState(this.message);

  @override
  List<Object?> get props => [message];
}