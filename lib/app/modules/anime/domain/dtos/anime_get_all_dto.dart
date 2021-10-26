class AnimeGetAllDTO {
  final int page;
  final int perPage;

  const AnimeGetAllDTO({
    this.page = 1,
    this.perPage = 10,
  });

  Map<String, dynamic> toMap() {
    return {'page': page, 'per_page': perPage};
  }
}
