import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1B1B1B),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              context.go('/home');
            },
          ),
          backgroundColor: const Color(0xFF1B1B1B),
          elevation: 0,
          title: const Text(
            'Profil Pengguna',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }
}
