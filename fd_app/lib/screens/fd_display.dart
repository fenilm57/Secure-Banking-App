import 'package:fd_app/models/account.dart';
import 'package:fd_app/models/fd.dart';
import 'package:fd_app/screens/navigationscreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'homepage.dart';

class FDDisplay extends StatefulWidget {
  static const routeName = '/fd';

  final databaseFD;
  final databaseAccount;

  FDDisplay({this.databaseAccount, this.databaseFD});

  @override
  _FDDisplayState createState() => _FDDisplayState();
}

class _FDDisplayState extends State<FDDisplay> {
  List<Fd> tempList2;
  List<Fd> tempList;
  final snackbar = SnackBar(content: Text('FD Deleted!'));

  @override
  void initState() {
    super.initState();
    display();
  }

  void display() async {
    tempList2 = await dogs();
    tempList2.sort((a, b) => (a.endDate).compareTo((b.endDate)));
    setState(() {
      tempList = tempList2;
    });
  }

  Future<List<Fd>> dogs() async {
    final db = await widget.databaseFD;

    final List<Map<String, dynamic>> maps = await db.query('fds');

    return List.generate(maps.length, (i) {
      return Fd(
        id: maps[i]['id'],
        name: maps[i]['name'],
        bankname: maps[i]['bankname'],
        amount: maps[i]['amount'],
        maturityAmount: maps[i]['maturityAmount'],
        interest: maps[i]['interest'],
        startDate: maps[i]['startdate'],
        endDate: maps[i]['enddate'],
      );
    });
  }

  Future<void> delete(String id) async {
    final db = await widget.databaseFD;

    await db.delete(
      'fds',
      where: 'id = ?',
      whereArgs: [id],
    );
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
        title: Text('FD Details'),
      ),
      body: Container(
        child: tempList == null || tempList.isEmpty
            ? Center(
                child: Text(
                'No FD\'s Yet!!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ))
            : ListView.builder(
                itemCount: tempList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        'End Date : ${tempList[index].endDate}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        'Maturity Amount : ${tempList[index].amount}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(left: 20, bottom: 20, top: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Name : ',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${tempList[index].name}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'BankName : ',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${tempList[index].bankname}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Amount : ',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${tempList[index].amount}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Interest : ',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    '${tempList[index].interest}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Start Date : ',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    '${tempList[index].startDate}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
