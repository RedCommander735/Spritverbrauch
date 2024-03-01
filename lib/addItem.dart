import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  String? adjective;
  String? noun;
  bool? agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 Story Generator'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              child: const Text('Submit'),
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
                    content: Text('The $adjective developer saw a $noun'),
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
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // A text field that validates that the text is an adjective.
                TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an adjective.';
                    }
                    return 'Not a valid adjective.';
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'z.B. 473,7',
                    labelText: 'gefahrene Strecke in Kilometer',
                  ),
                  onChanged: (value) {
                    adjective = value;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                // A text field that validates that the text is a noun.
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a noun.';
                    }
                    return 'Not a valid noun.';
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'z.B. 42,35',
                    labelText: 'getankter Sprit in Litern',
                  ),
                  onChanged: (value) {
                    noun = value;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a noun.';
                    }
                    return 'Not a valid noun.';
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'z.B. 1,75',
                    labelText: 'Spritpreis in Euro',
                  ),
                  onChanged: (value) {
                    noun = value;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                // A custom form field that requires the user to check a
                // checkbox.
                FormField<bool>(
                  initialValue: false,
                  validator: (value) {
                    if (value == false) {
                      return 'You must agree to the terms of service.';
                    }
                    return null;
                  },
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) {
                                // When the value of the checkbox changes,
                                // update the FormFieldState so the form is
                                // re-validated.
                                formFieldState.didChange(value);
                                setState(() {
                                  agreedToTerms = value;
                                });
                              },
                            ),
                            Text(
                              'I agree to the terms of service.',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        if (!formFieldState.isValid)
                          Text(
                            formFieldState.errorText ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context).colorScheme.error),
                          ),
                      ],
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
