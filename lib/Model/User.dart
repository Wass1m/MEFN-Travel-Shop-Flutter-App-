class User {
  final String name;
  final String email;
  final String avatar;
  User(this.name, this.email, this.avatar);

  Map toJson() => {'name': name, 'email': email, 'avatar': avatar};

  User.fromJson(Map json)
      : name = json['name'],
        email = json['email'],
        avatar = json['avatar'];
}
