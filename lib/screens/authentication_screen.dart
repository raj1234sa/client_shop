
import 'package:client_shop/models/user.dart';
import 'package:client_shop/screens/product_list.dart';
import 'package:client_shop/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  static const ROUTE_NAME='authentication';
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLoggedIn=false;

  Future<void> checkAuthentication()async{

    User user = await SharedPref.readUserFromSharedRef('loggedInUser');
    if(user!=null){
      setState(() {
        isLoggedIn=true;
        print('logged in user :$user');
      });
    }else{
      setState(() {
        isLoggedIn=false;
        print('no Logged in user ');
      });
    }
  }
  @override
  void initState() {
    checkAuthentication();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoggedIn?ProductListScreen():LoginScreen();
  }
}
