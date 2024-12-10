import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_bloc.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_event.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_state.dart';
import 'package:mahasiswa_takumi/features/auth/controllers/email_password.dart';

// ignore: non_constant_identifier_names
void ResetPasswordView(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1B1B1B),
    builder: (context) => BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStatePasswordResetSent && state.successful) {
          Navigator.pop(context);
          context.go('/login');
        }
      },
      builder: (context, state) {
        bool isResetSuccessful =
            state is AuthStatePasswordResetSent && state.successful;

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 5,
                        width: 50,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Masukkan Email anda untuk melakukan reset password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Color(0xFF40919E),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 250,
                                  child: TextFormField(
                                    controller: emailController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'E-mail ID',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: isResetSuccessful
                                              ? Colors.green
                                              : Colors.white,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: isResetSuccessful
                                              ? Colors.green
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Email tidak valid';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isResetSuccessful)
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                'Silahkan cek email anda untuk melakukan reset password',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: MaterialButton(
                          color: const Color(0xFF40919E),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthEventResetPassword(
                                      email: emailController.text,
                                    ),
                                  );
                            }
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
