import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_string.dart';
import '../../common/constants.dart';
import '../../data/provider/auth_provider.dart';
import 'login_screen.dart';
import 'package:intl/intl.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      if (mounted) {
        await Provider.of<AuthProvider>(context, listen: false).loadUserData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal memuat data pengguna"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.token == null) {
      return const Center(
        child: Text("Menunggu token..."),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            color: kPrimaryBlue,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.itemNameMenu4,
                        style: kHeading5.copyWith(
                          fontSize: 20,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: authProvider.nmUser != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nama Pengguna:",
                      style: kBodyText.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      authProvider.nmUser!,
                      style: kBodyText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Username:",
                      style: kBodyText.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      authProvider.username!,
                      style: kBodyText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Role:",
                      style: kBodyText.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      authProvider.roleUser!,
                      style: kBodyText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terakhir Login:",
                      style: kBodyText.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          authProvider.updatedAt != null
                              ? DateFormat.jm().format(authProvider.updatedAt!.toLocal())
                              : "Tidak ada data",
                          style: kBodyText.copyWith(fontSize: 16),
                        ),
                        Text(
                          authProvider.updatedAt != null
                              ? DateFormat("dd/MM/yyyy").format(authProvider.updatedAt!.toLocal())
                              : "Tidak ada data",
                          style: kBodyText.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 160),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          'Keluar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await Provider.of<AuthProvider>(context, listen: false).logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
                : Container(),
          )
        ],
      ),
    );
  }


}


