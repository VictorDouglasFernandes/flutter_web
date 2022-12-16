class Activity {
  String? id;
  String? title;
  String? description;
  String? user;
  String? share;

  Activity({
    this.id,
    this.title,
    this.description,
    this.user,
    this.share,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        user = json['user'],
        share = json['share'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        json[key] = value;
      }
    }

    writeNotNull('id', id);
    writeNotNull('title', title);
    writeNotNull('description', description);
    writeNotNull('user', user);
    writeNotNull('share', share);

    return json;
  }
}
