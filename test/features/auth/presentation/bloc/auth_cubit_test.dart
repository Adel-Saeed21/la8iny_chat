import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laghiny_chat/features/auth/data/models/user_model.dart';
import 'package:laghiny_chat/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:laghiny_chat/features/auth/presentation/bloc/auth_state.dart';
import 'package:laghiny_chat/features/auth/presentation/repo/auth_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo mockAuthRepo;
  late AuthCubit authCubit;

  group('AuthCubit Tests', () {
    setUp(() {
      mockAuthRepo = MockAuthRepo();
      authCubit = AuthCubit(mockAuthRepo);
    });

    tearDown(() {
      authCubit.close();
    });

    blocTest<AuthCubit, AuthState>(
      'emits [loading, loggedIn] when login is successful',
      build: () => authCubit,
      setUp: () => when(() => mockAuthRepo.login("test@gmail.com", "1234567"))
          .thenAnswer(
        (_) async => User(id: "1", fullname: "test", email: "test@gmail.com"),
      ),
      act: (bloc) => bloc.login("test@gmail.com", "1234567"),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(status: AuthStatus.loggedIn),
      ],
    );
  });
}
