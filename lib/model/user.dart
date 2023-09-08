class User {
  final int id;
  final String name;
  final String mobile;
  final String image;
  final int typeNumber;
  final String typeName;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.image,
      required this.typeNumber,
      required this.token,
      required this.typeName});
  factory User.fromJson(Map<String, dynamic> json, {String? token}) => User(
        id: json['id'],
        name: json['name'],
        mobile: json['mobile'],
        image: json['image'],
        typeNumber: json['type']['type_number'],
        typeName: json['type']['type_name'],
        token: json['token']??token??''
      );
}
