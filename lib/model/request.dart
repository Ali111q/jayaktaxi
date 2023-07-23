import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak_taxi/model/user.dart';

class Request {
  final String id;
  final int price;
  final String fromAdrees;
  final String toAdress;
  final LatLng from;
  final LatLng to;
  User? user;

  Request(
      {required this.id,
      required this.price,
      required this.fromAdrees,
      required this.toAdress,
      required this.from,
      required this.to,
      this.user});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        id: json['order_id'],
        price: json['price'],
        fromAdrees: json['from_address'],
        toAdress: json['to_address'],
        from: LatLng(json['from_lat'], json['from_lng']),
        to: LatLng(json['to_lat'], json['to_lng']),
        user: json['user_info'] == null
            ? null
            : User.fromJson(json['user_info']));
  }

  void addUser(Map<String, dynamic> json) {
    user = User.fromJson(json);
  }
}
