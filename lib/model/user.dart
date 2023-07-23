class User {
  final int id;
  final String name;
  final String mobile;
  final String image;

  User(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.image});
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      image: json['image']);
}
