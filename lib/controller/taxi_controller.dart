import 'dart:async';
import 'dart:convert';

// import 'package:audioplayers/audioplayers.dart';
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
  // AudioPlayer player = AudioPlayer();
Marker? marker;
  double animationController = -10;
  bool iscircle = true;
  bool isChildVisable = false;
  late WebSocket socket;
  CameraPosition? position;
  double lastLat = 0;
  double lastLng = 0;
  List<Request> requrests = [];
  Request? acceptedOrder;
  bool isAccepted = false;
  Timer? delay;
  String? token;

  RequestState requestState = RequestState.waitting;
   GoogleMapController? mapController;
  initialController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  TaxiController(BuildContext context) {
    _init(context);
  }
  void setToken(String? token){
    print(token);
    this.token = token;
    notifyListeners(); 
  }
  void _socketConnect(BuildContext context) async {
    LatLng location = await _userLocation();
    socket = WebSocket(Uri.parse(webSocketUrl(location, token!)));

    socket.messages.listen((event) async {

        
      // await player.play(AssetSource("assets/audio/request.mp3"));
      print(event);
      var json = jsonDecode(event);
      if (json['state'] != 0 && (json['status'] != false||json['status'] != 0 )) {
        if (json['state'] == 2) {
          acceptedOrder = Request.fromJson(json);
          requestState = RequestState.startOrder;
        } else if (json['state'] == 3||json['state'] == 7||json['state'] == 0||json['state'] == 2) {
          requestState = RequestState.waitting;
          acceptedOrder = null;
          requrests.clear();
          notifyListeners();
        }
        else if(json['state'] == 5){
          requestState = RequestState.inSpot;
          notifyListeners();
        }
        else if(json['state'] == 6){
          requestState = RequestState.inTravil;
          notifyListeners();
        }
         else if(json['status']==false){
          Toast.show(json['message']);
         }
         else {
          int newIndex = requrests.length;
          var request = Request.fromJson(json);
          requrests.add(request);
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
      if (json['status'] == false ||json['status'] ==0 ) {
        Toast.show(json['message'],
            duration: Toast.lengthShort, gravity: Toast.bottom);
      }
    
    });
  }

  void _socketDisconnect() {
    socket.close();
  }

  _init(BuildContext context) async {
    position = CameraPosition(target: await _userLocation(), zoom: 16);
    Stream<Position> pos = LocationService.getLocationSteam();
    pos.listen(
      (event) {
        if (requestState == RequestState.waitting) {
          if (mapController!= null) {
          mapController!.animateCamera(
              CameraUpdate.newLatLng(LatLng(event.latitude, event.longitude)));
          }
        }
        if (requestState == RequestState.startOrder) {
          if (mapController!= null) {
          mapController!.animateCamera(CameraUpdate.newLatLngBounds(
              boundsFromLatLngList([
                LatLng(event.latitude, event.longitude),
                acceptedOrder!.from
              ]),
              100));
          }
        }
        if (requestState == RequestState.endOredr) {
          if (mapController!= null) {
          mapController!.animateCamera(CameraUpdate.newLatLngBounds(
              boundsFromLatLngList(
                  [LatLng(event.latitude, event.longitude), acceptedOrder!.to]),
              100));
          }
        }
        if (event.latitude != lastLat || event.longitude != lastLng) {
          lastLat = event.latitude;
          lastLng = event.longitude;
_getMarker(context);
          notifyListeners();

          try {
            sendLocation(event);
          } catch (e) {}
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

  void changeIsAvailable(bool val, BuildContext context) {
    if (val) {
      _socketConnect(context);
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
    requrests.remove(request);
    notifyListeners();
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
  void changeToInSpot()async{
    print('object');
      LatLng location = await _userLocation();
    Map message = {
      'type': 6,
      'lat': location.latitude,
      'lng': location.longitude,
    };
    socket.send(jsonEncode(message));
    notifyListeners();
  }
    void changeToInTravel()async{
      LatLng location = await _userLocation();
    Map message = {
      'type': 7,
      'lat': location.latitude,
      'lng': location.longitude,
    };
    socket.send(jsonEncode(message));
    notifyListeners();
  }
    void finishTrip()async{
      LatLng location = await _userLocation();
    Map message = {
      'type': 8,
      'lat': location.latitude,
      'lng': location.longitude,
    };
    socket.send(jsonEncode(message));
    notifyListeners();
  }
    void cnacel()async{
      LatLng location = await _userLocation();
    Map message = {
      'type': 5,
      'lat': location.latitude,
      'lng': location.longitude,
    };
    socket.send(jsonEncode(message));
    notifyListeners();
  }
  _getMarker(BuildContext context)async{
     BitmapDescriptor.fromAssetImage(createLocalImageConfiguration(context), "assets/images/car.png").then((value) {
     
        marker =    Marker(
                    markerId: MarkerId('value'),
                    icon:value 
                    ,
                    position: LatLng(
lastLat,
lastLng));
 
     });

   
  }
}

enum RequestState {
  waitting,
  startOrder,
  inSpot,
  inTravil,
  endOredr,
}
