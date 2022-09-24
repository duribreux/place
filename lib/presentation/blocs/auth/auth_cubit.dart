import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(
    this._authRepository,
  ) : super(AuthInitial());

  bool get isSignedIn => _authRepository.isSignedIn;

  Future<void> login() async {
    await _authRepository.loginAnonymously();
    emit(AuthLoggedIn());
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthLoggedOut());
  }
}
