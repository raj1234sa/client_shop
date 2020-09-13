
import 'package:client_shop/screens/authentication_screen.dart';
import 'package:client_shop/services/auth_service.dart';
import 'package:client_shop/services/network_service.dart';
import 'package:client_shop/utils/dialogues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final TextStyle itemStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            arrowColor: Colors.transparent,
            onDetailsPressed: () {
              // Navigator.of(context).pushNamed(ProfileScreen.ROUTE_NAME);
            },
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            accountName: Text(
              'Abhishek Jain',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              'abhi@gmail.com',
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: Hero(
              tag: 'image',
              child: GestureDetector(
                onTap: (){
                  // Navigator.of(context).pushNamed(ProfileScreen.ROUTE_NAME);

                },
                child: CircleAvatar(
                  child: Image.asset(
                    'assets/images/as.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black87,
            ),
            title: Text('Home', style: itemStyle),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
            },
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            leading: Icon(
              Icons.vpn_key,
              color: Colors.black87,
            ),
            title: Text(
              'Change Password',
              style: itemStyle,
            ),
            onTap: () {
              Navigator.of(context).pop();

              // Navigator.of(context).pushNamed(ChangePasswordScreen.ROUTE_NAME);
            },
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black87,
            ),
            title: Text(
              'Settings',
              style: itemStyle,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(SettingScreen.ROUTE_NAME);
            },
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: Colors.black87,
            ),
            title: Text(
              'Contact Us',
              style: itemStyle,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(ContactUsScreen.ROUTE_NAME);
            },
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            title: Text(
              'Logout',
              style: itemStyle,
            ),
            onTap: () async {
              if (await NetworkService.checkDataConnectivity()) {
                bool result = await showSimpleDialogue(
                        context: context,
                        message: 'Are you sure you want to log out ?') ??
                    false;
                if (result) {
                  if (await AuthService.signOut()) {
                    Navigator.of(context)
                        .pushReplacementNamed(AuthenticationScreen.ROUTE_NAME);
                  } else {
                    await showSimpleDialogue(
                      context: context,
                      message: 'Some error occurred',
                      showTwoActions: false,
                    );
                  }
                } else {
                  Navigator.of(context).pop();
                }
              } else {
                await showSimpleDialogue(
                  context: context,
                  message: 'Please check your internet connection...',
                  showTwoActions: false,
                );
              }
            },
          ),
          Divider(
            height: 0.0,
          ),
        ],
      ),
    );
  }
}
