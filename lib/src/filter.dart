import 'package:flutter/material.dart';
import 'package:spritverbrauch/main.dart';

import 'package:intl/intl.dart';

enum DateFilter { fromDate, dateRange }

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final _formKey = GlobalKey<FormState>();

  DateFilter? _dateFilter = DateFilter.fromDate;
  bool _filterEnabled = false;

  final TextEditingController _dateController = TextEditingController();

  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    String locale = Intl.systemLocale;
    var formatter = DateFormat.yMMMd(locale);

    asyncInitState();

    setState(() {
      _dateController.text = formatter.format(DateTime.now());
    });
  }

  void asyncInitState() async {
    var filterEnabledDb = preferences.getBool('filterEnabled');
    var dateFilterDb = preferences.getString('dateFilter');

    if (filterEnabledDb == null) {
      filterEnabledDb = false;
      preferences.setBool('filterEnabled', false);
    }

    if (dateFilterDb == null) {
      dateFilterDb = DateFilter.fromDate.toString();
      preferences.setString('dateFilter', DateFilter.fromDate.toString());
    }

    setState(() {
      _filterEnabled = filterEnabledDb ?? false;

      switch (dateFilterDb) {
        case 'DateFilter.fromDate':
          _dateFilter = DateFilter.fromDate;
          break;
        case 'DateFilter.dateRange':
          _dateFilter = DateFilter.dateRange;
          break;
        default:
          _dateFilter = DateFilter.fromDate;
      }
    });
  }

  static const textSize = 18.0;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: textSize);
    return Scaffold(
      appBar: AppBar(title: const Text('Filter konfigurieren')),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                          _filterEnabled = value;
                          _setFilterEnabled(value);
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
                              _dateFilter = value;
                              _setDateFilter(value);
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
                              _dateFilter = value;
                              _setDateFilter(value);
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
                if (_filterEnabled && _dateFilter == DateFilter.dateRange)
                  const Row(
                    // Date-Range-Filter
                    children: [Text("Date-Range-Filter")],
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

  Future<void> _setDateFilter(DateFilter? value) async {
    preferences.setString(
        'dateFilter', (value ?? DateFilter.fromDate).toString());
  }

  Future<void> _setFilterEnabled(bool? value) async {
    preferences.setBool('filterEnabled', (value ?? false));
  }
}
