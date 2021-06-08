import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'navigationscreen.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      drawer: NavigationDrawerScreen(),
      body: Container(
        color: HexColor('#E8816D'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'To World\'s Best Daddy',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'by- Fenil Mehta',
              style: TextStyle(
                fontSize: 25,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
