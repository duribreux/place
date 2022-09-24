import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'core/di/injector.dart';
import 'domain/entities/pixel.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/pixels/pixels_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey _key = GlobalKey<ScaffoldState>();
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
        key: _key,
        appBar: AppBar(
          elevation: 16,
          backgroundColor: const Color(0xAF0F0F0F),
          title: const Text('duribreux/place'),
          actions: [
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlockPicker(
                  pickerColor: color,
                  onColorChanged: (color) => setState(() => this.color = color),
                  layoutBuilder: (context, colors, child) => Row(
                    children: [for (Color color in colors) child(color)],
                  ),
                ),
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              bloc: _authCubit,
              listener: (context, state) {
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
              },
              builder: (context, state) => IconButton(
                icon: Icon(
                  _authCubit.isSignedIn || state is AuthLoggedIn
                      ? Icons.logout
                      : Icons.login,
                ),
                onPressed: () => _authCubit.isSignedIn || state is AuthLoggedIn
                    ? _authCubit.logout()
                    : _authCubit.login(),
              ),
            ),
          ],
          centerTitle: false,
        ),
        body: SafeArea(
          child: BlocListener<PixelsBloc, PixelsState>(
            bloc: _pixelsBloc,
            listener: (context, state) {
              if (state is PixelsUnauthorized) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You must sign-in to draw'),
                  ),
                );
              }
            },
            child: Row(
              children: [
                StreamBuilder<List<Pixel>>(
                    stream: _pixelsBloc.pixelsHistoryStream,
                    builder: (context, snapshot) => Container(
                          width: 150,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: snapshot.data
                                    ?.map(
                                      (pixel) => ListTile(
                                        contentPadding: const EdgeInsets.all(8),
                                        horizontalTitleGap: 0,
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        title: Text(
                                          pixel.uuid,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '(${pixel.offset.dx}, '
                                          '${pixel.offset.dy})',
                                        ),
                                        leading: SizedBox(
                                            width: 20,
                                            child: Container(
                                              color: pixel.color,
                                            )),
                                        onTap: () {},
                                      ),
                                    )
                                    .toList() ??
                                [
                                  const ListTile(
                                    title: Center(child: Text('History')),
                                  )
                                ],
                          ),
                        )),
                StreamBuilder<List<Pixel>>(
                  stream: _pixelsBloc.pixelsStream,
                  builder: (context, snapshot) => Expanded(
                    child: InteractiveViewer(
                      constrained: false,
                      minScale: 0.2,
                      maxScale: 15,
                      child: SizedBox(
                        width: 1920,
                        height: 1080,
                        child: Listener(
                          onPointerDown: (event) {
                            _pixelsBloc.add(PixelsEventAdd(
                              event.localPosition,
                              color,
                            ));
                          },
                          child: CustomPaint(
                            size: const Size(1920, 1080),
                            painter: MyPainter(
                              pixels: snapshot.data ?? [],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
}

class MyPainter extends CustomPainter {
  final List<Pixel> pixels;

  MyPainter({required this.pixels});

  @override
  void paint(Canvas canvas, Size size) {
    for (final pixel in pixels) {
      canvas.drawPoints(
        PointMode.points,
        [pixel.offset],
        Paint()
          ..color = pixel.color
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
