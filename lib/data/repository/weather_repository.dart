import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/data/util/api_routes.dart';
import 'package:weather_app/domain/repository/i_weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/data/model/weather/future_days_weather.dart';
import 'package:weather_app/data/model/weather/today_weather.dart';
import 'package:weather_app/data/model/weather/future_hours_weather.dart';

class WeatherRepository implements IWeatherRepository {
  final Dio _dio;

  WeatherRepository({required Dio dio}) : _dio = dio;

  @override
  Future<TodayWeather> getTodayForecast(double lat, double lon) async {
    final route = APIRoutes.today;
    final appId = dotenv.get("OWM_API_KEY");

    final response = await _dio.get(
      route,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'units': 'metric',
        'appid': appId,
      },
    );

    final Map<String, dynamic> result = response.data;

    return TodayWeather.fromJson(result);
  }

  @override
  Future<FutureHoursWeather> getFutureHoursForecast(
    double lat,
    double lon,
  ) async {
    final route = APIRoutes.hourly;
    final appId = dotenv.get("OWM_API_KEY");

    final response = await _dio.get(
      route,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'units': 'metric',
        'cnt': 40,
        'appid': appId,
      },
    );

    final Map<String, dynamic> result = response.data;

    final FutureHoursWeather weatherList = FutureHoursWeather.fromJson(result);

    return weatherList;
  }
}
