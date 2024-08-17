
import 'package:belajar_flutter_2/View/home_screen.dart';
import 'package:belajar_flutter_2/View/login_screen.dart';
import 'package:belajar_flutter_2/View/map_screen.dart';
import 'package:belajar_flutter_2/View/profile_screen.dart';
import 'package:belajar_flutter_2/View/register_screen.dart';
import 'package:belajar_flutter_2/View/splash_screen.dart';
import 'package:belajar_flutter_2/View/trip_screen.dart';
import 'package:belajar_flutter_2/View/welcome_screen.dart';
import 'package:get/get.dart';

import 'View/walkthrough_screen.dart';
List<GetPage<dynamic>> routes = [
  GetPage(name: "/", page: ()=>const SplashScreen()),
  GetPage(name: "/walkthrough", page: ()=>const WalkthroughScreen()),
  GetPage(name: "/welcome", page: ()=>const WelcomeScreen()),
  GetPage(name: "/login", page: ()=>const LoginScreen()),
  GetPage(name: "/register", page: ()=> RegisterScreen()),
  GetPage(name: "/main", page: ()=> HomeScreen()),
  GetPage(name: "/profile", page: ()=> const ProfileScreen()),
  GetPage(name: '/truck', page: ()=>TripScreen()),
  GetPage(name: '/maps', page: ()=>MapScreen()),
];