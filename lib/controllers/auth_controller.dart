import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvp_test/models/user_model.dart';
import 'package:gvp_test/views/home_page.dart';
import 'package:gvp_test/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isLoggedInKey = 'is_logged_in';
const _usernameKey = 'username';
const _passwordKey = 'password';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final username = ''.obs;

  // return login state dari SharedPreferences
  static Future<bool> hasLoggedInSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  @override
  void onInit() {
    super.onInit();
    loadUsername();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // load username ketika membuka ulang aplikasi
  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString(_usernameKey) ?? '';
  }

  // login lalu menyimpan data login ke SharedPreferences
  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    final user = UserModel(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_usernameKey, user.username);
    await prefs.setString(_passwordKey, user.password);

    username.value = user.username;
    isLoading.value = false;

    Get.offAll(() => const HomePage());
  }

  // logout menghapus data login di SharedPreferences
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);

    usernameController.clear();
    passwordController.clear();
    username.value = '';

    Get.offAll(() => const LoginPage());
  }
}
