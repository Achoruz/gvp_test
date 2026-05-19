class CountryModel {
  const CountryModel({
    required this.name,
    required this.capital,
    required this.flagUrl,
  });

  final String name;
  final String capital;
  final String flagUrl;

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final nameJson = json['name'] as Map<String, dynamic>?;
    final capitalJson = json['capital'] as List<dynamic>?;
    final flagsJson = json['flags'] as Map<String, dynamic>?;

    return CountryModel(
      name: nameJson?['common']?.toString() ?? '-',
      capital: capitalJson?.isNotEmpty == true
          ? capitalJson!.first.toString()
          : '-',
      flagUrl:
          flagsJson?['png']?.toString() ?? flagsJson?['svg']?.toString() ?? '',
    );
  }
}
