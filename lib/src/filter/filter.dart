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

    var startDateSingle =
        Provider.of<FilterModel>(context, listen: false).startDateSingle;
    setState(() {
      _dateController.text = formatter.format(startDateSingle);
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
            builder:
                (BuildContext context, FilterModel filterModel, Widget? child) {
              _filterEnabled = filterModel.filterEnabled;
              _dateFilter = filterModel.dateFilter;
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
                          Provider.of<FilterModel>(context, listen: false)
                              .setFilterEnabled(value);
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
                              Provider.of<FilterModel>(context, listen: false)
                                  .setDateFilter(value ?? DateFilter.fromDate);
                            }),
                        RadioListTile(
                            title: const Text(
                              'Ausgewählter Zeitraum',
                              style: textStyle,
                            ),
                            value: DateFilter.dateRange,
                            groupValue: _dateFilter,
                            onChanged: (DateFilter? value) {
                              Provider.of<FilterModel>(context, listen: false)
                                  .setDateFilter(value ?? DateFilter.dateRange);
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
                        _selectDate(filterModel.startDateSingle);
                      },
                    ),
                  if (_filterEnabled && _dateFilter == DateFilter.dateRange)
                    const Row(
                      // Date-Range-Filter
                      children: [Text("Date-Range-Filter")],
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom( backgroundColor: Theme.of(context).colorScheme.primary ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          'Schließen',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('Zurücksetzen'),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(DateTime initial) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );

    String locale = Intl.systemLocale;
    var formatter = DateFormat.yMMMd(locale);

    if (pickedDate != null) {
      setState(() {
        _dateController.text = formatter.format(pickedDate);
        _dateTime = pickedDate;
        Provider.of<FilterModel>(context, listen: false)
            .setStartDateSingle(_dateTime);
      });
    }
  }
}
