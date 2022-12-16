class User {
  String? id;
  String? login;
  String? password;

  User({
    this.login,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        login = json['login'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        json[key] = value;
      }
    }

    writeNotNull('id', id);
    writeNotNull('login', login);
    writeNotNull('password', password);

    return json;
  }
}
