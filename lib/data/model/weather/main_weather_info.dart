final class MainWeatherInfo {
  final double temp;

  factory MainWeatherInfo.fromJson(Map<String, dynamic> json) =>
      MainWeatherInfo(temp: json['temp'] as double);

  MainWeatherInfo get metric => MainWeatherInfo(temp: temp - 273);

  const MainWeatherInfo({required this.temp});
}
