import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/repository/i_weather_repository.dart';
import 'package:weather_app/data/model/weather/future_days_weather.dart';
import 'package:weather_app/data/model/weather/today_weather.dart';
import 'package:weather_app/data/model/weather/future_hours_weather.dart';
import '../../../data/model/weather/day_weather.dart';
import 'package:collection/collection.dart' as col show IterableDoubleExtension, groupBy;

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository _weatherRepository;

  WeatherBloc({required IWeatherRepository weatherRepository})
    : _weatherRepository = weatherRepository,
      super(WeatherUnset()) {
    on<UpdateWeatherData>(_onUpdateWeatherData);
  }

  Future<void> _onUpdateWeatherData(
    UpdateWeatherData event,
    Emitter<WeatherState> emit,
  ) async {
    // пока что только Краснодар
    const double lat = 45.034688;
    const double lon = 38.979636;

    try {
      emit(WeatherLoading());

      late final TodayWeather todayWeather;
      late final FutureHoursWeather futureHoursWeather;
      late final List<FutureDaysWeather> futureDaysWeather;

      await Future.wait([
        _weatherRepository
            .getTodayForecast(lat, lon)
            .then((value) => todayWeather = value),
        _weatherRepository
            .getFutureHoursForecast(lat, lon)
            .then((value) => futureHoursWeather = value),
      ]);

      futureDaysWeather = _getFutureDaysWeather(futureHoursWeather);

      final result = WeatherRetrieved(
        todayWeather: todayWeather,
        futureHoursWeather: futureHoursWeather,
        futureDaysWeather: futureDaysWeather,
      );

      emit(result);
    } catch (e) {
      print(e);
      emit(WeatherNetworkError());
    }
  }

  List<FutureDaysWeather> _getFutureDaysWeather(FutureHoursWeather futureHoursWeather) {

    final Map<DateTime, List<DayWeather>> groupedWeather = col.groupBy(
      futureHoursWeather.weather,
          (DayWeather element) =>
          element.dateTime.subtract(Duration(hours: element.dateTime.hour)),
    );

    final result =
    groupedWeather
        .map((DateTime key, List<DayWeather> value) {
      final tempList =
      value
          .map<double>((element) => element.mainWeatherInfo.temp)
          .toList();
      final minTemp = tempList.min.toInt();
      final maxTemp = tempList.max.toInt();
      final weather = value[value.length ~/ 2].weather;

      return MapEntry(
        key,
        FutureDaysWeather(
          minTemp: minTemp,
          maxTemp: maxTemp,
          weather: weather,
          dateTime: key,
        ),
      );
    })
        .values
        .toList();

    return result;
  }
}
