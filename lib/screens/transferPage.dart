import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';

import 'package:m_wallet_hps/screens/home_page.dart';
import 'package:m_wallet_hps/shared/component.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../cubit/app_cubit.dart';

class FirstRoute extends StatefulWidget {
  FirstRoute({key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  var montantController = TextEditingController();

  var destinataireController = TextEditingController();

  var messageController = TextEditingController();
  String scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
      destinataireController.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is LoadLoggedInUserSuccessStates) {
        navigateAndFinish(context, HomePage());
        AppCubit.get(context).currentIndex = 0;
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: messageController,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0),

                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      //add prefix icon

                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      //create lable
                      labelText: '  Motif',
                      //lable style
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      print(destinataireController.text);
                      print(montantController.text);
                      print(messageController.text);
                      String? emetteur =
                          AppCubit.get(context).userModel!.data?.phoneNumber;

                      showMyDialog(
                          context: context,
                          destinataireController: destinataireController.text,
                          montantController: montantController.text,
                          messageController: messageController.text,
                          emetteur: emetteur);
                    },
                    child: Ink(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Text(
                          'SEND',
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          title: const Text(
            'VIREMENT',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color:Color(0xff1546A0),
                fontSize: 25),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: montantController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35),
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "0,00 MAD",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextDropdownFormField(
                      options: [
                        "MONSIEUR ${AppCubit.get(context).userModel?.data?.firstName.toUpperCase()}  ${AppCubit.get(context).userModel?.data?.lastName.toUpperCase()}  \n ${AppCubit.get(context).userModel?.data?.phoneNumber}"
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          labelText: "Compte Source"),
                      dropdownHeight: 120,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: destinataireController,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Compte Destinataire',
                        suffixIcon: IconButton(
                            onPressed: () {
                              print("hi");

                              scanQR();

                              print("hihiiiiiiiiiii");
                              print(destinataireController.text);
                            },
                            icon: Icon(
                              Icons.qr_code_scanner,
                              color: Colors.green,
                            )),
                        //lable style
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
