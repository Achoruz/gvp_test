import 'package:get/get.dart';
import 'package:gvp_test/models/country_model/country_model.dart';
import 'package:gvp_test/repository/country_repository/country_repository.dart';

class HomeController extends GetxController {
  final CountryRepository _countryRepository = CountryRepository();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final countries = <CountryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      countries.value = await _countryRepository.getCountries();
    } catch (error) {
      errorMessage.value = 'Gagal mengambil data negara';
    } finally {
      isLoading.value = false;
    }
  }
}
