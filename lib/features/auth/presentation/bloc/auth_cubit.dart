import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laghiny_chat/features/auth/presentation/bloc/auth_state.dart';
import 'package:laghiny_chat/features/auth/presentation/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._authRepository,
  ) : super(AuthState());

  final AuthRepo _authRepository;

  Future<void> init() async {
    final user = await _authRepository.getUser();
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.loggedIn, user: () => user));
    } else {
      emit(state.copyWith(status: AuthStatus.loggedOut));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authRepository.login(email, password);

      emit(state.copyWith(status: AuthStatus.loggedIn, user: () => user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }

  Future<void> signup({
    required String fullname,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authRepository.signup(fullname, email, password);

      emit(state.copyWith(status: AuthStatus.loggedIn, user: () => user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();

      emit(state.copyWith(status: AuthStatus.loggedOut));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }
}