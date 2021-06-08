import 'package:fd_app/models/account.dart';
import 'package:fd_app/models/fd.dart';
import 'package:fd_app/widgets/dropdown.dart';
import 'package:fd_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class FdScreen extends StatefulWidget {
  final databaseFD;
  final databaseAccount;
  final databaseNames;
  final databaseBankNames;

  FdScreen(this.databaseFD, this.databaseAccount, this.databaseNames,
      this.databaseBankNames);

  @override
  _FdScreenState createState() => _FdScreenState();
}

class _FdScreenState extends State<FdScreen> {
  List<String> personNames = ['Add Person', 'Fenil'];
  List<String> bankNames = ['Add Bank', 'SBI'];
  List<String> chooseNameList = [];
  List<String> chooseBankList = [];
  String chooseBank;
  String chooseName;
  TextEditingController depositAmount = TextEditingController();
  TextEditingController maturityAmount = TextEditingController();
  TextEditingController interest = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  String startDate = 'Start Date';
  String endDate = 'Maturity Date';
  List<String> dropDownNull = [];
  List<String> nullValue = [null];
  final snackbar = SnackBar(content: Text('FD Added!'));

  // Insert Data
  void addData() async {
    final tempList = Fd(
      id: DateTime.now().toString(),
      startDate: startDate,
      endDate: endDate,
      interest: interest.text,
      amount: depositAmount.text,
      maturityAmount: maturityAmount.text,
      bankname: chooseBank,
      name: chooseName,
    );
    // widget.fdList.add(tempList);
    await insertDog(tempList);
  }

  Future<void> insertDog(Fd fd) async {
    final db = await widget.databaseFD;

    await db.insert(
      'fds',
      fd.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void pickedDate(int i) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    ).then(
      (value) {
        if (i == 0) {
          setState(() {
            selectedStartDate = value;
            startDate = DateFormat.yMd().format(selectedStartDate).toString();
          });
        } else {
          setState(() {
            selectedEndDate = value;
            endDate = DateFormat.yMd().format(selectedEndDate).toString();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Column(
        children: [
          DropDownWidget(
            personNames: personNames,
            bankNames: bankNames,
            hintText: 'Person Name',
            addData: 'Add Person',
            chooseValueList: chooseNameList,
            chooseValue: nullValue,
            databaseAccount: widget.databaseAccount,
            databaseFD: widget.databaseFD,
            databaseBankNames: widget.databaseBankNames,
            databaseNames: widget.databaseNames,
            val: 0,
          ),
          DropDownWidget(
            personNames: personNames,
            bankNames: bankNames,
            databaseBankNames: widget.databaseBankNames,
            databaseNames: widget.databaseNames,
            hintText: 'Bank Name',
            addData: 'Add Bank',
            chooseValueList: chooseBankList,
            chooseValue: nullValue,
            databaseAccount: widget.databaseAccount,
            databaseFD: widget.databaseFD,
            val: 1,
          ),
          TextFieldWidget(
            depositAmount,
            'Enter Deposit Amount',
            TextInputType.number,
            secure: false,
          ),
          TextFieldWidget(
            maturityAmount,
            'Enter Maturity Amount',
            TextInputType.number,
            secure: false,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 3),
                  child: TextFieldWidget(
                    interest,
                    'Enter Interest',
                    TextInputType.number,
                    secure: false,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextButton(
                          child: Text(
                            startDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            pickedDate(0);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextButton(
                          child: Text(
                            endDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            pickedDate(1);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 40,
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey1.currentState.validate() &&
                    startDate != 'Start Date' &&
                    endDate != 'Maturity Date') {
                  chooseBank = chooseBankList.last;
                  chooseName = chooseNameList.last;
                  setState(() {
                    addData();
                    startDate = 'Start Date';
                    endDate = 'Maturity Date';
                    nullValue.add(null);
                  });
                  depositAmount.clear();
                  maturityAmount.clear();
                  interest.clear();
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              child: Text(
                'Add FD',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: HexColor('#E04F3F'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
