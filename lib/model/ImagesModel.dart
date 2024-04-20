// To parse this JSON data, do
//
//     final images = imagesFromJson(jsonString);

class ImagesModel {
  int total;
  int totalHits;
  List<Hit> hits;

  ImagesModel({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
      };
}

class Hit {
  int id;
  String pageUrl;
  String previewUrl;
  String largeImageUrl;
  int views;
  int likes;
  String userImageUrl;

  Hit(
      {required this.id,
      required this.pageUrl,
      required this.previewUrl,
      required this.largeImageUrl,
      required this.views,
      required this.likes,
      required this.userImageUrl});

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        pageUrl: json["pageURL"],
        previewUrl: json["previewURL"],
        largeImageUrl: json["largeImageURL"],
        views: json["views"],
        likes: json["likes"],
        userImageUrl: json["userImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "previewURL": previewUrl,
        "largeImageURL": largeImageUrl,
        "views": views,
        "likes": likes,
        "userImageURL": userImageUrl,
      };
}
