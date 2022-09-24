import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<void> loginAnonymously() => _firebaseAuth.signInAnonymously();

  @override
  Future<void> logout() => _firebaseAuth.signOut();

  @override
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  @override
  String? get uid => _firebaseAuth.currentUser?.uid;
}
