import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injector.dart';
import 'domain/entities/pixel.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/pixels/pixels_bloc.dart';
import 'presentation/widgets/auth_button.dart';
import 'presentation/widgets/canvas_viewer.dart';
import 'presentation/widgets/color_picker.dart';
import 'presentation/widgets/history.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Color color = Colors.black;

  final AuthCubit _authCubit = getIt.get()..login();
  final PixelsBloc _pixelsBloc = getIt.get()
    ..add(PixelsEventListen())
    ..add(PixelsHistoryEventListen());

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'duribreux/place',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          ...context.localizationDelegates,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Scaffold(
          appBar: AppBar(
            elevation: 16,
            backgroundColor: const Color(0xAF0F0F0F),
            title: const Text('duribreux/place'),
            actions: [
              ColorPicker(
                color: color,
                onColorChanged: (color) => setState(() => this.color = color),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: _authCubit,
                listener: (context, state) => showAuthSnackBar(state, context),
                builder: (context, state) => AuthButton(
                  authCubit: _authCubit,
                  state: state,
                ),
              ),
            ],
            centerTitle: false,
          ),
          body: SafeArea(
            child: BlocListener<PixelsBloc, PixelsState>(
              bloc: _pixelsBloc,
              listener: (context, state) => showPixelSnackbar(state, context),
              child: Row(
                children: [
                  StreamBuilder<List<Pixel>>(
                    stream: _pixelsBloc.pixelsHistoryStream,
                    builder: (context, snapshot) => History(
                      pixels: snapshot.data ?? [],
                    ),
                  ),
                  StreamBuilder<List<Pixel>>(
                    stream: _pixelsBloc.pixelsStream,
                    builder: (context, snapshot) => Expanded(
                      child: CanvasViewer(
                        pixelsBloc: _pixelsBloc,
                        color: color,
                        pixels: snapshot.data ?? [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void showPixelSnackbar(PixelsState state, BuildContext context) {
    if (state is PixelsUnauthorized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must sign-in to draw')),
      );
    }
  }

  void showAuthSnackBar(AuthState state, BuildContext context) {
    if (state is AuthLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in anonymously'),
        ),
      );
    } else if (state is AuthLoggedOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out'),
        ),
      );
    }
  }
}
