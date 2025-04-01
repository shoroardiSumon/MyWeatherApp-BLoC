import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myweather/core/bloc/theme/theme_bloc.dart';
import 'package:myweather/core/bloc/theme/theme_event.dart';
import 'package:myweather/core/bloc/weather/weather_bloc.dart';
import 'package:myweather/core/bloc/weather/weather_event.dart';
import 'package:myweather/core/bloc/weather/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "Enter City Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a city name";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<WeatherBloc>().add(
                    FetchWeatherEvent(cityController.text.trim()),
                  );
                }
              },
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoadedState) {
                  return Column(
                    children: [
                      Text(state.weather.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("${(state.weather.main.temp - 273.15).toStringAsFixed(1)}°C", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      Text(state.weather.weather.first.description.toUpperCase(), style: const TextStyle(fontSize: 18)),
                    ],
                  );
                } else if (state is WeatherErrorState) {
                  return Text(state.message, style: const TextStyle(color: Colors.red));
                }
                return const Text("Enter a city to get the weather.");
              },
            ),
          ],
        ),
      ),
    );
  }
}