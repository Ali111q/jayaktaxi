import 'package:google_maps_flutter/google_maps_flutter.dart';

const String url = 'https://jayk.dorto-dev.com';
String webSocketUrl(LatLng pos, String token) =>
    'wss://jayk.dorto-dev.com:6001/taxi-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=$token';

const String loginUrl = '$url/api/auth/login';
const String loginCheckUrl = '$url/api/auth/login/check-code';
const String registerUrl =  '$url/api/auth/register/complete';