class Moviesdao {
  int? idMovie;
  String? nameMovie;
  String? overview;
  String? idGenre;
  String? imgMovie;
  String? releaseDate;

  Moviesdao(
      {this.idMovie,
      this.nameMovie,
      this.overview,
      this.idGenre,
      this.imgMovie,
      this.releaseDate});

  factory Moviesdao.fromMap(Map<String, dynamic> movie) {
    return Moviesdao(
        idGenre: movie['idGenre'],
        idMovie: movie['idMovie'],
        imgMovie: movie['imgMovie'],
        nameMovie: movie['nameMovie'],
        overview: movie['overview'],
        releaseDate: movie['releaseDate']);
  }
}
