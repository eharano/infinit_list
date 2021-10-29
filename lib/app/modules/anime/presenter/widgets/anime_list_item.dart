import 'package:flutter/material.dart';

import '../../domain/entities/anime.dart';

class AnimeListItem extends StatelessWidget {
  final Anime anime;

  const AnimeListItem({
    Key? key,
    required this.anime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Image.network(
      //   anime.image!,
      //   loadingBuilder: (context, widget, imageChunkEvent) {
      //     return imageChunkEvent == null
      //         ? widget
      //         : const CircularProgressIndicator();
      //   },
      //   height: 150,
      //   width: 150,
      // ),
      isThreeLine: true,
      dense: true,
      title: Text('ID: ${anime.id.toString()}'),
      subtitle: Text(anime.title),
    );
  }
}
