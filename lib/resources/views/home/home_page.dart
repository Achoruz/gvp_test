import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvp_test/controllers/auth/auth_controller.dart';
import 'package:gvp_test/controllers/home/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country List'),
        actions: [
          IconButton(
            onPressed: homeController.fetchCountries,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: authController.logout,
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final name = authController.username.value.isEmpty
                      ? 'User'
                      : authController.username.value;

                  return Text(
                    'Selamat datang, $name',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (homeController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          homeController.errorMessage.value,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: homeController.fetchCountries,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Coba lagi'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (homeController.countries.isEmpty) {
                return const Center(child: Text('Data negara kosong'));
              }

              return RefreshIndicator(
                onRefresh: homeController.fetchCountries,

                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: homeController.countries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final country = homeController.countries[index];

                    return Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: country.flagUrl.isEmpty
                              ? const SizedBox(
                                  width: 48,
                                  height: 32,
                                  child: Icon(Icons.flag_outlined),
                                )
                              : Image.network(
                                  country.flagUrl,
                                  width: 48,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      const Icon(Icons.flag_outlined),
                                ),
                        ),
                        title: Text(country.name),
                        subtitle: Text('Ibukota: ${country.capital}'),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
