import 'package:gvp_test/models/country_model/country_model.dart';
import 'package:gvp_test/services/dio_service/dio_service.dart';

class CountryRepository {
  final DioService _dioService = DioService();

  Future<List<CountryModel>> getCountries() async {
    final response = await _dioService.get<List<dynamic>>(
      '/all',
      queryParameters: {'fields': 'name,capital,currencies,flags'},
    );

    final data = response.data ?? [];

    return data
        .whereType<Map<String, dynamic>>()
        .map(CountryModel.fromJson)
        .toList();
  }
}
