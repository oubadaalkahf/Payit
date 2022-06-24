import 'package:m_wallet_hps/models/userModel.dart';

abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppChangeBottomNavStates extends AppStates {}
class AppStepPageStates extends AppStates {}

class AppLoadingInitialStates extends AppStates {}

class AppLoginInitialStates extends AppStates {}

class AppLoginLoadingStates extends AppStates {}

class AppLoginSuccessStates extends AppStates {
  final UserModel userModel;
  AppLoginSuccessStates(this.userModel);
}

class AppLoginErrorStates extends AppStates {
   String error;
  AppLoginErrorStates(this.error);
}

class AppSigninLoadingStates extends AppStates {}

class AppSigninInitialStates extends AppStates {}

class AppSigninSuccessStates extends AppStates {



}

class AppSigninErrorStates extends AppStates {
  final String? error;
  AppSigninErrorStates(this.error);
}
class LoginSaveTokenInitialStates extends AppStates {}
class LoginSaveTokenErrorStates extends AppStates {}
class LoginSaveTokenSuccessStates extends AppStates {}


class LoadLoggedInUserInitial extends AppStates {}

class RemoveTokenInitialStates extends AppStates {}
class RemoveTokenSuccessStates extends AppStates {}
class RemoveTokenErrorStates extends AppStates {}



class LoadLoggedInUserSuccessStates extends AppStates {}
class LoadLoggedInUserErrorStates extends AppStates {}

class AppVirementInitialStates extends AppStates {}
class AppVirementLoadingStates extends AppStates {}
class AppVirementSuccessStates extends AppStates {}
class AppVirementErrorStates extends AppStates {}


class AppVersementInitialStates extends AppStates {}
class AppVersementLoadingStates extends AppStates {}
class AppVersementSuccessStates extends AppStates {}
class AppVersementErrorStates extends AppStates {}

class AppChangeStates extends AppStates {}


class AppRefreshStates extends AppStates {}
class AppRefreshStatesStop extends AppStates {}

class AppVerifyPhoneInitStates extends AppStates {}
class AppVerifyPhoneSuccessStates extends AppStates {

}
class AppVerifyPhoneErrorStates extends AppStates {
  final String error;
  AppVerifyPhoneErrorStates(this.error);
}


class AppVerifyCinInitStates extends AppStates {}
class ChangeStates extends AppStates {}
class AppVerifyCinSuccessStates extends AppStates {

}
class AppVerifyCinErrorStates extends AppStates {
  final String error;
  AppVerifyCinErrorStates(this.error);
}

class AppSendOtpInitialState extends AppStates {}
class AppChangeValidPhone extends AppStates {}
class AppChangeValidCin extends AppStates {}
class AppSendOtpSuccessState extends AppStates {
  final String message;
  AppSendOtpSuccessState(this.message);
}
class AppSendOtpErrorState extends AppStates {}

class AppVerifyOtpErrorState extends AppStates {
  final String error;
  AppVerifyOtpErrorState(this.error);
}
class AppVerifyOtpSuccessState extends AppStates {
  final String message;
  AppVerifyOtpSuccessState(this.message);
}
class AppVerifyOtpInitialState extends AppStates {}
