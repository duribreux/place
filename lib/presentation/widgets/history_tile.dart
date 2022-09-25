import 'package:flutter/material.dart';

import '../../domain/entities/pixel.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    Key? key,
    required this.pixel,
  }) : super(key: key);

  final Pixel pixel;

  @override
  Widget build(BuildContext context) => ListTile(
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
      );
}
