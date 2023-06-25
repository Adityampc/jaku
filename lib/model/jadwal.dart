class Jadwal {
  String id;
  String userId;
  String title;
  int datetime;
  String? description;
  String? createdAt;

  Jadwal(
      {required this.id,
      required this.userId,
      required this.title,
      required this.datetime,
      this.description,
      this.createdAt});

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        createdAt: json["createdAt"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "datetime": datetime,
        "description": description,
        "createdAt": createdAt,
      };
}
