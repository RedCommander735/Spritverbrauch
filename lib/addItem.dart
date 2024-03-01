import 'dart:ffi';

import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  late double distance;
  late double fuel;
  late double price;

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
                    fuel = double.parse(value.replaceAll(',', '.'));
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
                    price = double.parse(value.replaceAll(',', '.'));
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

                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Your story'),
                        content: Text(
                            'The $fuel developer saw a $distance and $price'),
                        actions: [
                          TextButton(
                            child: const Text('Done'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
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
