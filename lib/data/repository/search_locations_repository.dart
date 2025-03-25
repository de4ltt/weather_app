import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/data/model/locations/location.dart';
import 'package:weather_app/data/util/api_routes.dart';
import 'package:weather_app/domain/repository/i_search_locations_repository.dart';

class SearchLocationsRepository implements ISearchLocationsRepository {
  final Dio _dio;

  SearchLocationsRepository({required Dio dio}) : _dio = dio;

  @override
  Future<List<Location>> getLocations(final String query) async {
    final String route = APIRoutes.locations;
    final String appID = dotenv.get("LOCATIONS_API_KEY");

    final response = await _dio.get(
      route,
      queryParameters: {
        'q': query,
        'type': 'like',
        'sort': 'population',
        'cnt': 30,
        'units': 'metric',
        'appid': appID,
      },
    );

    final Map<String, dynamic> result = response.data;

    final List<Location> locations =
        result['list']
            .map<Location>((element) => Location.fromJson(element))
            .toList();

    return locations;
  }
}
