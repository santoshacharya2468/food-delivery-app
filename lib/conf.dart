import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodsNepal/screens/profile.dart';
import 'screens/login.dart';
import 'screens/register.dart';
const baseUrl="https://parewa.herokuapp.com/";
const apiKey="123#@!";
const appName="FoodsNepal";
class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case "login":
      return MaterialPageRoute(builder: (context)=>LoginPage());
      case "register":
      return MaterialPageRoute(builder: (context)=>Register());
      case "profile":
      return MaterialPageRoute(builder:(context)=>ProfilePage());
      default:
      return null;
    }
  }
}