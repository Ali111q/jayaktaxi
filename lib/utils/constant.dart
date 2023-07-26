import 'package:google_maps_flutter/google_maps_flutter.dart';

String webSocketUrl(LatLng pos) =>
    'ws://192.168.0.114:6001/taxi-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=4|5QTFLBNTYZ0BwDxMw1xzsD8uPH6o5caDYdJ9ojcU';
