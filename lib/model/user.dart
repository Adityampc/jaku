class User {
  String id;
  String username;
  String name;
  String? createdAt;
  String? password;
  bool isAdmin;

  User(
      {required this.id,
      required this.username,
      required this.name,
      this.createdAt,
      this.password,
      this.isAdmin = false});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      username: json["username"],
      name: json["name"],
      password: json["password"],
      isAdmin: json["isAdmin"] == 1,
      createdAt: json["createdAt"]);

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "username": this.username,
        "name": this.name,
        "password": this.password,
        "createdAt": this.createdAt,
        "isAdmin": this.isAdmin
      };
}
