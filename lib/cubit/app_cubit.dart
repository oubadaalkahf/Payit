import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/models/ErrorResponse.dart';
import 'package:m_wallet_hps/models/responseMessage.dart';
import 'package:m_wallet_hps/models/userModel.dart';
import 'package:m_wallet_hps/network/local/cache_helper.dart';
import 'package:m_wallet_hps/network/remote/dio_helper.dart';
import 'package:m_wallet_hps/screens/OTP/Confirmation2.dart';
import 'package:m_wallet_hps/screens/SignUp1/SignUpPage1.dart';
import 'package:m_wallet_hps/screens/SignUp1/SignUpPage2.dart';
import 'package:m_wallet_hps/screens/new_profile_page.dart';



import 'package:m_wallet_hps/screens/transferPage.dart';

import '../screens/AcccueilScreen.dart';

class AppCubit extends Cubit<AppStates> {
  bool verified = false;
  bool? validPhone ;
  bool? validCin = false;
  AppCubit() : super(AppInitialStates());

  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? cin;
  String? phone_number;
  static AppCubit get(context) => BlocProvider.of(context);
  static late Widget widget;
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    AcccueilScreen(),
    FirstRoute(),
    NewProfilePage(),
  ];
  List<Widget> register = [
    SignupPage1(),
    SignupPage2(),
    Confirmation2(),
  ];

  int currentStep = 0;

  void changeStep(index) {
    currentStep = currentStep + 1;
    emit(AppStepPageStates());
  }

  static List<String> banks = <String>['cih', 'attijari', 'sgma'];
  String element = banks.first;
  void changeBank(newvalue) {
    element = newvalue;
    emit(AppChangeBottomNavStates());
  }

  void changeBottom(index) {
    currentIndex = index;
    emit(AppChangeBottomNavStates());
  }

  UserModel? userModel;
  void userLogin({required String phone_number, required String password}) {
    emit(AppLoginInitialStates());
    DioHelper.postDataLogins(
      url: "login",
      data: {
        'phone_number': phone_number,
        'password': password,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(AppLoginSuccessStates(userModel!));
      emit(LoginSaveTokenInitialStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorStates("Login Failed"));
    });
  }
void changeValidphoneTofalse(){
    validPhone = false;
    emit(AppChangeValidPhone());
}
  void changeValidCinTofalse(){
    validCin = false;
    emit(AppChangeValidCin());
  }

  void userSignUp({
    required String? email,
    required String? phoneNumber,
    required String? password,
    required String? firstName,
    required String? lastName,
    required String? cin,
  }) {
    emit(AppSigninInitialStates());

    DioHelper.postData(
      url: "registration",
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'cin': cin,
      },
    ).then((value) {
      try {
        userModel = UserModel.fromJson(value.data);
        emit(AppSigninSuccessStates());
      } catch (e) {
        ErrorResponse error = ErrorResponse.fromJson(value.data);
        print(error.message);
        emit(AppSigninErrorStates(error.message.toString()));
      }
    }).catchError((error) {});
  }

  void addTokenToUser(email, deviceToken) {
    emit(LoginSaveTokenInitialStates());

    DioHelper.postDataLogins(
        url: "fcm_token",
        data: {"email": email, "fcmToken": deviceToken}).then((value) {
      emit(LoginSaveTokenSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(LoginSaveTokenErrorStates());
    });
  }

  void removeFcmToken(email, swift) {
    emit(RemoveTokenInitialStates());

    DioHelper.postDataLogins(
      url: "remove_fcm_token?swift=$swift&user_email=$email",
      data: {},
    ).then((value) {
      emit(RemoveTokenSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(RemoveTokenErrorStates());
    });
  }

  void loadLoggedInUser(email) {
    userModel = null;
    if (email != null) {
      emit(LoadLoggedInUserInitial());

      DioHelper.getData(url: "user?email=$email").then((value) {
        //  print(value.data);
        userModel = UserModel.fromJson(value.data);
        emit(LoadLoggedInUserSuccessStates());
      }).catchError((error) {
        if (error is DioError) {
          print(error.message);
        }
        emit(LoadLoggedInUserErrorStates());
      });
    }
  }

  void Makevirement(montant, destinataire, message, emetteur) {
    String operation_type = "virement";
    emit(AppVirementInitialStates());
    DioHelper.postData(url: "transfer/operation", data: {
      "operation_type": operation_type,
      "montant": montant,
      "emetteur": emetteur,
      "destinataire": destinataire,
      "message": message
    }).then((value) {
      loadLoggedInUser(CacheHelper.getData(key: 'email'));
      emit(AppVirementSuccessStates());
      changeBottom(0);
    }).catchError((error) {
      emit(AppVirementErrorStates());
    });
  }

  void sendOtp(String phone) {
    emit(AppSendOtpInitialState());
    DioHelper.postData(url: "otp/send", data: {"phoneNumber": phone})
        .then((value) {
      print("OTP SEND SUCCESS");
      emit(AppSendOtpSuccessState(value.data));
    }).catchError((error) {
      print(error.toString());
      emit(AppSendOtpErrorState());
    });
  }

  void verifyOtp(String otp) {
    emit(AppVerifyOtpInitialState());
    DioHelper.postData(
        url: "otp/verify",
        data: {"phoneNumber": phone_number, "otp": otp}).then((value) {
      verified = true;
      emit(AppVerifyOtpSuccessState(value.data));
    }).catchError((error) {
      emit(AppVerifyOtpErrorState(error.toString()));
      print(error.toString());
    });
  }

  void makeVersement(montant, message, emetteur) {
    String operation_type = "versement";
    emit(AppVersementInitialStates());
    DioHelper.postData(url: "transfer/operation", data: {
      "operation_type": operation_type,
      "montant": montant,
      "emetteur": emetteur,
      "message": message
    }).then((value) {
      loadLoggedInUser(CacheHelper.getData(key: 'email'));
      emit(AppVersementSuccessStates());
      userModel = null;
    }).catchError((error) {
      emit(AppVersementErrorStates());
    });
  }

  void changeState() {
    emit(AppChangeStates());
  }
  void verifyPhone(phone){

    emit(AppVerifyOtpInitialState());
    DioHelper.getData(url: "verifypn?phone_number=$phone").then((value) {
      ResponseMessage resp = ResponseMessage.fromJson(value.data) ;

      if(resp.message.contains("true")){
        emit(AppVerifyPhoneErrorStates("phone number Already Exist"));

      }
      else {
        validPhone = true;

        emit(AppVerifyPhoneSuccessStates());

      }
    });
  }

  void verifyCin(cin){
    print(cin);
    emit(AppVerifyOtpInitialState());
    DioHelper.getData(url: "verifycin?cin=$cin").then((value) {
   ResponseMessage resp = ResponseMessage.fromJson(value.data) ;
   if(resp.message.compareTo("true")==0){
     emit(AppVerifyCinErrorStates("Cin Already Exist"));
   }
   else {
     validCin = true;
     emit(AppVerifyCinSuccessStates());

   }
    });
  }

  void changeStates(){
    emit(ChangeStates());
  }

}

bool jwtVerification(String token) {
  DateTime? expiryDate = Jwt.getExpiryDate(token);

  DateTime now = DateTime.now();
  if (expiryDate!.compareTo(now) < 0) {
    return true;
  } else {
    return true;
  }






}
