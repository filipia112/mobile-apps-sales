import 'package:apps_sales/presentation/screens/home/home_screen.dart';
import 'package:apps_sales/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/app_string.dart';
import 'data/provider/auth_provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appsSales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _checkAuth(context),
    );
  }

  Widget _checkAuth(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.token != null && authProvider.userId != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}

