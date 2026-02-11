
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AuthControllers authControllers = Get.find<AuthControllers>();

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 1));

    bool isUserLoggedIn = await authControllers.checkAuthState();

    if(mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isUserLoggedIn
              ? const MainBottomNavScreen()
              : const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
           child: SvgPicture.asset(AssetPaths.logoSvg,
             width: 140,
          )
        )
      ),

    );
  }
}
