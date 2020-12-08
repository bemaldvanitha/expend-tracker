import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addToList;

  NewTransaction({
    @required this.addToList
  });

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  void submitData(){
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if(title.isEmpty || amount < 0 || _selectDate == null){
      return;
    }
    widget.addToList(title,amount,_selectDate);
    
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'enter title'
                ),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'enter amount'
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Text(_selectDate == null ? 'No Date Chosen': DateFormat().add_yMd().format(_selectDate)),
                  FlatButton(
                    child: Text(
                        'Choose Date',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: submitData,
              )
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
