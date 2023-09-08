import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jayak_taxi/controller/auth_controller.dart';
import 'package:jayak_taxi/helper/image_view.dart';
import 'package:jayak_taxi/model/register.dart';
import 'package:provider/provider.dart';

import '../helper/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = TextEditingController();

  File? image;
  int accountType = 2;
  List<Map> carImages = [];
  File? frontIentityImage;
  File? backIentityImage;
  File? backResdinceImage;
  File? frontResdinceImage;
  File? frontDriverLicenseImage;
  File? backDriverLicenseImage;
  File? frontCarLicenseImage;
  File? backCarLicenseImage;

  ScrollController carImagesController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
                child: ElevatedButton(
                    onPressed: () async {
                      Provider.of<AuthController>(context, listen: false)
                          .register(
                              RegisterRequest(
                                name: name.text,
                                type: accountType,
                                frontCarLicense: frontCarLicenseImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await frontCarLicenseImage!
                                            .readAsBytes())),
                                backCarLicense: backCarLicenseImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await backCarLicenseImage!
                                            .readAsBytes())),
                                frontDriveLicense: frontDriverLicenseImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await frontDriverLicenseImage!
                                            .readAsBytes())),
                                backDriveLicense: backDriverLicenseImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await backDriverLicenseImage!
                                            .readAsBytes())),
                                            vehicleImages: [...carImages.map((e) => e['base64'])],
                                            backIdentity: backIentityImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await backIentityImage!
                                            .readAsBytes())),
                                            frontIdentity: frontIentityImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await frontIentityImage!
                                            .readAsBytes())),
                                            frontResidence: frontResdinceImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await frontResdinceImage!
                                            .readAsBytes())),
                                            backResidence: backResdinceImage == null
                                    ? null
                                    : "data:image/png;base64,"+base64Encode(
                                        (await backResdinceImage!
                                            .readAsBytes())),
                                            
                                            
                              ),
                              context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 13),
                      child: Text(
                        'تسجيل',
                        style: TextStyle(fontSize: 20),
                      ),
                    )))),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "تسجيل",
            style: TextStyle(color: Colors.black),
          ),
          leading: Container(),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (image == null) {
                          SaiImagePicker.pickImage().then((value) {
                            setState(() {
                              image = value!['file'];
                            });
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('حذف الصورة؟'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'الغاء',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        image = null;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'تأكيد',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                          );
                        }
                      },
                      child: Center(
                          child: CircleAvatar(
                        radius: 80,
                        foregroundImage:
                            image == null ? null : FileImage(image!),
                        child: Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.white,
                        ),
                        backgroundColor: Color(0xffFF4100),
                      )),
                    ),
                    Container(
                      height: 10,
                    ),
                    TextField(controller: name,
                      decoration: InputDecoration(
                        
                          labelText: "اسم المستخدم",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "اسم المستخدم",
                          border: OutlineInputBorder()),
                    ),
                  
                    Container(
                      height: 10,
                    ),
                    CustomDropdownMenu(
                      onChange: (e) {
                        setState(() {
                          accountType = e;
                        });
                      },
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      'صور المركبة',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      controller: carImagesController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...carImages.mapIndexed((index, e) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ImageView(
                                        tag: index.toString(),
                                        image: e['file']),
                                  ))
                                      .then((value) {
                                    if (value == 'delete') {
                                      setState(() {
                                        carImages.removeAt(index);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Hero(
                                      tag: index.toString(),
                                      child: Image.file(e['file'])),
                                ),
                              )),
                          GestureDetector(
                            onTap: () {
                              SaiImagePicker.pickImage().then((value) {
                                if (value != null) {
                                  setState(() {
                                    carImages.add(value!);
                                  });
                                  carImagesController.jumpTo(carImagesController
                                          .position.maxScrollExtent *
                                      double.parse('1.${carImages.length}'));
                                }
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Center(
                                  child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Color(0xffFF4100))),
                                child: Icon(
                                  Icons.image,
                                  color: Color(0xffFF4100),
                                  size: 40,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      'صورة الهوية الامامية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                frontIentityImage = value['file'];
                              });
                            }
                          });
                        },
                        frontIentityImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              frontIentityImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة الهوية الخلفية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                backIentityImage = value['file'];
                              });
                            }
                          });
                        },
                        backIentityImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              backIentityImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة السكن الامامية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                frontResdinceImage = value['file'];
                              });
                            }
                          });
                        },
                        frontResdinceImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              frontResdinceImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة السكن الخلفية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                backResdinceImage = value['file'];
                              });
                            }
                          });
                        },
                        backResdinceImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              backResdinceImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة اجازة السوق الامامية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                frontDriverLicenseImage = value['file'];
                              });
                            }
                          });
                        },
                        frontDriverLicenseImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              frontDriverLicenseImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة اجازة السوق الخلفية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                backDriverLicenseImage = value['file'];
                              });
                            }
                          });
                        },
                        backDriverLicenseImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              backDriverLicenseImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة سنوية السيارة الامامية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                frontCarLicenseImage = value['file'];
                              });
                            }
                          });
                        },
                        frontCarLicenseImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              frontCarLicenseImage = null;
                            });
                          }
                        }),
                    Text(
                      'صورة سنوية السيارة الخلفية',
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleImage(
                        context,
                        () {
                          SaiImagePicker.pickImage().then((value) {
                            if (value != null) {
                              setState(() {
                                backCarLicenseImage = value['file'];
                              });
                            }
                          });
                        },
                        backCarLicenseImage,
                        (value) {
                          if (value == 'delete') {
                            setState(() {
                              backCarLicenseImage = null;
                            });
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector SingleImage(BuildContext context, onTap, File? image, onPop) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.3,
        width: MediaQuery.of(context).size.width * 0.5,
        child: image != null
            ? GestureDetector(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                            builder: (context) => ImageView(
                                tag: 'frontIdentityImage', image: image!),
                          ))
                          .then(onPop);
                    },
                    child: Hero(
                        tag: 'frontIdentityImage', child: Image.file(image!))))
            : Center(
                child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffFF4100))),
                child: Icon(
                  Icons.image,
                  color: Color(0xffFF4100),
                  size: 40,
                ),
              )),
      ),
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key, required this.onChange});

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
  final onChange;
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  int _selectedOption = 2; // Initially selected option

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(8)),
          width: MediaQuery.of(context).size.width * 0.97,
          padding: EdgeInsets.all(5),
          child: DropdownButton<int>(
            value: _selectedOption,
            onChanged: widget.onChange,
            items: [
              DropdownMenuItem<int>(
                value: 2,
                child: Text('تكسي'),
              ),
              DropdownMenuItem<int>(
                value: 3,
                child: Text('تكتك'),
              ),
              DropdownMenuItem<int>(
                value: 4,
                child: Text('كرين'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text('Selected option: $_selectedOption'),
      ],
    );
  }
}
