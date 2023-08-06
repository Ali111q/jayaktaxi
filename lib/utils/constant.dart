import 'package:google_maps_flutter/google_maps_flutter.dart';

String webSocketUrl(LatLng pos) =>
    'ws://172.20.10.11:6001/taxi-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=5|5pM4xvXeHW4VpZvXgHqK8Nt52Lh0jD3f5P8B1jGC';
