import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:spritverbrauch/src/components/sp_button.dart';
import 'package:spritverbrauch/src/settings/filter_model.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  DateFilter _dateFilter = DateFilter.fromDate;
  bool _filterEnabled = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dateRangeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String locale = Intl.systemLocale;
    final formatter = DateFormat.yMMMd(locale);

    final startDateSingle =
        Provider.of<FilterModel>(context, listen: false).startDateSingle;

    final startDate =
        Provider.of<FilterModel>(context, listen: false).startDate;

    final endDate =
        Provider.of<FilterModel>(context, listen: false).endDate;

    final format_yMMMd = DateFormat.yMMMd(locale);
    final format_MMMd = DateFormat.MMMd(locale);

    late String formatString;

    if (startDate.year == endDate.year) {
      formatString = '${format_MMMd.format(startDate)} - ${format_yMMMd.format(endDate)}';
    } else {
      formatString = '${format_yMMMd.format(startDate)} - ${format_yMMMd.format(endDate)}';
    }

    setState(() {
      _dateController.text =
          (startDateSingle == null) ? '' : formatter.format(startDateSingle);
      _dateRangeController.text = formatString;
    });
    }

  static const textSize = 18.0;

  @override
  Widget build(BuildContext context) {
    Provider.of<FilterModel>(context, listen: false).loadPreferences();

    return Scaffold(
      appBar: AppBar(title: const Text('Filter konfigurieren'), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<FilterModel>(
          builder:
              (BuildContext context, FilterModel filterModel, Widget? child) {
            _filterEnabled = filterModel.filterEnabled;
            _dateFilter = filterModel.dateFilter;
            return DefaultTextStyle(
              style: TextStyle(fontSize: textSize, color: Theme.of(context).colorScheme.onBackground),
              child: Column(
                children: [
                  Row(
                    // Filter Toggle
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Anzeige-Zeitraum einschränken"
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
                              'Datum - Heute'
                            ),
                            value: DateFilter.fromDate,
                            groupValue: _dateFilter,
                            onChanged: (DateFilter? value) {
                              Provider.of<FilterModel>(context, listen: false)
                                  .setDateFilter(value ?? DateFilter.fromDate);
                            }),
                        RadioListTile(
                            title: const Text(
                              'Ausgewählter Zeitraum'
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
                        enabledBorder:
                            const OutlineInputBorder(borderSide: BorderSide.none),
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
                    TextFormField(
                      controller: _dateRangeController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Zeitraum',
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
                        _selectDateRange(start: filterModel.startDate, end: filterModel.endDate);
                      },
                    ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: SPButtonGroup(
                      primartyText: 'Anwenden',
                      secondaryText: 'Zurücksetzen',
                      primaryOnPressed: () {
                        Navigator.of(context).pop();
                      },
                      secondaryOnPressed: () {
                        Provider.of<FilterModel>(context, listen: false)
                            .resetFilter();
                        setState(() {
                          _dateController.text = '';
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectDate(DateTime? initial) async {
    final DateTime? pickedDate = await showDatePicker(
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
        Provider.of<FilterModel>(context, listen: false)
            .setStartDateSingle(pickedDate);
      });
    }
  }

  Future _selectDateRange({required DateTime start, required DateTime end}) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: start, end: end),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );

    if (pickedDateRange != null) {
      String locale = Intl.systemLocale;
      final format_yMMMd = DateFormat.yMMMd(locale);
      final format_MMMd = DateFormat.MMMd(locale);

      final start = pickedDateRange.start;
      final end = pickedDateRange.end;
      late String formatString;

      if (start.year == end.year) {
        formatString = '${format_MMMd.format(start)} - ${format_yMMMd.format(end)}';
      } else {
        formatString = '${format_yMMMd.format(start)} - ${format_yMMMd.format(end)}';
      }

      setState(() {
        _dateRangeController.text = formatString;
        Provider.of<FilterModel>(context, listen: false)
            .setStartDate(start);

        Provider.of<FilterModel>(context, listen: false)
            .setEndDate(end);
      });
    }
  }
}
