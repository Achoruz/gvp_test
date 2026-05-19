import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvp_test/controllers/auth/auth_controller.dart';
import 'package:gvp_test/controllers/home/home_controller.dart';
import 'package:gvp_test/resources/views/home/home_page.dart';
import 'package:gvp_test/resources/views/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isLoggedIn = await AuthController.hasLoggedInSession();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
        Get.put(HomeController(), permanent: true);
      }),
      home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
