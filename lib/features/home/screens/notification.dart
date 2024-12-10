import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          'Notifikasi',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
