import 'package:myweather/core/models/weather_model.dart';
import 'package:myweather/core/services/base_service.dart';

class WeatherService {
  final BaseService baseService;
  final String apiKey = "d4385693614f266580202d9948a2b54d";

  WeatherService(this.baseService);

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await baseService.get("weather", queryParameters: {"q": city, "appid": apiKey});
    if (response.statusCode != 200) {
      throw response.data['message'] ?? "Error fetching weather data";
    }
    return WeatherModel.fromJson(response.data);
  }
}