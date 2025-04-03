import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myweather/core/bloc/weather/weather_event.dart';
import 'package:myweather/core/bloc/weather/weather_state.dart';
import 'package:myweather/core/services/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitialState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final weather = await weatherService.fetchWeather(event.city);
        emit(WeatherLoadedState(weather));
      } catch (e) {
        emit(WeatherErrorState(e.toString()));
      }
    });

    on<FetchForecastEvent>((event, emit) async {
      emit(ForecastLoadingState());
      try {
        final forecast = await weatherService.fetchForecast(event.city);
        emit(ForecastLoadedState(forecast));
      } catch (e) {
        emit(ForecastErrorState(e.toString()));
      }
    });
  }
}