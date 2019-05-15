import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';


import 'package:flutter_weather/repositories/repositories.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_weather/widgets/widgets.dart';
import 'package:flutter_weather/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(weatherApiClient: WeatherApiClient(httpClient: http.Client()));

  runApp(MyApp(weatherRepository: weatherRepository,));
}

class MyApp extends StatefulWidget {

  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      :assert(weatherRepository != null),
        super(key: key);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {

  ThemeBloc _themeBloc = ThemeBloc();
  SettingsBloc _settingsBloc = SettingsBloc();


  @override
  Widget build(BuildContext context) {
    
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(bloc: _themeBloc,),
        BlocProvider<SettingsBloc>(bloc: _settingsBloc,),
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder:(_, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter Weather',
            theme: themeState.theme,
            home: Weather(
              weatherRepository: widget.weatherRepository,
            ),
          );
        }
      )
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingsBloc.dispose();
    super.dispose();
  }
}