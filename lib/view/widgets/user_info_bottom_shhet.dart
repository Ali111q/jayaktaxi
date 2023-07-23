import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak_taxi/controller/taxi_controller.dart';
import 'package:jayak_taxi/model/request.dart';
import 'package:provider/provider.dart';

class UserInfoBottomSheet extends StatelessWidget {
  const UserInfoBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Request _request = Provider.of<TaxiController>(context).acceptedOrder!;
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.06,
      initialChildSize: 0.25,
      snap: true,
      maxChildSize: 0.25,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 3,
                width: 35,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.09))
                  ],
                  borderRadius: BorderRadius.circular(11)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffFF4100)),
                              shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svgs/call.svg',
                              width: 30,
                            ),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              _request.price.toString(),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text('السعر')
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _request.user!.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text(_request.user!.mobile)
                          ],
                        ),
                        Container(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffFF4100)),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(_request.user!.image),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            'بدأ الرحلة',
                            style: TextStyle(fontSize: 21),
                          )),
                        ))),
                Container(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff292424)),
                    onPressed: () {},
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            'الغاء الرحلة',
                            style: TextStyle(fontSize: 21),
                          )),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
