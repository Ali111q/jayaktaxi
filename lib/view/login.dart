import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak_taxi/view/otp.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../controller/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/words.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool isShow = false;
  Words _words = Words('ar');
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
                  ToastContext con = ToastContext();

    con.init(context);
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        isShow = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: isShow
                    ? MediaQuery.of(context).size.height * 0.1
                    : MediaQuery.of(context).size.height * 0.35,
              ),
              Hero(
                tag: 'hero1',
                child: SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
              Container(
                height: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).size.height * 0.15
                    : MediaQuery.of(context).size.height * 0,
              ),
              Container(
                height: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).size.height * 0.6
                    : MediaQuery.of(context).size.height * 0.8,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      bottom: isShow
                          ? MediaQuery.of(context).viewInsets.bottom * 0.5
                          : -800,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff707070).withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              Container(
                                height: 10,
                              ),
                              Text(
                                _words.loginTitle(),
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 10,
                              ),
                              Text(
                                _words.loginSubtitle(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                height: 40,
                              ),
                              TextField(
                                textDirection:  TextDirection.rtl,
                      controller: _textController,
                      keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  
                                  hintTextDirection:  TextDirection.rtl,
                                  hintText: _words.loginFieldHint(),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              if (MediaQuery.of(context).viewInsets.bottom <=
                                  30)
                                Spacer()
                              else
                                Container(
                                  height: 20,
                                ),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<AuthController>(context, listen: false).login(_textController.text).then((value) {
    
                                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => OtpScreen(),));
                                  }).catchError((e){});
                                },
                                style: ElevatedButton.styleFrom(),
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Center(
                                          child: Text(
                                        _words.loginButton(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
