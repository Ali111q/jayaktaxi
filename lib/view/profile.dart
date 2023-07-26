import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak_taxi/view/widgets/car_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 0;
  List tabs = [
    {'index': 0, 'image': 'assets/svgs/car2.svg'},
    {'index': 1, 'image': 'assets/svgs/star.svg'},
    {'index': 2, 'image': 'assets/svgs/pirson.svg'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          // backgroundColor: Color(0xffFF4100),
          bottom: PreferredSize(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 60,
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Text(
                          'احمد مصطفى عامر',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          '07723948349',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(7),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset('assets/svgs/back.svg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              preferredSize: Size(MediaQuery.of(context).size.width, 200)),
          elevation: 2,
          leading: Container()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '4.4',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'التقييم',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  width: 5,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFF4100).withOpacity(0.25),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: SvgPicture.asset('assets/svgs/star.svg'),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...tabs.map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = e['index'];
                        });
                      },
                      child: ProfileTab(
                          image: e['image'],
                          isSelected: e['index'] == selectedIndex),
                    ))
              ],
            ),
            Container(
              height: 30,
            ),
            CarProfile()
          ],
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key, required this.image, required this.isSelected});
  bool isSelected;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.width * 0.22,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffFF4100)),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Color(0xffFF4100) : Colors.white),
      child: Center(
        child: SvgPicture.asset(
          image,
          color: !isSelected ? Color(0xffFF4100) : Colors.white,
        ),
      ),
    );
  }
}
