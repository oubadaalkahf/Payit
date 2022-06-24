import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/screens/home_page.dart';
import 'package:m_wallet_hps/shared/component.dart';



class VersementScreen extends StatelessWidget {
  const VersementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageController  = TextEditingController();
    var montantController  = TextEditingController();
    return BlocConsumer<AppCubit,AppStates>( listener: (context,state){
      if(state is AppVersementSuccessStates){
        showToast(message: "Versement complet");
        navigateAndFinish(context,HomePage());
      }
    },builder: (context,state){
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
                    decoration:  InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0),

                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      //add prefix icon

                      hintStyle: const TextStyle(

                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.white),
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
                    onTap: (){


                      String? emetteur = AppCubit.get(context).userModel!.data?.phoneNumber;
                      AppCubit.get(context).makeVersement(montantController.text,messageController.text, emetteur);

                    },
                    child: Ink(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Text('Checkout',style: TextStyle(color: Colors.white),),alignment: Alignment.center,),
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
            'VERSEMENT',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xff1546A0), fontSize: 25),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: TextFormField(
                        controller: montantController,
                        keyboardType: TextInputType.number,
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                        textAlign: TextAlign.center,
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
                    ),
                    const    SizedBox(
                      height: 10,
                    ),


                    const     SizedBox(
                      height: 15,
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
