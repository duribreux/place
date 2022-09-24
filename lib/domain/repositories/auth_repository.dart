abstract class AuthRepository {
  Future<void> loginAnonymously();
  Future<void> logout();
  bool get isSignedIn;
  String? get uid;
}
