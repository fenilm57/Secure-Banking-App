import 'package:fd_app/models/account.dart';
import 'package:fd_app/models/fd.dart';
import 'package:fd_app/screens/account_screen.dart';
import 'package:fd_app/screens/fd_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'navigationscreen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  final databaseFD;
  final databaseAccount;
  final databaseNames;
  final databaseBankNames;

  HomePage(this.databaseAccount, this.databaseFD, this.databaseNames,
      this.databaseBankNames);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E8816D'),
      drawer: NavigationDrawerScreen(
        databaseAccount: widget.databaseAccount,
        databaseFD: widget.databaseFD,
      ),
      appBar: AppBar(
        title: Text('FD App'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'images/bg.png',
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12, right: 10),
                        child: Text(
                          'Bank Account',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Switch(
                        value: value,
                        onChanged: (valued) {
                          setState(() {
                            value = valued;
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12, left: 10),
                        child: Text(
                          'FD Details',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  value
                      ? FdScreen(widget.databaseFD, widget.databaseAccount,
                          widget.databaseNames, widget.databaseBankNames)
                      : AccountScreen(widget.databaseFD, widget.databaseAccount,
                          widget.databaseNames, widget.databaseBankNames),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
