import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';

import 'package:m_wallet_hps/screens/EmailConfirmationPage.dart';

import 'package:m_wallet_hps/shared/component.dart';


class SignupPage3 extends StatefulWidget {
  static String id = "SignupScreen";

  const SignupPage3({Key? key}) : super(key: key);

  @override
  State<SignupPage3> createState() => _SignupPage3State();
}

class _SignupPage3State extends State<SignupPage3> {
  final jobRoleCtrl = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool _isObscure = true;
  var passwordRegController = TextEditingController();
  var passwordConfRegController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

        if (state is AppSigninSuccessStates) {
          showToast(message: "registrated");
          navigateAndFinish(context, const EmailConfirmationPage());
        } else if (state is AppSigninErrorStates) {
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 22),
            child: Form(
              key: formkey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: MediaQuery.of(context).size.height/1.2,
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
                            'STEP 4 : Security ',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Enter your new password twice',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 22),
                            child: TextFormField(

                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the Password must not be empty";
                                }
                                return null;
                              },
                              controller: passwordRegController,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.password,
                                  color: Colors.green,
                                ),
                                hintText: 'Password',
                                suffixIcon: IconButton(


                                  icon: Icon(

                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                    color: _isObscure ?  Colors.green :Colors.grey ,

                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                fillColor:  Color(0xff243656),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                ),
                              ),
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.only(top: 22),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the Password must not be empty";
                                }
                                return null;
                              },
                              controller: passwordConfRegController,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.password,
                                  color: Colors.green,
                                ),
                                hintText: 'Confirm password',
                                suffixIcon: IconButton(


                                  icon: Icon(

                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                    color: _isObscure ?  Colors.green :Colors.grey ,

                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                fillColor:  Color(0xff243656),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                ),
                              ),
                            ),

                          ),

                          const SizedBox(
                            height: 210,
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
                              onPressed: () {
                                if(formkey.currentState!.validate()){
                                  AppCubit.get(context).userSignUp(email: AppCubit.get(context).email,
                                      phoneNumber: AppCubit.get(context).phone_number,
                                      password: passwordRegController.text,
                                      firstName: AppCubit.get(context).firstName,
                                      lastName: AppCubit.get(context).lastName,
                                      cin: AppCubit.get(context).cin);
                                }
                              },
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
                                      'CREATE',
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
