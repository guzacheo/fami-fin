import 'package:fami_fin/data/transaction.dart';
import 'package:flutter/material.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:intl/intl.dart';

class NewTransactionForm extends StatefulWidget {
  final void Function(Transaction) onSaveTransaction;

  const NewTransactionForm({Transaction? transaction,
    required this.onSaveTransaction,
    Key? key})
      : super(key: key);

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController descriptionCtrl = TextEditingController(text: '');
  TextEditingController valueInCentsCtrl = TextEditingController(text: '0');

  DateTime date = DateTime.now();
  TextEditingController dateTextCtrl = TextEditingController(
      text: DateFormat('dd/MM/yy').format(DateTime.now()).toString());

  final fieldGap = const SizedBox(
    width: 20,
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      final DateTime? selected = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2022),
          lastDate: DateTime(2025),
          helpText: 'Selecione a Data da Transação',
          cancelText: 'cancelar',
          confirmText: 'ok');
      if (selected != null && selected != date) {
        setState(() {
          date = selected;
        });
      }
    }

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: descriptionCtrl,
            decoration: const InputDecoration(
              label: Text('Descrição'),
              border: OutlineInputBorder(),
              hintText: 'Digite a descrição para a transação',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Coloque uma descrição';
              }
              return null;
            },
          ),
          fieldGap,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: valueInCentsCtrl,
                  decoration: const InputDecoration(
                    label: Text('Valor em Reais'),
                    border: OutlineInputBorder(),
                    hintText: 'Valor',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um valor maior que zero';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    TextInputMask(mask: 'R!\$! !9+.999,99', reverse: true)
                  ],
                ),
              ),
              fieldGap,
              Expanded(
                flex: 1,
                child: Focus(
                  child: TextFormField(
                    keyboardType: null,
                    controller: dateTextCtrl,
                    decoration: const InputDecoration(
                      label: Text('Data'),
                      border: OutlineInputBorder(),
                      hintText: 'Data',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Defina uma data para a transação';
                      }
                      return null;
                    },
                  ),
                  onFocusChange: (hasFocus) async {
                    if (hasFocus) {
                      await _selectDate(context);
                      FocusScope.of(context).requestFocus(FocusNode());
                      dateTextCtrl.text =
                          DateFormat('dd/MM/yy').format(date).toString();
                    }
                  },
                ),
              ),
            ],
          ),
          fieldGap,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      debugPrint('${descriptionCtrl.text}, ${valueInCentsCtrl.text}, $date');
                      Transaction transaction = Transaction(
                          date: date,
                          description: descriptionCtrl.text,
                          valueInCents: int.parse(valueInCentsCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')));
                      widget.onSaveTransaction(transaction);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Adicionar Transação',
                          style: TextStyle(fontSize: 18))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
