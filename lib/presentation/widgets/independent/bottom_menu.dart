// Bottom menu widget for Open Flutter E-commerce App
// Author: openflutterproject@gmail.com
// Date: 2020-02-06

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openflutterecommerce/config/app_settings.dart';
import 'package:openflutterecommerce/config/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenFlutterBottomMenu extends StatelessWidget {
  final int menuIndex;

  OpenFlutterBottomMenu(this.menuIndex);

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? theme.accentColor : theme.primaryColorLight;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        image,
        height: 24.0,
        width: 24.0,
        color: colorByIndex(theme, index),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 10.0,
          color: colorByIndex(theme, index),
        ),
      ),
    );
  }
  BottomNavigationBarItem getItemImage(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        image,
        height: 24.0,
        width: 24.0
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color:  Color(0xFF2AA952),
        ),
      ),
    );
  }
  void launchWhatsApp(
      {@required int phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems =[
      getItem('assets/icons/bottom_menu/home.svg', 'Home', _theme, 0),
      getItem('assets/icons/bottom_menu/cart.svg', 'Shop', _theme, 1),
      getItem('assets/icons/bottom_menu/bag.svg', 'Bag', _theme, 2),
      getItem('assets/icons/bottom_menu/favorites.svg', 'Favorites',
          _theme, 3),
    ];
    if ( AppSettings.profileEnabled ) {
      menuItems.add(getItemImage(
        'assets/icons/bottom_menu/whatsapp.png', 'WhatsApp', _theme, 4));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: menuIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Navigator.pushNamed(context, OpenFlutterEcommerceRoutes.home);
                break;
              case 1:
                Navigator.pushNamed(context, OpenFlutterEcommerceRoutes.shop);
                break;
              case 2:
                Navigator.pushNamed(context, OpenFlutterEcommerceRoutes.cart);
                break;
              case 3:
                Navigator.pushNamed(
                    context, OpenFlutterEcommerceRoutes.favourites);
                break;
              case 4:
                launchWhatsApp(phone:971523195838,message: "Hey!I%20would%20like%20to%20know%20more%20about%20some%20parts");
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
