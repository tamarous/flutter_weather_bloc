
import 'package:flutter_weather/blocs/blocs.dart';
import 'package:bloc/bloc.dart';


class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState => SettingsState(temperatureUnits: TemperatureUnits.celsius);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is TemperatureUnitsToggled) {
      yield SettingsState(
        temperatureUnits:
          currentState.temperatureUnits == TemperatureUnits.celsius ? TemperatureUnits.fahrenheit:TemperatureUnits.celsius,
      );
    }
  }
}

