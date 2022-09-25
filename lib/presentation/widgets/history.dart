import 'package:flutter/material.dart';

import '../../domain/entities/pixel.dart';
import 'history_tile.dart';

class History extends StatelessWidget {
  const History({
    Key? key,
    required this.pixels,
  }) : super(key: key);

  final List<Pixel> pixels;

  @override
  Widget build(BuildContext context) => Container(
        width: 150,
        height: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: pixels.isNotEmpty
              ? pixels.map((pixel) => HistoryTile(pixel: pixel)).toList()
              : [const ListTile(title: Center(child: Text('History')))],
        ),
      );
}
