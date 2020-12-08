import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPrcentage;

  ChartBar({
    @required this.label,
    @required this.spendingAmount,
    @required this.spendingPrcentage
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constrains){
      return Column(
        children: <Widget>[
          Container(
            height: constrains.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$'+ spendingAmount.toStringAsFixed(0))
            ),
          ),
          SizedBox(height: constrains.maxHeight*0.05,),
          Container(
            height: constrains.maxHeight*0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54,width: 1),
                    color: Color.fromRGBO(220 , 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPrcentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 0.05,),
          Container(
            height: constrains.maxHeight*0.15,
              child: FittedBox(child: Text(label))
          ),
        ],
      );
    });
  }
}
