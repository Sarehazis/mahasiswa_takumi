import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_event.dart';
import 'package:mahasiswa_takumi/features/auth/bloc/auth_state.dart';
import 'package:mahasiswa_takumi/features/auth/data/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(const AuthStateLoggedOut(
            isLoading: false, successful: false, errorMessage: "")) {
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
          isLoading: true, successful: false, errorMessage: ""));
      try {
        final userCredential = await Auth().signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // Mengambil username dari Firestore
        final userData = await Auth().getUserData(userCredential.user!.uid);
        final username = userData['username'] ?? 'User';

        emit(AuthStateLoggedIn(
          isLoading: false,
          successful: true,
          userName: username,
        ));
      } on FirebaseAuthException catch (e) {
        String errorMessage = "Login Gagal, Silakan periksa kembali.";

        if (e.code == 'wrong-password') {
          errorMessage = "Password yang dimasukkan salah. Silakan coba lagi.";
        } else if (e.code == 'user-not-found') {
          errorMessage = "User tidak ditemukan. Silakan coba lagi.";
        }

        emit(AuthStateLoggedOut(
          isLoading: false,
          successful: false,
          errorMessage: errorMessage,
        ));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      emit(const AuthStateLoggedOut(
          isLoading: true, successful: false, errorMessage: ""));
      try {
        await Auth().signOut();
        emit(const AuthStateLoggedOut(
            isLoading: false, successful: true, errorMessage: ""));
      } catch (e) {
        emit(const AuthStateLoggedOut(
            isLoading: false,
            successful: false,
            errorMessage: "Failed to logout."));
      }
    });

    // Menambahkan event untuk reset password
    on<AuthEventResetPassword>((event, emit) async {
      emit(const AuthStateLoggedOut(
          isLoading: true, successful: false, errorMessage: ""));
      try {
        await Auth().sendResetPasswordEmail(email: event.email);
        emit(AuthStateLoggedOut(
          isLoading: false,
          successful: true,
          errorMessage: "Reset password email sent successfully.",
        ));
      } catch (e) {
        emit(AuthStateLoggedOut(
          isLoading: false,
          successful: false,
          errorMessage: "Failed to send reset password email.",
        ));
      }
    });
  }
}
