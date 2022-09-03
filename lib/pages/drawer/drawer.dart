import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soiree/auth.dart';
import 'package:soiree/utils/extension.dart';

import '../../Animation/slide_right_route.dart';
import '../../provider.dart';
import '../../style/colors.dart';
import '../../style/dimens.dart';
import '../../style/theme.dart';
import '../event/my_event_screen.dart';
import '../event/past_event_screen.dart';
import '../feedback/feedback_screen.dart';
import '../home_page_component/categories_screen.dart';
import '../login/login_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/contact_us_screen.dart';
import '../setting/help_screen.dart';
import '../setting/settings_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});
  @override
  _DrawerState createState() => _DrawerState();

}


class _DrawerState extends State<DrawerScreen> {






  @override
  Widget build(BuildContext context) {
    final AuthService? auth = Provider.of(context)?.auth;
    bool isConnected = auth!.isConnected();

    List<Widget> _getAuthItem () {
      return [
        const SizedBox(height: spacingContainer),
        InkWell(
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/man_profile.jpg',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text("Mario Matter",
                          maxLines: 1,
                          style: boldLargeTextStyle.copyWith(
                              color: Colors.white)),
                      Text("New York, US 10010",
                          maxLines: 1,
                          style: normalTextStyle.copyWith(
                              color: Colors.white))
                          .addMarginTop(spacingControl)
                    ]).addMarginLeft(spacingContainer)),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
            )
          ]).wrapPaddingAll(spacingContainer),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
                SlideRightRoute(page: const ProfileScreen()));
          },
        ),
        const SizedBox(height: spacingContainer),
        Container(
            height: 2, color: Colors.grey.withOpacity(0.5)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: spacingStandard),
              InkWell(
                child:
                _navItem('assets/menu.png', 'Categories'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const CategoriesScreen()));
                },
              ),
              const SizedBox(height: itemSpacing),
              InkWell(
                child:
                _navItem('assets/my_event.png', 'My Event'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const MyEventScreen()));
                },
              ),
              const SizedBox(height: itemSpacing),
              InkWell(
                child:
                _navItem('assets/feedback.png', 'Feedback'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const FeedbackScreen()));
                },
              ),
              const SizedBox(height: itemSpacing),
              InkWell(
                child:
                _navItem('assets/setting.png', 'Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const SettingsScreen()));
                },
              ),
              const SizedBox(height: itemSpacing),
              InkWell(
                child: _navItem(
                    'assets/contact_us.png', 'Contact Us'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const ContactUsScreen()));
                },
              ),
              const SizedBox(height: itemSpacing),
              InkWell(
                child: _navItem('assets/help.png', 'Help'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const HelpScreen()));
                },
              ),
            ],
          ).wrapPaddingAll(spacingContainer),
        ),
        InkWell(
          child: Text('Deconnexion',
              style: boldLargeTextStyle.copyWith(
                  color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: Border.all(
                        color: primaryColor,
                        width: borderWidth,
                        style: BorderStyle.solid),
                    backgroundColor: Colors.white,
                    title: Text(
                      'Deconnexion!',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal),
                    ),
                    // To display the title it is optional
                    content: Text(
                        'Etes vous sur de vouloir vous déconnecter?',
                        style: mediumTextStyle),
                    // Message which will be pop up on the screen
                    // Action widget which will provide the user to acknowledge the choice
                    actions: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation:
                              MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          0.0))),
                              backgroundColor:
                              MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: ()  {
                            Navigator.pop(context);
                          },
                          // function used to perform after pressing the button
                          child: Text('Fermer',
                              style: boldTextStyle),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation:
                              MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          0.0))),
                              backgroundColor:
                              MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () async {
                            await auth.signOut();
                            Navigator.pop(context);
                          },
                          child:
                          Text('Ok', style: boldTextStyle),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
        const SizedBox(height: itemSpacing)
      ];
    }

    List<Widget> _getItems() {
      return [
        const SizedBox(height: spacingContainer),
        InkWell(
          child: Row(children: [
            const Icon(
              Icons.login,
              size: 28,
              color: Colors.white,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text("Se connecter",
                          maxLines: 1,
                          style: boldLargeTextStyle.copyWith(
                              color: Colors.white))
                    ]).addMarginLeft(spacingContainer)),

          ]).wrapPaddingAll(spacingContainer),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
                SlideRightRoute(page: const LoginScreen()));
          },
        ),
        const SizedBox(height: spacingContainer),
        Container(
            height: 2, color: Colors.grey.withOpacity(0.5)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: itemSpacing),
              InkWell(
                child: _navItem(
                    'assets/contact_us.png', 'Contact Us'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const ContactUsScreen()));
                },
              ),
              const SizedBox(height: itemSpacing),
              InkWell(
                child: _navItem('assets/help.png', 'Help'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(SlideRightRoute(
                      page: const HelpScreen()));
                },
              ),
            ],
          ).wrapPaddingAll(spacingContainer),
        ),
      ];
    }


    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35)),
        child: SizedBox(
          width: defaultTargetPlatform == TargetPlatform.windows && kIsWeb
              ? 400
              : 304,
          child: Drawer(
            child: Container(
              color: primaryColor,
              child: Column(
                children: isConnected ? _getAuthItem() : _getItems(),
              ),
            ),
          ),
        ));
  }

  _navItem(String logoPath, String title) {
    return Row(children: [
      Image.asset(
        logoPath,
        height: 26,
        width: 26,
      ),
      Text(title, style: boldLargeTextStyle.copyWith(color: Colors.white))
          .addMarginLeft(spacingContainer)
    ]);
  }

}
