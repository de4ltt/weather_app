import 'package:weather_app/data/model/weather/future_days_weather.dart';

import '../../data/model/weather/today_weather.dart';
import '../../data/model/weather/future_hours_weather.dart';

abstract interface class IWeatherRepository {
  Future<FutureHoursWeather> getFutureHoursForecast(double lat, double lon);
  Future<TodayWeather> getTodayForecast(double lat, double lon);
}