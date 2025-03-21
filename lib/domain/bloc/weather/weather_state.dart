part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherRetrieved extends WeatherState {
  final TodayWeather todayWeather;
  final FutureHoursWeather futureHoursWeather;
  final List<FutureDaysWeather> futureDaysWeather;

  WeatherRetrieved({
    required this.futureHoursWeather,
    required this.todayWeather,
    required this.futureDaysWeather,
  });
}

final class WeatherNetworkError extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherUnset extends WeatherState {}
