import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transaction;
  final Function removeTransaction;
  TransactionList({
    @required this.transaction,
    @required this.removeTransaction
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transaction.isEmpty ? Column(
        children: <Widget>[
          Text(
              'No Transaction Data Found',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              color: Colors.black54
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 200,
            child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
            ),
          ),
        ],
      ):
      ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '\$'+transaction[index].amount.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple,width: 2),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction[index].title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      DateFormat().add_yMMMd().format(transaction[index].date),
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => removeTransaction(transaction[index].id),
                )
              ],
            ),
          );
        },
        itemCount: transaction.length,
        ),
    );
  }
}
