import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_bloc.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_state.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_event.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  bool visiblePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          context.go('/home');
          return Container();
        }

        if (state is AuthStateLoggedOut) {
          return Scaffold(
            backgroundColor: const Color(0xFF1B1B1B),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Insert your E-mail and password to login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Email Input
                      const Text(
                        "E-mail",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter your E-mail',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF40919E),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF40919E),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password Input
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: visiblePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFF40919E),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              visiblePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFF40919E),
                            ),
                            onPressed: () {
                              setState(() {
                                visiblePassword = !visiblePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF40919E),
                            ),
                          ),
                        ),
                      ),
                      // Displaying the error message
                      if (state.errorMessage.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          state.errorMessage, // Show error message here
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                      // Login Button
                      state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(AuthEventLogIn(
                                      email: emailController.text,
                                      password: passwordController.text));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF40919E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          context.go('/register');
                        },
                        child: const Text(
                          "Belum punya akun?",
                          style: TextStyle(color: Color(0xFF40919E)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
