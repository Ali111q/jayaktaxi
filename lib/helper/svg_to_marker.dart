import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;

Future<BitmapDescriptor> getSvgMarker(
    String string, BuildContext context) async {
  final String rawSvg = string;
  final PictureInfo pictureInfo =
      await vg.loadPicture(SvgStringLoader(rawSvg), null);

// You can draw the picture to a canvas:

// Or convert the picture to a an image:
  final ui.Image image = await pictureInfo.picture.toImage(200, 200);

  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return await BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}

BitmapDescriptor googleMapIcon(String string, BuildContext context) {
  BitmapDescriptor? bitmapDescriptor;
  getSvgMarker(string, context).then((value) {
    print(value.toJson());
    bitmapDescriptor = value;
  });
  return bitmapDescriptor ?? BitmapDescriptor.defaultMarker;
}
