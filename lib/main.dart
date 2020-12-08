import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'widgets/cart.dart';
import './models/transaction.dart';

void main(){
  // to avoid landscape mode
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transaction = [
    Transaction(id: 't1',title: 'new shoes',amount: 69.99,date: DateTime.now()),
    Transaction(id: 't2',title: 'wild apple',amount: 13.49,date: DateTime.now()),
    Transaction(id: 't3', title: 'lion lager', amount: 10, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle,double txAmount,DateTime selectedDate){
    final newTransaction = Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: selectedDate);
    setState(() {
      _transaction.add(newTransaction);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
        _transaction.removeWhere((tx){
          return tx.id == id;
        });
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(addToList: _addNewTransaction);
    },);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWidget  = Container(
        height: MediaQuery.of(context).size.height * 0.7 ,
        child: TransactionList(transaction: _transaction,removeTransaction: _deleteTransaction)
    );
    final PreferredSizeWidget appBar = Platform.isIOS ?
        CupertinoNavigationBar(
          middle: Text(
            'Expense Tracker!',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              )
            ],
          ),
        )
        : AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed:() => _startAddNewTransaction(context),
          ),
        ],
          title: Text(
            'Expense Tracker!',
              style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold
              ),
          ),
        backgroundColor: Colors.purple,
      );
    final pageBody = SafeArea(child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              isLandscape ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch.adaptive(
                    inactiveThumbColor: Colors.purple,
                    activeTrackColor: Colors.purpleAccent,
                    value: _showChart,
                    onChanged: (val){
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ) :Container(),

              if(!isLandscape) Container(
                  height: (MediaQuery.of(context).size.height  - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.3,
                  child: Chart(recentTransation: _recentTransaction,)
              ),
              if(!isLandscape) txListWidget,
              if(isLandscape) _showChart ? Container(
                  height: (MediaQuery.of(context).size.height  - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.7,
                  child: Chart(recentTransation: _recentTransaction,)
              )
                  : txListWidget
            ])
    ));
    return Platform.isIOS ?
    CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    )
    : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isAndroid ? FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purpleAccent,
        onPressed: () => _startAddNewTransaction(context),
      ): Container()
    );
  }
}
