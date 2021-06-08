import 'package:fd_app/models/account.dart';
import 'package:fd_app/models/fd.dart';
import 'package:fd_app/models/name.dart';
import 'package:fd_app/widgets/dropdown.dart';
import 'package:fd_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';

class AccountScreen extends StatefulWidget {
  final databaseFD;
  final databaseAccount;
  final databaseNames;
  final databaseBankNames;

  AccountScreen(this.databaseFD, this.databaseAccount, this.databaseNames,
      this.databaseBankNames);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<String> personNamesAccount = ['Add Person', 'Fenil'];
  List<String> bankNamesAccount = ['Add Bank', 'SBI'];
  List<String> chooseNameListAccount = [];
  List<String> chooseBankListAccount = [];
  TextEditingController accountNo = TextEditingController();
  TextEditingController confirmAccountNo = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  String chooseBank;
  String chooseName;
  final _formKey1 = GlobalKey<FormState>();
  List<String> dropDownNull = [];
  List<String> nullValue = [null];
  final snackbar = SnackBar(content: Text('Account Added!'));
  final snackbar2 = SnackBar(content: Text('Account number Mismatched!'));

  // Insert Data
  void addData() async {
    final tempList = Account(
      id: DateTime.now().toString(),
      accountno: accountNo.text,
      bankName: chooseBank,
      name: chooseName,
      ifscCode: ifscCode.text,
    );
    // widget.accountList.add(tempList);

    await insertDog(tempList);
  }

  Future<void> insertDog(Account account) async {
    final db = await widget.databaseAccount;

    await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Column(
        children: [
          DropDownWidget(
            personNames: personNamesAccount,
            bankNames: bankNamesAccount,
            hintText: 'Person Name',
            addData: 'Add Person',
            chooseValueList: chooseNameListAccount,
            chooseValue: nullValue,
            databaseAccount: widget.databaseAccount,
            databaseFD: widget.databaseFD,
            databaseBankNames: widget.databaseBankNames,
            databaseNames: widget.databaseNames,
            val: 0,
          ),
          DropDownWidget(
            personNames: personNamesAccount,
            bankNames: bankNamesAccount,
            hintText: 'Bank Name',
            databaseBankNames: widget.databaseBankNames,
            databaseNames: widget.databaseNames,
            addData: 'Add Bank',
            chooseValueList: chooseBankListAccount,
            chooseValue: nullValue,
            databaseAccount: widget.databaseAccount,
            databaseFD: widget.databaseFD,
            val: 1,
          ),
          TextFieldWidget(
            accountNo,
            'Enter Account Number',
            TextInputType.number,
            secure: false,
          ),
          TextFieldWidget(
            confirmAccountNo,
            'Confirm Account Number',
            TextInputType.number,
            secure: false,
          ),
          TextFieldWidget(
            ifscCode,
            'Enter IFSC code',
            TextInputType.name,
            secure: false,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.maxFinite,
            height: 40,
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey1.currentState.validate() &&
                    accountNo.text == confirmAccountNo.text) {
                  chooseBank = chooseBankListAccount.last;
                  chooseName = chooseNameListAccount.last;
                  setState(() {
                    addData();
                    nullValue.add(null);
                  });
                  accountNo.clear();
                  confirmAccountNo.clear();
                  ifscCode.clear();
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
                if (accountNo.text != confirmAccountNo.text) {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar2);
                  accountNo.clear();
                  confirmAccountNo.clear();
                }
              },
              child: Text(
                'Add Account',
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
