import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:badges/badges.dart';
import 'package:fluttertoast/fluttertoast.dart';

// My Own Import
import 'package:soiree/pages/home_page_component/drawer.dart';
import 'package:soiree/pages/home_page_component/category_grid.dart';
import 'package:soiree/pages/home_page_component/best_offer_grid.dart';
import 'package:soiree/pages/home_page_component/top_seller_grid.dart';
import 'package:soiree/pages/home_page_component/best_deal.dart';
import 'package:soiree/pages/home_page_component/featured_brands.dart';
import 'package:soiree/pages/home_page_component/block_buster_deal.dart';
import 'package:soiree/pages/home_page_component/ListParty.dart';
import 'package:soiree/pages/home_page_component/womens_collection.dart';
import 'package:soiree/pages/login.dart';
import 'package:soiree/pages/notifications.dart';
import 'package:soiree/pages/category/top_offers.dart';
import 'package:soiree/Animation/slide_left_rout.dart';
import 'package:soiree/pages/cart.dart';
import 'package:soiree/pages/party/add.dart';
import 'package:soiree/pages/search.dart';
import 'package:soiree/utils/messageProvider.dart';
import 'package:soiree/widget/dialog.dart';

import '../auth.dart';
import '../provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime currentBackPressTime;


  //BAR EN TETE APPLICATION
  @override
  Widget build(BuildContext context) {

    final AuthService auth = Provider.of(context).auth;
    bool isConnected = auth.isConnected();

    MessageProvider messageProvider = Provider.of(context).messageProvider;


    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      appBar: AppBar(
        title: Text(
          'RAFPLES',
          style: TextStyle(
            fontFamily: 'Pacifico',
          ),
        ),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              if(isConnected){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddParty()));
              }
              else{
                messageProvider.createMessage("Erreur d'authentification","Vous devez être connecter pour créer une soirée");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login()));

              }

            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          IconButton(
            icon: Badge(
              badgeContent: Text('2'),
              badgeColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
          ),
          IconButton(
            icon: Badge(
              badgeContent: Text('3'),
              badgeColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(context, SlideLeftRoute(page: CartPage()));
            },
          ),
        ],
      ),

      // Drawer Code Start Here

      drawer: MainDrawer(),

      // Drawer Code End Here
      body: WillPopScope(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),

            //List party
            ListParty(),
            //Best of Fashion End Here

          ],
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } else {
      return true;
    }
  }
}
