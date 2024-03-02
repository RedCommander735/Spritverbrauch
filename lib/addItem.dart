import 'package:flutter/material.dart';
import 'package:spritverbrauch/sqlite_service.dart';

class AddItem extends StatefulWidget {
  final Function update;
  const AddItem({super.key, required this.update});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  late double distance;
  late double fuelInLiters;
  late double pricePerLiter;

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
                // A text field that validates that the text is an adjective.
                TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an adjective.';
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
                      return 'Please enter a noun.';
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
                      return 'Please enter a noun.';
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

                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Submit'),
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

                    var item = ListEntity(
                      id: 0,
                      date: DateTime.now().millisecondsSinceEpoch,
                      distance: distance,
                      priceTotal: priceTotal,
                      fuelInLiters: fuelInLiters,
                      pricePerLiter: pricePerLiter,
                      litersPerKilometer: litersPerKilometer,
                    );

                    var sqlitesevice = SqliteService();

                    sqlitesevice.createItem(item);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Eintrag hinzugefügt"),
                      showCloseIcon: true,
                    ));

                    Navigator.of(context).pop();
                    widget.update();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
