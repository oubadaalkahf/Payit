import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/cubit/bloc_observer.dart';
import 'package:m_wallet_hps/network/remote/dio_helper.dart';
import 'package:m_wallet_hps/screens/AcccueilScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:m_wallet_hps/screens/home_page.dart';
import 'package:m_wallet_hps/screens/login_page.dart';
import 'package:m_wallet_hps/screens/SignUp1/SignUpPage1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:m_wallet_hps/shared/component.dart';
import 'network/local/cache_helper.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  await CacheHelper.init();
  DioHelper.init();

  String? token;

  try {
    token = CacheHelper.getData(key: 'token');
  } catch (e) {
    print(e);
  }
  print('token is ');
  print(token);

  if (token == null) {
    AppCubit.widget = const LoginPage();
  } else if (jwtVerification(token) == true) {
    print(jwtVerification(token));
    AppCubit.widget = const HomePage();
  } else {
    AppCubit.widget = const LoginPage();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  _MyAppState();

  @override
  initState() {
    super.initState();
    this.initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      showToast(message: "Email Verified");
      Get.to(() => LoginPage());
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppCubit()
                ..loadLoggedInUser(CacheHelper.getData(key: 'email'))),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if(state is LoadLoggedInUserErrorStates){
              Get.off(() => LoginPage());

            }
          },
          builder: (context, state) => GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              splashIconSize: 500,
              // nextScreen: SignupPagePage(),
              nextScreen: AppCubit.widget,
              backgroundColor: Colors.white,
              splashTransition: SplashTransition.fadeTransition,
              duration: 3000,
              splash: Center(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Payit.png'),
                        ),
                      ),
                    ),
                    TyperAnimatedTextKit(
                      text: const ["Discover The Future \n With US..."],
                      textStyle: GoogleFonts.manrope(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                      speed: Duration(milliseconds: 100),
                    ),
                   const Spacer(),
                    const CircularProgressIndicator(
                        backgroundColor: Colors.green,
                        color: Color(0xff4c6611)),
                  ],
                ),
              ),
            ),
            routes: {
              SignupPage1.id: (context) => SignupPage1(),
              LoginPage.id: (context) => const LoginPage(),
              // HomePage.id: (context) => const HomePage(),

              AcccueilScreen.id: (context) => AcccueilScreen(),
            },
          ),
        ));
  }
}
