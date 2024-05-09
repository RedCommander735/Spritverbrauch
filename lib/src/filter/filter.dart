import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:spritverbrauch/src/filter/filter_model.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  DateFilter _dateFilter = DateFilter.fromDate;
  bool _filterEnabled = false;

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

  static const textSize = 18.0;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: textSize);
    Provider.of<FilterModel>(context, listen: false).loadPreferences();

    return Scaffold(
      appBar: AppBar(title: const Text('Filter konfigurieren')),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<FilterModel>(
            builder: (BuildContext context, FilterModel value, Widget? child) {
              _filterEnabled = value.filterEnabled;
              _dateFilter = value.dateFilter;
              return Column(
                children: [
                  Row(
                    // Filter Toggle
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Anzeige-Zeitraum einschränken",
                        style: textStyle,
                      ),
                      Switch(
                        value: _filterEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            Provider.of<FilterModel>(context, listen: false)
                                .setFilterEnabled(value);
                          });
                        },
                      ),
                    ],
                  ),
                  if (_filterEnabled)
                    Column(
                      // Filter Switcher
                      children: [
                        RadioListTile(
                            title: const Text(
                              'Datum - Heute',
                              style: textStyle,
                            ),
                            value: DateFilter.fromDate,
                            groupValue: _dateFilter,
                            onChanged: (DateFilter? value) {
                              setState(() {
                                Provider.of<FilterModel>(context, listen: false)
                                    .setDateFilter(
                                        value ?? DateFilter.fromDate);
                              });
                            }),
                        RadioListTile(
                            title: const Text(
                              'Ausgewählter Zeitraum',
                              style: textStyle,
                            ),
                            value: DateFilter.dateRange,
                            groupValue: _dateFilter,
                            onChanged: (DateFilter? value) {
                              setState(() {
                                Provider.of<FilterModel>(context, listen: false)
                                    .setDateFilter(
                                        value ?? DateFilter.dateRange);
                              });
                            }),
                      ],
                    ),
                  if (_filterEnabled && _dateFilter == DateFilter.fromDate)
                    TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Datum',
                        prefixIcon: const Icon(Icons.calendar_today),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
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
                  if (_filterEnabled && _dateFilter == DateFilter.dateRange)
                    const Row(
                      // Date-Range-Filter
                      children: [Text("Date-Range-Filter")],
                    ),
                ],
              );
            },
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
