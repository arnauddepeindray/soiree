
import 'package:flutter/material.dart';
import 'package:soiree/auth.dart';
import 'package:soiree/pages/login/login_screen.dart';
import 'package:soiree/utils/messageProvider.dart';

import '../Animation/slide_right_route.dart';
import '../pages/event/addParty/add.dart';
import '../provider.dart';
import '../style/colors.dart';

class WidgetProvider extends StatelessWidget {
  final String name;
  const WidgetProvider({required this.name});


  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context)!.auth;
    bool isConnected = auth.isConnected();
    final MessageProvider messageProvider = Provider.of(context)!.messageProvider;

    List<WidgetEntries> listAuth = [
        new WidgetEntries(name: "add_party-Icon", widget: InkWell(
          child: const Icon(Icons.add,
              color: primaryColor, size: 32),
          onTap: () {
            if(!isConnected){
              messageProvider.createMessage("Erreur d'authentification","Vous devez être connecter pour créer une soirée");
              Navigator.of(context).push(
                  SlideRightRoute(page: LoginScreen()));
            }
            else{
              Navigator.of(context).push(
                  SlideRightRoute(page: AddParty()));
            }

          },
        ),)
      ];

    return listAuth.firstWhere((element) => element.name == this.name).widget;
  }

}



class WidgetEntries {

  final String name;

  final Widget widget;

  const WidgetEntries({required this.name, required this.widget});

}