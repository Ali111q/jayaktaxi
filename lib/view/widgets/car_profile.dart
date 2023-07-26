import 'package:flutter/material.dart';

class CarProfile extends StatelessWidget {
  const CarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarProfileText(
          title: 'نوع السيارة',
          value: 'النترا',
        ),
        CarProfileText(
          title: 'موديل السيارة',
          value: '2020',
        ),
      ],
    );
  }
}

class CarProfileText extends StatelessWidget {
  const CarProfileText({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Container(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.98,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFF4100), width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          height: 10,
        )
      ],
    );
  }
}
