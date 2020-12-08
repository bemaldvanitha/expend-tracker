import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransation;

  Chart({
    @required this.recentTransation
  });

  List<Map<String,Object>> get groupTransaction {
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for(var i = 0;i<recentTransation.length;i++){
        if(recentTransation[i].date.day == weekDay.day && recentTransation[i].date.month == weekDay.month && recentTransation[i].date.year == weekDay.year){
          totalSum = totalSum + recentTransation[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay).substring(0,1),'amount': totalSum};
    });
  }

  double get totalSpending{
    double totalSpend = 0;
    for(int i=0;i<7;i++){
      totalSpend = totalSpend + groupTransaction[i]['amount'];
    }
    return totalSpend;
  }
  
  @override
  Widget build(BuildContext context) {
    //print(groupTransaction);
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransaction.map((data){
              return Expanded(
                //fit: FlexFit.tight,
                child: ChartBar(label: data['day'],spendingAmount: data['amount'],
                    spendingPrcentage: totalSpending==0 ? 0 :(data['amount'] as double)/totalSpending),
              );
            }).toList(),
          ),

      ),
    );
  }
}
