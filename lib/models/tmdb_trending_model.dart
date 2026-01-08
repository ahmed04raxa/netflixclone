class TmdbTrending {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  TmdbTrending({this.page, this.results, this.totalPages, this.totalResults});

  TmdbTrending.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  bool? adult;
  String? backdropPath;
  int? id;
  String? name;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;
  String? title;
  String? originalTitle;
  String? releaseDate;
  bool? video;

  Results(
      {this.adult,
        this.backdropPath,
        this.id,
        this.name,
        this.originalName,
        this.overview,
        this.posterPath,
        this.mediaType,
        this.originalLanguage,
        this.genreIds,
        this.popularity,
        this.firstAirDate,
        this.voteAverage,
        this.voteCount,
        this.originCountry,
        this.title,
        this.originalTitle,
        this.releaseDate,
        this.video});

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];

    genreIds = json['genre_ids'] != null
        ? List<int>.from(json['genre_ids'])
        : [];

    popularity = json['popularity'];
    firstAirDate = json['first_air_date'];
    voteAverage = (json['vote_average'] as num?)?.toDouble();
    voteCount = json['vote_count'];

    originCountry = json['origin_country'] != null
        ? List<String>.from(json['origin_country'])
        : [];

    title = json['title'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    video = json['video'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['name'] = name;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['original_language'] = originalLanguage;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['first_air_date'] = firstAirDate;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['origin_country'] = originCountry;
    data['title'] = title;
    data['original_title'] = originalTitle;
    data['release_date'] = releaseDate;
    data['video'] = video;
    return data;
  }
}