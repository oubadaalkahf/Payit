import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';

import 'package:m_wallet_hps/screens/SignUp1/OTP.dart';
import 'package:m_wallet_hps/shared/component.dart';

import 'custom_page_route.dart';

class SignupPage1 extends StatelessWidget {
  static String id = "SignupScreen1";

  const SignupPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    var phonenumberController = TextEditingController();

    var cinController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppVerifyPhoneSuccessStates ){
        
        }
        if(state is AppVerifyCinErrorStates  )
        {
          showToast(message: state.error);
        }
        if(state is AppVerifyPhoneErrorStates  )
        {
          showToast(message: state.error);
        }
      },
      builder: (context, state) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blueGrey,
              title: Row(children: <Widget>[
                Text(
                  "  Ativation",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                )
              ])),
          backgroundColor: Colors.blueGrey,
          body: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 22),
            child: Form(
              onChanged: (){
                AppCubit.get(context).changeValidphoneTofalse();
                AppCubit.get(context).changeValidCinTofalse();

              },
              key: formkey,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 55, right: 55, top: 70, bottom: 30),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'STEP 1 : Identification ',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Enter your phone number and your CIN ',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phonenumberController,
                              validator: (value) {
                                AppCubit.get(context).verifyPhone(phonenumberController.text);
                                print(AppCubit.get(context).validPhone);
                                if (value!.isEmpty ) {
                                  return "the Phone number must not be empty";
                                }
                                else if(AppCubit.get(context).validPhone == false){
                                  return "phone number Already Exist";
                                }

                              },

                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                ),
                                hintText: 'Phone number ',
                                fillColor: const Color(0xff243656),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 22),
                            child: TextFormField(
                              controller: cinController,

                              validator: (value) {
                                AppCubit.get(context).verifyCin(cinController.text);
                                if (value!.isEmpty) {
                                  return "the CIN must not be empty";
                                }else if(AppCubit.get(context).validCin ==false)
                                  {
                                    return    "the CIN is Already Exist";
                                  }

                              },
                              onEditingComplete: (){
                                AppCubit.get(context).verifyCin(cinController.text);
                                print("hnaaaaaaaaa");
                              },
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: 'CIN',
                                fillColor: const Color(0xff243656),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'By continuing, you agree to the terms and conditions of use ',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 170,
                          ),


                           Button(() {

                             if (formkey.currentState!.validate()) {
                               AppCubit.get(context)
                                   .sendOtp(phonenumberController.text);
                               Navigator.of(context)
                                   .push(CustomPageRoute(child: OTP()));
                               AppCubit.get(context).phone_number =
                                   phonenumberController.text;
                               AppCubit.get(context).cin =
                                   cinController.text;


                             }

                           },)

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget Button(fonction) => Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1546A0).withOpacity(0.5),
            offset: const Offset(0, 24),
            blurRadius: 50,
            spreadRadius: -18,
          ),
        ],
      ),
      child: RaisedButton(
        onPressed: fonction,
        textColor: const Color(0xffFFFFFF),
        padding: const EdgeInsets.all(0),
        shape: const StadiumBorder(),
        child: Container(
          width: 275,
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Colors.green,
                Color(0xff1546A0),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NEXT',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const Icon(Icons.navigate_next)
            ],
          ),
        ),
      ),
    );
