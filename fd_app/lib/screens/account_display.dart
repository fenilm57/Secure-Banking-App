import 'package:fd_app/models/account.dart';
import 'package:fd_app/screens/homepage.dart';
import 'package:fd_app/screens/navigationscreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AccountDisplay extends StatefulWidget {
  static const routeName = '/accountdisplay';
  final databaseFD;
  final databaseAccount;

  AccountDisplay({this.databaseAccount, this.databaseFD});

  @override
  _AccountDisplayState createState() => _AccountDisplayState();
}

class _AccountDisplayState extends State<AccountDisplay> {
  List<Account> tempList = [];
  List<Account> tempList2;
  final snackbar = SnackBar(content: Text('Account Deleted!'));

  Future<void> delete(String id) async {
    final db = await widget.databaseAccount;

    await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  void initState() {
    super.initState();
    display();
  }

  void display() async {
    tempList2 = await dogs();
    tempList2.sort((a, b) => (a.name).compareTo((b.name)));
    setState(() {
      tempList = tempList2;
    });
  }

  Future<List<Account>> dogs() async {
    final db = await widget.databaseAccount;
    final List<Map<String, dynamic>> maps = await db.query('accounts');
    return List.generate(maps.length, (i) {
      return Account(
        id: maps[i]['id'],
        name: maps[i]['name'],
        bankName: maps[i]['bankname'],
        accountno: maps[i]['accountno'],
        ifscCode: maps[i]['ifsc'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerScreen(
        databaseAccount: widget.databaseAccount,
        databaseFD: widget.databaseFD,
      ),
      backgroundColor: HexColor('#E8816D'),
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: Container(
        child: tempList.isEmpty || tempList == null
            ? Center(
                child: Text(
                  'No Accounts Yet!!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: tempList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Text(
                            (index + 1).toString(),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Name :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20 ,
                                  ),
                                ),
                                Text(
                                  ' ${tempList[index].name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Account : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ' ${tempList[index].accountno}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Bank :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ' ${tempList[index].bankName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'IFSC : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${tempList[index].ifscCode}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete!'),
                                    content: Text('Are you sure?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          delete(tempList[index].id);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                          Navigator.pushReplacementNamed(
                                              context, HomePage.routeName);
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
