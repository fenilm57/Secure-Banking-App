import 'package:fd_app/models/bank.dart';
import 'package:fd_app/models/name.dart';
import 'package:fd_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  final List<String> personNames;
  final List<String> bankNames;
  final String hintText;
  final String addData;
  final List<String> chooseValue;
  final List<String> chooseValueList;
  final databaseFD;
  final databaseAccount;
  final databaseNames;
  final databaseBankNames;
  final int val;

  DropDownWidget(
      {this.personNames,
      this.bankNames,
      this.hintText,
      this.databaseAccount,
      this.databaseNames,
      this.databaseBankNames,
      this.databaseFD,
      this.addData,
      this.chooseValueList,
      this.chooseValue,
      this.val});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String value;
  TextEditingController textController = TextEditingController();
  int height = 0;
  bool selectedItem = true;
  // String chooseValue;
  int count;
  AutovalidateMode validateByCode;
  final _formKey = GlobalKey<FormState>();
  final snackbar = SnackBar(content: Text('Value Added!'));

  void addName(String name) async {
    final tempName = Name(
      id: DateTime.now().toString(),
      name: name,
    );
    await insertName(tempName);
    setState(() {
      displayName();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.val == 0) {
      displayName();
    } else {
      displayBankName();
    }
  }

  Future<void> insertName(Name name) async {
    final db = await widget.databaseNames;

    await db.insert(
      'names',
      name.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void displayName() async {
    List<Name> tempName = await names();

    for (var i = 0; i < tempName.length; i++) {
      widget.personNames.add(tempName[i].name);
    }
  }

  Future<List<Name>> names() async {
    final db = await widget.databaseNames;

    final List<Map<String, dynamic>> maps = await db.query('names');

    return List.generate(maps.length, (i) {
      return Name(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<void> deleteName(String name) async {
    final db = await widget.databaseNames;

    await db.delete(
      'names',
      where: 'name = ?',
      whereArgs: [name],
    );
    setState(() {
      displayName();
    });
  }

  void addBank(String bankName) async {
    final tempName = Bank(
      id: DateTime.now().toString(),
      bankname: bankName,
    );
    await insertBank(tempName);
    setState(() {
      displayBankName();
    });
  }

  Future<void> insertBank(Bank name) async {
    final db = await widget.databaseBankNames;

    await db.insert(
      'banknames',
      name.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void displayBankName() async {
    List<Bank> tempName = await bankNames();

    for (var i = 0; i < tempName.length; i++) {
      widget.bankNames.add(tempName[i].bankname);
    }
  }

  Future<List<Bank>> bankNames() async {
    final db = await widget.databaseBankNames;

    final List<Map<String, dynamic>> maps = await db.query('banknames');

    return List.generate(maps.length, (i) {
      return Bank(
        id: maps[i]['id'],
        bankname: maps[i]['bankname'],
      );
    });
  }

  Future<void> deleteBankName(String name) async {
    final db = await widget.databaseBankNames;

    await db.delete(
      'banknames',
      where: 'bankname = ?',
      whereArgs: [name],
    );
    setState(() {
      displayBankName();
    });
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                textController,
                widget.hintText,
                TextInputType.name,
                secure: false,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(
                  'Add Data',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      if (widget.val == 0) {
                        setState(() {
                          addName(textController.text);
                        });
                      } else {
                        setState(() {
                          addBank(textController.text);
                        });
                      }
                      selectedItem = false;
                      if (widget.chooseValue.last != widget.addData) {
                        widget.chooseValueList.add(widget.chooseValue.last);
                      }
                    });

                    setState(() {
                      widget.chooseValue.add(null);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    textController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  int returnHieght() {
    if (widget.val == 0) {
      height = widget.personNames.length * 50;
    } else {
      height = widget.bankNames.length * 50;
    }
    if (height <= 200) {
      return height;
    } else {
      return 200;
    }
  }

  // Once Item Is Selected
  Widget _customDropDownExample(
      BuildContext context, item, String itemDesignation) {
    if (item == null) {
      return Container(
        child: Text(widget.addData),
      );
    }
    return Center(
      child: Container(
        // color: Colors.red,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            item,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // List of menuItem
  Widget _customPopupItemBuilderExample(
      BuildContext context, item, bool isSelected) {
    return Container(
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(0),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item,
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: item != widget.addData
            ? InkWell(
                onTap: () {
                  // widget.personNames.remove(item);
                  if (widget.val == 0) {
                    setState(() {
                      deleteName(item);
                    });
                  } else {
                    setState(() {
                      deleteBankName(item);
                    });
                  }

                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            : Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownSearch<String>(
        maxHeight: returnHieght().toDouble(),
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        mode: Mode.MENU,
        showSelectedItem: true,
        items: widget.val == 0 ? widget.personNames : widget.bankNames,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Choose Value';
          }
          return null;
        },
        showClearButton: selectedItem,
        dropdownBuilder: _customDropDownExample,
        hint: widget.hintText,
        selectedItem: widget.chooseValue.last,
        popupItemBuilder: _customPopupItemBuilderExample,
        onChanged: (newValue) {
          if (newValue == widget.addData) {
            showBottomSheet(context);
            setState(() {
              selectedItem = false;
              widget.chooseValue.add(widget.addData);
            });
          } else {
            setState(() {
              widget.chooseValue.add(newValue);
              selectedItem = true;
            });
            if (widget.chooseValue.last != widget.addData) {
              widget.chooseValueList.add(widget.chooseValue.last);
            }
          }
        },
      ),
    );
  }
}
