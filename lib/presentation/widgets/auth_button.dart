import 'package:flutter/material.dart';

import '../blocs/auth/auth_cubit.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.authCubit,
    required this.state,
  }) : super(key: key);

  final AuthCubit authCubit;
  final AuthState state;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(
          authCubit.isSignedIn || state is AuthLoggedIn
              ? Icons.logout
              : Icons.login,
        ),
        onPressed: () => authCubit.isSignedIn || state is AuthLoggedIn
            ? authCubit.logout()
            : authCubit.login(),
      );
}
