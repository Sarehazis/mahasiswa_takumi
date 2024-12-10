import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_bloc.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_event.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool visiblePassword = true;
  bool visibleConfirmPassword = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Jika user sudah login, navigasi ke halaman /home
        if (state is AuthStateLoggedIn) {
          context.go('/home');
          return Container();
        }

        // Jika user logout, reset controller dan tampilkan halaman register
        if (state is AuthStateLoggedOut) {
          // Reset nilai controller saat logout
          usernameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();

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
                        'Register',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Silahkan daftar untuk melanjutkan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Nama Lengkap",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nama Lengkap',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: const Icon(Icons.person,
                              color: Color(0xFF40919E)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF40919E)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                          hintText: 'Masukkan E-mail',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon:
                              const Icon(Icons.email, color: Color(0xFF40919E)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF40919E)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                          hintText: 'Masukkan Password',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xFF40919E)),
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
                            borderSide:
                                const BorderSide(color: Color(0xFF40919E)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: visibleConfirmPassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password Kembali',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xFF40919E)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              visibleConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFF40919E),
                            ),
                            onPressed: () {
                              setState(() {
                                visibleConfirmPassword =
                                    !visibleConfirmPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF40919E)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validasi dan pemanggilan event BLoC
                                  if (usernameController.text.isEmpty ||
                                      emailController.text.isEmpty ||
                                      passwordController.text.isEmpty ||
                                      confirmPasswordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("All fields are required!"),
                                      ),
                                    );
                                    return;
                                  }
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Passwords do not match!"),
                                      ),
                                    );
                                    return;
                                  }
                                  context.read<AuthBloc>().add(
                                        AuthEventRegister(
                                          username: usernameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text,
                                          confirm_password: '',
                                        ),
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF40919E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: const Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                            color: Color(0xFF40919E),
                            fontWeight: FontWeight.bold,
                          ),
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
