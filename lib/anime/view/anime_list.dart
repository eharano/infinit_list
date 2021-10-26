import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinit_list/app/modules/anime/domain/entities/anime.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  Future<List<AnimeModel>> _getAnimes() async {
    var data = await http.get(Uri.parse(
        "https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=1&per_page=5"));

    var jsonData = json.decode(data.body);

    List<AnimeModel> animes = [];

    for (var a in jsonData) {
      AnimeModel anime = AnimeModel(
        id: a['id'],
        title: a['title']['rendered'],
        image: '', //a['link'],
        link: a['yoast_head_json']['og_image']['url'],
      );

      animes.add(anime);
    }

    return animes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAnimes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(child: Text('Loading...'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var anime = snapshot.data[index];
              return ListTile(
                // leading: Image.network(
                //   anime.image,
                //   width: 100,
                // ),
                title: Text(anime.title),
                subtitle: Text(anime.link),
              );
            },
          );
        }
      },
    );
  }
}
