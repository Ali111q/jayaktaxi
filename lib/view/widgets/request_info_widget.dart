import 'package:flutter/material.dart';

class RequestInfoWidget extends StatefulWidget {
  const RequestInfoWidget({super.key});

  @override
  State<RequestInfoWidget> createState() => _RequestInfoWidgetState();
}

class _RequestInfoWidgetState extends State<RequestInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Container(),
    );
  }
}
