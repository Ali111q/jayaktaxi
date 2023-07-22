import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak_taxi/model/request.dart';
import 'package:jayak_taxi/service/location_service.dart';
import 'package:jayak_taxi/utils/constant.dart';
import 'package:toast/toast.dart';
import 'package:web_socket_client/web_socket_client.dart';

class TaxiController extends ChangeNotifier {
  bool isAvailable = false;
  double animationController = -10;
  bool iscircle = true;
  bool isChildVisable = false;
  late WebSocket socket;
  CameraPosition? position;
  double lastLat = 0;
  List<Request> requrests = [];
  bool isAccepted = false;
  Timer? delay;
  late GoogleMapController mapController;
  initialController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  TaxiController() {
    _init();
  }

  void _socketConnect() async {
    LatLng location = await _userLocation();
    socket = WebSocket(Uri.parse(webSocketUrl(location)));

    socket.messages.listen((event) {
      print(event);
      var json = jsonDecode(event);
      if (json['state'] != 0 && json['status'] != false) {
        if (json['state'] == 2) {
          
        } else {
          int newIndex = requrests.length;
          var request = Request.fromJson(json);
          requrests.add(request);
          print(requrests);
          notifyListeners();
          Future.delayed(Duration(seconds: 30)).then((e) {
            requrests.remove(request);
            notifyListeners();
          });
        }
        _startRequestQueue();
        Future.delayed(Duration(seconds: 30)).then((e) {
          _startRequestQueue();
        });
      }
      if (json['status'] == false) {
        Toast.show(json['message'],
            duration: Toast.lengthShort, gravity: Toast.bottom);
      }
    });
  }

  void _socketDisconnect() {
    socket.close();
  }

  _init() async {
    position = CameraPosition(target: await _userLocation(), zoom: 16);
    Stream<Position> pos = LocationService.getLocationSteam();
    pos.listen(
      (event) {
        mapController.animateCamera(
            CameraUpdate.newLatLng(LatLng(event.latitude, event.longitude)));
        if (event.latitude != lastLat) {
          lastLat = event.latitude;
          sendLocation(event);
        }
      },
    );
    notifyListeners();
  }

  Future<LatLng> _userLocation() async {
    Position value = await LocationService.determinePosition();
    LatLng _latLng = LatLng(value.latitude, value.longitude);
    return _latLng;
  }

  void changeIsAvailable(bool val) {
    if (val) {
      _socketConnect();
    } else {
      _socketDisconnect();
    }
    isAvailable = val;
    notifyListeners();
  }

  void nextAnimation() async {
    animationController = 0;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 600));
    _changeCirce(false);
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1000));
    isChildVisable = true;
    notifyListeners();
  }

  _hideAnimation() async {
    animationController = -10;

    notifyListeners();
    await Future.delayed(Duration(milliseconds: 600));
    _changeCirce(true);
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1000));
    isChildVisable = false;
    notifyListeners();
  }

  _startRequestQueue() async {
    if (requrests.isEmpty) {
      stopRequset();
    } else {
      _showRequest();
    }
  }

  _showRequest() async {
    nextAnimation();
    await Future.delayed(Duration(seconds: 20));
  }

  void _changeCirce(bool b) {
    iscircle = b;
  }

  stopRequset() {
    _hideAnimation();
  }

  sendLocation(Position pos) {
    socket.send(jsonEncode({
      "type": 9,
      "lat": pos.latitude,
      "lng": pos.longitude,
    }));
  }

  void reject(Request request) {
    requrests.remove(request);
    _startRequestQueue();
  }

  void accept(Request request, BuildContext context) async {
    LatLng location = await _userLocation();
    Map message = {
      'type': 3,
      'lat': location.latitude,
      'lng': location.longitude,
      'orderId': request.id
    };
    socket.send(jsonEncode(message));
  }
}
