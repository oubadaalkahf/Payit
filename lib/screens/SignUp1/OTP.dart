import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';

import 'package:m_wallet_hps/screens/SignUp1/SignUpPage2.dart';

import 'package:m_wallet_hps/shared/component.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'custom_page_route.dart';

class OTP extends StatelessWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    snackBar(String? message) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    final jobRoleCtrl = TextEditingController();

    final formkey = GlobalKey<FormState>();

    bool _isObscure = true;

    var otpController = OtpFieldController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppVerifyOtpSuccessState) {
          showToast(message: state.message);
        } else if (state is AppVerifyOtpErrorState) {
          showToast(message: "otp incorrect");
          otpController.clear();
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
                            'STEP 2 : Validation ',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Enter the code sent to 0687171739 ',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            height: 190,
                            width: 190,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/OTPP.png'))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          OTPTextField(
                            controller: otpController,
                            length: 5,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 40,
                            style: TextStyle(fontSize: 17),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              AppCubit.get(context).verifyOtp(pin);
                            },

                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive the code? ",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () => snackBar("OTP resend!!"),
                                child: const Text(
                                  "RESEND",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 110,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff1546A0).withOpacity(0.5),
                                  offset: const Offset(0, 24),
                                  blurRadius: 50,
                                  spreadRadius: -18,
                                ),
                              ],
                            ),
                            child: RaisedButton(
                              onPressed: AppCubit.get(context).verified
                                  ? () {
                                   Navigator.of(context).push(
                                        CustomPageRoute(child: SignupPage2()),
                                      );
                                    }
                                  : null,
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
                          ),
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
