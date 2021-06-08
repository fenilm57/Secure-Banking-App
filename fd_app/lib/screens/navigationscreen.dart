import 'package:fd_app/models/account.dart';
import 'package:fd_app/models/fd.dart';
import 'package:fd_app/screens/aboutus.dart';
import 'package:fd_app/screens/account_display.dart';
import 'package:fd_app/screens/fd_display.dart';
import 'package:fd_app/screens/show_dialogscreen.dart';
import 'package:fd_app/widgets/image.dart';
import 'package:fd_app/widgets/navigation_title.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'homepage.dart';

class NavigationDrawerScreen extends StatelessWidget {
  final List<Fd> fdList;
  final List<Account> accountList;
  final databaseFD;
  final databaseAccount;

  NavigationDrawerScreen(
      {this.accountList, this.fdList, this.databaseAccount, this.databaseFD});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: HexColor('#E8816D'),
        child: Column(
          children: [
            ImagePick(),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        bool isNewRouteSameAsCurrent = false;
                        Navigator.popUntil(context, (route) {
                          if (route.settings.name == HomePage.routeName) {
                            isNewRouteSameAsCurrent = true;
                            Navigator.pop(context);
                          }
                          return true;
                        });
                        if (!isNewRouteSameAsCurrent) {
                          Navigator.popAndPushNamed(
                            context,
                            HomePage.routeName,
                          );
                        }
                      },
                      child: Text(
                        'Your Bank',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  NavigationTitle(
                    title: 'Accounts',
                    icon: Icons.account_balance_sharp,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ShowDialogScreen(0);
                      }));
                    },
                  ),
                  NavigationTitle(
                    title: 'Fixed Deposit',
                    icon: Icons.monetization_on,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ShowDialogScreen(1);
                      }));
                    },
                  ),
                  NavigationTitle(
                    title: 'About Us',
                    icon: Icons.person,
                    onPressed: () {
                      bool isNewRouteSameAsCurrent = false;
                      Navigator.popUntil(context, (route) {
                        if (route.settings.name == AboutUs.routeName) {
                          isNewRouteSameAsCurrent = true;
                          Navigator.pop(context);
                        }
                        return true;
                      });
                      if (!isNewRouteSameAsCurrent) {
                        Navigator.popAndPushNamed(context, AboutUs.routeName);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
