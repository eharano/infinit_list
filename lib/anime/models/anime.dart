class AnimeModel {
  final int id;
  final String title;
  final String link;
  final String image;

  const AnimeModel({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) => _$AnimeModelFromJson(json);
}
