import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.tag, required this.image});
  final String tag;
  final File image;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Hero(tag: widget.tag, child: Image.file(widget.image)),
          Container(margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop('delete');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 10),
                    child: Text('حذف'),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 10),
                    child: Text('تم'),
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
