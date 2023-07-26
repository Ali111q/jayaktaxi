import 'package:flutter/material.dart';

class OrdersBottomSheet extends StatelessWidget {
  const OrdersBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22), topRight: Radius.circular(22))),
      child: ListView(
        children: [
          OrderListWidget(),
          OrderListWidget(),
          OrderListWidget(),
          OrderListWidget(),
        ],
      ),
    );
  }
}

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 3),
                blurRadius: 6)
          ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(12)),
        ),
        Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  'شارع الربيع- رضا علوان',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  ':موقع',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'شارع الربيع- رضا علوان',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  ':الوجهة',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '5,000',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  ':الاجرة',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        Container()
      ]),
    );
  }
}
