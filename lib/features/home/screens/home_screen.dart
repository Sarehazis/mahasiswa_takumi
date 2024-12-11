import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_bloc.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_state.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getWaktuSekarang() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Pagi';
    } else if (hour >= 12 && hour < 16) {
      return 'Siang';
    } else if (hour >= 16 && hour < 18) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut && !state.isLoading) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1B1B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B1B1B),
          elevation: 0,
          title: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String userName = 'User';
              if (state is AuthStateLoggedIn) {
                userName = state.userName;
              }

              String timeOfDayGreeting = _getWaktuSekarang();
              return Text(
                'Selamat $timeOfDayGreeting, $userName',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              );
            },
          ),
          actions: [
            Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  context.go('/profile');
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                  radius: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                context.go('/notification');
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Mahasiswa Takumi',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'UI/UX Designer',
                          dropdownColor: Colors.grey[850],
                          style: const TextStyle(color: Colors.white),
                          items: const [
                            DropdownMenuItem(
                              value: 'UI/UX Designer',
                              child: Text('UI/UX Designer'),
                            ),
                            DropdownMenuItem(
                              value: 'Developer',
                              child: Text('Developer'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/task');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40919E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/settings');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40919E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.settings, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildTaskCard(
                      title: 'Morning Standup With Team',
                      time: '09:30 - 09:50 AM',
                      participants: [
                        'assets/images/user1.jpeg',
                        'assets/images/user2.jpeg'
                      ],
                    ),
                    _buildNoteCard(
                      title: 'Design Handoff to Developers',
                    ),
                    _buildQuickActionCard(
                      icon: Icons.email,
                      notifications: 8,
                    ),
                    _buildQuickActionCard(
                      icon: Icons.video_call,
                      notifications: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF40919E),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String time,
    required List<String> participants,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: participants
                .map((imagePath) => CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage(imagePath),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard({required String title}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
      {required IconData icon, required int notifications}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 36, color: Colors.black),
        ),
        if (notifications > 0)
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                '$notifications',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
