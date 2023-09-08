import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak_taxi/controller/taxi_controller.dart';
import 'package:jayak_taxi/helper/svg_to_marker.dart';
import 'package:jayak_taxi/view/widgets/bottom_sheet.dart';
import 'package:jayak_taxi/view/widgets/orders_bottom_sheet.dart';
import 'package:jayak_taxi/view/widgets/request_float_widget.dart';
import 'package:jayak_taxi/view/widgets/request_info_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'widgets/user_info_bottom_shhet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ToastContext con = ToastContext();

    con.init(context);
  }

  @override
  Widget build(BuildContext context) {    Marker? marker =Provider.of<TaxiController>(context).marker;
    TaxiController controller = Provider.of<TaxiController>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => OrdersBottomSheet(),
              );
            },
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(7),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset('assets/svgs/orders.svg'),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => HomeBottomSheet(),
                );
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/svgs/setting.svg'),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          if (controller.position != null)
            GoogleMap(
              initialCameraPosition: controller.position!,
              zoomControlsEnabled: false,
              // myLocationEnabled: true,
              markers: {
                marker?? Marker(
                    markerId: MarkerId('value'),
                    icon:  BitmapDescriptor.defaultMarker
                    ,
                    position: LatLng(
                        Provider.of<TaxiController>(context).lastLat,
                        Provider.of<TaxiController>(context).lastLng))
              },
              onMapCreated: Provider.of<TaxiController>(context, listen: false)
                  .initialController,
              myLocationButtonEnabled: false,
            ),
          RequestFloatWidget(),
        ],
      ),
      bottomSheet: controller.acceptedOrder != null
          ? UserInfoBottomSheet()
          : Container(
              height: 0.1,
              color: Colors.transparent,
            ),
    );
  } 

}
