import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather/models/models.dart';


abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]):super(props);
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  WeatherChanged({@required this.condition}):assert(condition != null),super([condition]);
}