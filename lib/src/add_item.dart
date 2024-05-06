import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spritverbrauch/src/listview/item_list_model.dart';
import 'package:spritverbrauch/src/utils/sqlite_service.dart';

import 'package:intl/intl.dart'; //for date format

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  late double distance;
  late double fuelInLiters;
  late double pricePerLiter;

  final TextEditingController _dateController = TextEditingController();

  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    String locale = Intl.systemLocale;
    var formatter = DateFormat.yMMMd(locale);
    setState(() {
      _dateController.text = formatter.format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eintrag hinzufügen')),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Datum',
                    prefixIcon: const Icon(Icons.calendar_today),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                // A text field that validates that the text is an adjective.
                TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte gültige Strecke eingeben.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'z.B. 473,7',
                    labelText: 'gefahrene Strecke in Kilometer',
                  ),
                  onChanged: (value) {
                    distance = double.parse(value.replaceAll(',', '.'));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                // A text field that validates that the text is a noun.
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte gültige Menge eingeben';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'z.B. 42,35',
                    labelText: 'getankter Sprit in Litern',
                  ),
                  onChanged: (value) {
                    fuelInLiters = double.parse(value.replaceAll(',', '.'));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte gültigen Preis eingeben';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'z.B. 1,75',
                    labelText: 'Spritpreis in Euro',
                  ),
                  onChanged: (value) {
                    pricePerLiter = double.parse(value.replaceAll(',', '.'));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom( backgroundColor: Theme.of(context).primaryColor ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          'Hinzufügen',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      onPressed: () {
                        // Validate the form by getting the FormState from the GlobalKey
                        // and calling validate() on it.
                        var valid = _formKey.currentState!.validate();
                        if (!valid) {
                          return;
                        }
                    
                        var priceTotal = fuelInLiters * pricePerLiter;
                        var litersPerKilometer = (fuelInLiters * 100) / distance;
                    
                        var item = ListItem(
                          id: 0,
                          date: _dateTime.millisecondsSinceEpoch,
                          distance: distance,
                          priceTotal: priceTotal,
                          fuelInLiters: fuelInLiters,
                          pricePerLiter: pricePerLiter,
                          litersPerKilometer: litersPerKilometer,
                        );
                    
                        Provider.of<ItemListModel>(context, listen: false)
                            .add(item);
                    
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Eintrag hinzugefügt"),
                          showCloseIcon: true,
                        ));
                    
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Abbrechen'),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );

    String locale = Intl.systemLocale;
    var formatter = DateFormat.yMMMd(locale);

    if (pickedDate != null) {
      setState(() {
        _dateController.text = formatter.format(pickedDate);
        _dateTime = pickedDate;
      });
    }
  }
}
