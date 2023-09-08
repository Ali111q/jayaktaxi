import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak_taxi/controller/auth_controller.dart';
import 'package:jayak_taxi/controller/taxi_controller.dart';
import 'package:jayak_taxi/view/login.dart';
import 'package:jayak_taxi/view/profile.dart';
import 'package:provider/provider.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      
      backgroundColor: Colors.transparent,
      // dragHandleColor: Colors.transparent,
      // shadowColor: Colors.transparent,
      onClosing: () {},
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22))),
        child: Column(
          children: [
            BottomSheetWidget(
              name: 'الملف الشخصي',
              image: 'assets/svgs/person.svg',
            ),
            BottomSheetWidget(
              name: 'المحفظة',
              image: 'assets/svgs/wallet.svg',
            ),
            BottomSheetWidget(
              name: 'التحديات',
              image: 'assets/svgs/challeng.svg',
            ),
            BottomSheetWidget(
              name: 'متوفر',
              image: 'assets/svgs/available.svg',
              isCheck: true,
            ),
            BottomSheetWidget(
              name: 'اتصل بنا',
              image: 'assets/svgs/contact.svg',
            ),
              BottomSheetWidget(
              name: 'تسجيل خروج',
              image: 'assets/svgs/language.svg',
              onTap:(){
                Provider.of<AuthController>(context, listen: false).logout();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => LoginScreen(),), (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
   BottomSheetWidget(
      {super.key,
      this.isCheck = false,
      required this.name,
      required this.image, this.onTap});
  final String name;
  final String image;
  final bool isCheck;
  final void Function()? onTap;
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    bool _isAvailable = Provider.of<TaxiController>(context).isAvailable;
    return GestureDetector(
      onTap: widget.onTap??() {
        Navigator.of(context).push(MaterialPageRoute(builder:(context) => Profile(),));
      },
      child: Container(
        margin: EdgeInsets.all(7),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  offset: Offset(0, 2),
                  blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            if (widget.isCheck)
              Switch(
                  value: _isAvailable,
                  onChanged: (value) {
                    Provider.of<TaxiController>(context, listen: false)
                        .changeIsAvailable(value, context);
                  }),
            Container(),
            Row(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xffFF4100).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: SvgPicture.asset(widget.image),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
