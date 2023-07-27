import 'package:flutter/material.dart';
import 'package:jayak_taxi/view/widgets/car_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarProfileText(title: 'الاسم الكامل', value: 'احمد مصطفى عامر')
      ],
    );
  }
}
