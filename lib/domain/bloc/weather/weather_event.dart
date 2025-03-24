part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class UpdateWeatherData extends WeatherEvent {
  final double lon;
  final double lat;

  UpdateWeatherData({required this.lon, required this.lat});
}
