import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/models/userModel.dart';
import 'package:m_wallet_hps/network/local/cache_helper.dart';
import 'package:m_wallet_hps/shared/buttons.dart';
import 'package:m_wallet_hps/shared/component.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'login_page.dart';


class NewProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String swift =CacheHelper.getData(key: 'swift');
    UserModel? userModel = AppCubit.get(context).userModel;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(backgroundColor: Color(0xff4c91bc),
            elevation: 2,
            actions: [
              IconButton(
                  onPressed:(){
                    CacheHelper.removeData(key: 'token');
                    CacheHelper.removeData(key: 'email');

                    navigateAndFinish(context, LoginPage());
                    AppCubit.get(context).currentIndex=0;
                  },

                  icon: Icon(Icons.logout_outlined))
            ],
            title:  Text('Profile',
              style:  GoogleFonts.pragatiNarrow(
                letterSpacing: 0.5,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w100
                ),
              ),
            ),
          ),
          body:  Column(
            children: [
              Container(
                color: Color(0xff4c91bc),
                child: Expanded(

                  flex : 1,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          QrImage(foregroundColor: Colors.white,data: "${AppCubit.get(context).userModel?.data?.phoneNumber}",size: 100,),

                          Text("${userModel?.data?.solde} DH" , style:  GoogleFonts.pragatiNarrow(
                            letterSpacing: 0.5,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal
                            ),
                          ),),

                        ],
                      ),
                    ),

                  ),
                ),
              ),


              Expanded(
                flex : 4,
                child: Column(
                  children: [

                    SizedBox(height: 20,),
                    RowBuilder(att: "First Name",text: "${userModel?.data?.firstName.toUpperCase()}"),
                    SizedBox(height: 25,),
                    RowBuilder(att: "Last Name",text: "${userModel?.data?.lastName.toUpperCase()}"),
                    SizedBox(height: 25,),
                    RowBuilder(att: "E-mail",text: "${userModel?.data?.email.toUpperCase()}"),
                    SizedBox(height: 25,),
                    RowBuilder(att: "Phone Number",text: "${userModel?.data?.phoneNumber}"),
                    SizedBox(height: 25,),
                    RowBuilder(att: "Banque",text: swift.toUpperCase()),


                  ],
                ),
              ),
            ],
          ),
        ));
  }
}





Widget RowBuilder({
  required String text,
  required String att,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 15,right: 15),
    child: Container(

      height: 35,
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 0.5,

            ),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            att,
            style:  GoogleFonts.pragatiNarrow(
              letterSpacing: 0.5,
              textStyle: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          Spacer(),
          Text(
            text,
            style:  GoogleFonts.pragatiNarrow(
              letterSpacing: 0.5,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
        ],
      ),
    ),
  );

}

