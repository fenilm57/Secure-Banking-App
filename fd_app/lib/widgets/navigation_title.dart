import 'package:flutter/material.dart';

class NavigationTitle extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData icon;

  NavigationTitle({this.icon, this.onPressed, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.red[800],
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: onPressed,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            color: Colors.red,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
