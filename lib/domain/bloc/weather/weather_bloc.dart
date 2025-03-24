import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/repository/i_weather_repository.dart';
import 'package:weather_app/data/model/weather/future_days_weather.dart';
import 'package:weather_app/data/model/weather/today_weather.dart';
import 'package:weather_app/data/model/weather/future_hours_weather.dart';
import '../../../data/model/weather/day_weather.dart';
import 'package:collection/collection.dart'
    as col
    show IterableDoubleExtension, groupBy;

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
    try {
      emit(WeatherLoading());

      late final TodayWeather todayWeather;
      late final FutureHoursWeather futureHoursWeather;
      late final List<FutureDaysWeather> futureDaysWeather;

      final forecasts = await Future.wait([
        _getTodayForecast(event.lat, event.lon),
        _getFutureHoursForecast(event.lat, event.lon),
      ]);

      todayWeather = forecasts.first as TodayWeather;
      futureHoursWeather = forecasts.last as FutureHoursWeather;
      futureDaysWeather = _getFutureDaysWeather(futureHoursWeather);

      final result = WeatherRetrieved(
        todayWeather: todayWeather,
        futureHoursWeather: futureHoursWeather,
        futureDaysWeather: futureDaysWeather,
      );

      emit(result);
    } catch (e) {
      emit(WeatherNetworkError());
    }
  }

  Future<TodayWeather> _getTodayForecast(
    final double lat,
    final double lon,
  ) async => await _weatherRepository.getTodayForecast(lat, lon);

  Future<FutureHoursWeather> _getFutureHoursForecast(
    final double lat,
    final double lon,
  ) async => await _weatherRepository.getFutureHoursForecast(lat, lon);

  List<FutureDaysWeather> _getFutureDaysWeather(
    FutureHoursWeather futureHoursWeather,
  ) {
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
                      .map<double>(
                        (element) => element.mainWeatherInfo.temp.toDouble(),
                      )
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
