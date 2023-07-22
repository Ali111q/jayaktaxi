import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:jayak_taxi/controller/taxi_controller.dart';
import 'package:jayak_taxi/model/request.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RequestFloatWidget extends StatefulWidget {
  const RequestFloatWidget({super.key});

  @override
  State<RequestFloatWidget> createState() => _RequestFloatWidgetState();
}

class _RequestFloatWidgetState extends State<RequestFloatWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaxiController controller = Provider.of<TaxiController>(context);
    TaxiController animationController2 = Provider.of<TaxiController>(context);
    return AnimatedPositioned(
        duration: Duration(milliseconds: 400),
        left: (MediaQuery.of(context).size.width * 0.5) -
            (MediaQuery.of(context).size.width *
                (animationController2.iscircle ? 0.1 : 0.5)),
        bottom: animationController2.iscircle &&
                animationController2.animationController == 0
            ? 30
            : animationController2.animationController *
                MediaQuery.of(context).size.width *
                0.1,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          width: MediaQuery.of(context).size.width *
              (animationController2.iscircle ? 0.2 : 1),
          height: MediaQuery.of(context).size.width *
              (animationController2.iscircle ? 0.2 : 0.56),
          decoration: BoxDecoration(
              color: animationController2.iscircle
                  ? Colors.white
                  : Colors.transparent,
              shape: animationController2.iscircle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              boxShadow: [
                if (animationController2.iscircle)
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 1),
                      blurRadius: 2),
              ]),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: animationController2.isChildVisable
                  ? Swiper(
                      itemCount: controller.requrests.length,
                      loop: false,
                      itemBuilder: (context, index) => RequestWidget(
                        animationController2: animationController2,
                        request: controller.requrests[index],
                      ),
                    )
                  : SvgPicture.asset('assets/svgs/car.svg'),
            ),
          ),
        ));
  }
}

class RequestWidget extends StatelessWidget {
  const RequestWidget(
      {super.key, required this.animationController2, required this.request});

  final TaxiController animationController2;
  final Request request;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animationController2.isChildVisable ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVHr_twNt7EdqYz5X_2cqo6aMiMCf-xzWU4il7aL4X&s',
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            request.fromAdrees,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            ':موقع',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 19),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            request.toAdress,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            ':الوجهة',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 19),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            request.price.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            ':الاجرة',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 19),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Provider.of<TaxiController>(context, listen: false)
                        .accept(request, context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.36,
                      height: 50,
                      child: Center(
                          child: Text(
                        'موافقة',
                        style: TextStyle(fontSize: 19),
                      )))),
              ElevatedButton(
                onPressed: () {
                  Provider.of<TaxiController>(context, listen: false)
                      .reject(request);
                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.36,
                    child: Center(
                        child: Text(
                      'تجاهل',
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ))),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
