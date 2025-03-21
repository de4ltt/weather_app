final class APIRoutes {

  static const String _baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String _OWMUrl = "https://openweathermap.org/data/2.5";

  static const String today = "$_baseUrl/weather";
  static const String hourly = "$_baseUrl/forecast";
  static const String daily = "$hourly/daily";
  static const String locations = "$_OWMUrl/find";

  const APIRoutes._();
}