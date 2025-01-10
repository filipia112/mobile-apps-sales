import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_string.dart';
import '../../common/constants.dart';
import '../../data/model/auth_model.dart';
import '../../data/provider/auth_provider.dart';

import '../widgets/widget_loading.dart';
import 'home/home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _isPasswordVisible = false;
  Future<void> _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar(
        'Username dan Password tidak boleh kosong.',
        Colors.red,
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    final authModel = AuthModel(username: username, passUser: password);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(authModel);

      if (success) {
        final token = authProvider.token;
        final userId = authProvider.userId;

        if (token != null && userId != null && mounted) {
          _showSnackBar('Login Berhasil', Colors.green);
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        final errorMessage = authProvider.errorMessage ?? 'Terjadi kesalahan. Coba lagi.';
        _showSnackBar(errorMessage, Colors.red);
      }
    } catch (e) {
      _showSnackBar(
        'Kesalahan tak terduga: $e',
        Colors.red,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }

  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildOverlay(),
          _buildContent(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/bangunan-PAM.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.textLogin,
              style: kHeading5.copyWith(
                fontSize: 28,
                color: kWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: AppString.textUsername,
                hintStyle: kSubtitle.copyWith(color: Colors.black38),
                prefixIcon: const Icon(Icons.account_circle_rounded, color: kPrimaryBlue),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kLightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimaryBlue),
                ),
                fillColor: kWhite.withOpacity(0.6),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              cursorColor: kPrimaryBlue,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: AppString.textPassword,
                hintStyle: kSubtitle.copyWith(color: Colors.black38),
                prefixIcon: const Icon(Icons.lock, color: kPrimaryBlue),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kLightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimaryBlue),
                ),
                fillColor: kWhite.withOpacity(0.6),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              cursorColor: kPrimaryBlue,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const LoadingWidget()
                : ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 1,
                  60,
                ),
                backgroundColor: kPrimaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: kPrimaryBlue, width: 2),
                ),
              ),
              child: Text(
                AppString.textLogin,
                style: kHeading6.copyWith(
                  fontSize: 18,
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFooter(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppString.pt,
            style: kHeading5.copyWith(
              fontSize: 14,
              color: kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
