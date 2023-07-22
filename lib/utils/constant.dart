import 'package:google_maps_flutter/google_maps_flutter.dart';

String webSocketUrl(LatLng pos) =>
    'ws://192.168.0.114:6001/taxi-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=2|m6rr2Sg7j0WxGfWh27x7eYPJysX3I88wv0nynyDS';
