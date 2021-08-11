class User {
  int? userID;
  String? name;
  String? number;
  String? password;
  String? picture;

  User(this.name, this.number, this.password, this.picture);

  User.withId(this.name, this.number, this.password, this.picture, this.userID);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['userID'] = userID;
    map['name'] = name;
    map['number'] = number;
    map['password'] = password;
    map['picture'] = picture;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.userID = map['userID'];
    this.name = map['name'];
    this.number = map['number'];
    this.password = map['password'];
    this.picture = map['picture'];
  }
}
