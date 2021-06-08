import 'package:fd_app/screens/account_display.dart';
import 'package:fd_app/screens/fd_display.dart';
import 'package:fd_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ShowDialogScreen extends StatefulWidget {
  final int value;
  ShowDialogScreen(this.value);

  @override
  _ShowDialogScreenState createState() => _ShowDialogScreenState();
}

class _ShowDialogScreenState extends State<ShowDialogScreen> {
  final TextEditingController passwordController = TextEditingController();
  bool _validate = false;
  final String password = '2581';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('images/bg.png'),
        Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('Enter Password'),
            content: Container(
              height: 100,
              width: 300,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        errorText: _validate ? 'Incorrect Password' : null,
                      ),
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                width: 250,
                child: ElevatedButton(
                  child: Text(
                    'Enter',
                    style: TextStyle(letterSpacing: 2.0, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: HexColor('#E04F3F'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (passwordController.text.isEmpty ||
                        passwordController.text != password) {
                      setState(() {
                        _validate = true;
                      });
                    } else {
                      if (widget.value == 0) {
                        Navigator.pushReplacementNamed(
                            context, AccountDisplay.routeName);

                        // widget.tabFunction(0);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, FDDisplay.routeName);
                      }
                    }

                    // Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                width: 25,
              )
            ],
          ),
        ),
      ],
    );
  }
}
