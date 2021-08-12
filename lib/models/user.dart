class Account {
  String? name;
  String? number;

  Account(this.name, this.number);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['userName'] = name;
    map['phoneNumber'] = number;
    return map;
  }

  Account.fromMap(Map<String, dynamic> map) {
    this.name = map['userName'];
    this.number = map['phoneNumber'];
  }
}
