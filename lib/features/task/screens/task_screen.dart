import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
          'Tugas',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
