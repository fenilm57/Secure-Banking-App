import 'package:fd_app/screens/aboutus.dart';
import 'package:fd_app/screens/account_display.dart';
import 'package:fd_app/screens/fd_display.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import './screens/homepage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseFD = openDatabase(
    join(await getDatabasesPath(), 'fds_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE fds(id TEXT PRIMARY KEY, name TEXT, bankname TEXT, interest TEXT, amount TEXT, maturityAmount TEXT, startdate TEXT, enddate TEXT)',
      );
    },
    version: 1,
  );
  final databaseAccount = openDatabase(
    join(await getDatabasesPath(), 'accounts_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE accounts(id TEXT PRIMARY KEY, name TEXT, bankname TEXT, accountno TEXT, ifsc TEXT)',
      );
    },
    version: 1,
  );

  final databaseBankname = openDatabase(
    join(await getDatabasesPath(), 'banknames_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE banknames(id TEXT PRIMARY KEY, bankname TEXT)',
      );
    },
    version: 1,
  );

  final databaseName = openDatabase(
    join(await getDatabasesPath(), 'names_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE names(id TEXT PRIMARY KEY, name TEXT)',
      );
    },
    version: 1,
  );

  runApp(MyApp(databaseFD, databaseAccount, databaseName, databaseBankname));
}

class MyApp extends StatelessWidget {
  static const routeName = '/myapp';
  final databaseFD;
  final databaseAccount;
  final databaseBankNames;
  final databaseNames;

  MyApp(this.databaseFD, this.databaseAccount, this.databaseNames,
      this.databaseBankNames);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor('#E04F3F'),
      ),
      home: HomePage(
          databaseAccount, databaseFD, databaseNames, databaseBankNames),
      routes: {
        HomePage.routeName: (_) => HomePage(
            databaseAccount, databaseFD, databaseNames, databaseBankNames),
        AboutUs.routeName: (_) => AboutUs(),
        MyApp.routeName: (_) => MyApp(
            databaseAccount, databaseFD, databaseNames, databaseBankNames),
        AccountDisplay.routeName: (_) => AccountDisplay(
              databaseAccount: databaseAccount,
              databaseFD: databaseFD,
            ),
        FDDisplay.routeName: (_) => FDDisplay(
              databaseAccount: databaseAccount,
              databaseFD: databaseFD,
            ),
      },
    );
  }
}
