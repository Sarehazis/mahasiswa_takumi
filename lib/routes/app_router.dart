// import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mahasiswa_takumi/features/auth/screens/login_screen.dart';
import 'package:mahasiswa_takumi/features/auth/screens/register_screen.dart';
import 'package:mahasiswa_takumi/features/home/screens/home_screen.dart';
import 'package:mahasiswa_takumi/features/home/screens/notification.dart';
import 'package:mahasiswa_takumi/features/onboarding/screens/onboarding_screen.dart';
import 'package:mahasiswa_takumi/features/profile/screens/profile_screen.dart';
import 'package:mahasiswa_takumi/features/settings/screens/setting_screen.dart';
import 'package:mahasiswa_takumi/features/splash/splash_screen.dart';
import 'package:mahasiswa_takumi/features/task/screens/task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreens(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return const LoginScreens();
        }
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return const LoginScreens();
        }
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: '/notification',
      name: 'notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/task',
      name: 'task',
      builder: (context, state) => const TaskScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingScreen(),
    ),
  ],
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final user = FirebaseAuth.instance.currentUser;

    if (state.uri.toString() == '/') {
      if (user != null) {
        return '/home';
      }
      if (isFirstTime) {
        return '/onboarding';
      } else {
        return '/login';
      }
    }

    return null;
  },
);
