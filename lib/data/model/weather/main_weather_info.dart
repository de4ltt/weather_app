final class MainWeatherInfo {
  final double temp;

  factory MainWeatherInfo.fromJson(Map<String, dynamic> json) =>
      MainWeatherInfo(temp: json['temp'].toDouble());

  MainWeatherInfo get metric => MainWeatherInfo(temp: temp - 273);
  MainWeatherInfo get kelvin => MainWeatherInfo(temp: temp + 273);

  Map<String, dynamic> toJson() => {
    'temp': temp
  };

  const MainWeatherInfo({required this.temp});
}
