import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myweather/core/bloc/theme/theme_bloc.dart';
import 'package:myweather/core/bloc/weather/weather_bloc.dart';
import 'package:myweather/core/services/base_service.dart';
import 'package:myweather/core/services/weather_service.dart';
import 'package:myweather/ui/screens/weather_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(WeatherService(BaseService())),
      ),
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const WeatherScreen(),
        );
      },
    );
  }
}
