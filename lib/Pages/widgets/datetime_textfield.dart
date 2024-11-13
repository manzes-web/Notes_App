import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Themes/theme_provider.dart';

class DatetimeTextfield extends ConsumerStatefulWidget {
  final TextEditingController dateController;
  const DatetimeTextfield({
    super.key,
    required this.dateController,
  });

  @override
  ConsumerState<DatetimeTextfield> createState() => _DatetimeTextfieldState();
}

class _DatetimeTextfieldState extends ConsumerState<DatetimeTextfield> {
  // final dateController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Set initial date value
    widget.dateController.text = DateFormat.yMd().format(selectedDate!); // Display initial date in the text field
  }

  @override
  void dispose() {
    widget.dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, ThemeNotifier themeProvider) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 40)),
      builder: (BuildContext context, Widget? child) {
        // Apply your light or dark theme to the date picker
        return Theme(
          data: themeProvider.isDarkMode
              ? ThemeData.dark().copyWith(
                  primaryColor: Theme.of(context).colorScheme.inversePrimary, // Primary color for the calendar
                  // Accent color for text and buttons
                  buttonTheme: ButtonThemeData(
                    buttonColor: Theme.of(context).colorScheme.inversePrimary, // Button color in date picker
                    // textTheme: ButtonTextTheme.primary, // Button text color
                  ),
                )
              : ThemeData.light().copyWith(
                  primaryColor: Theme.of(context).colorScheme.inversePrimary, // Primary color for the calendar
                  // Accent color for text and buttons
                  buttonTheme: ButtonThemeData(
                    buttonColor: Theme.of(context).colorScheme.inversePrimary, // Button color in date picker
                    // textTheme: ButtonTextTheme.primary, // Button text color
                  ),
                ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.dateController.text = "${selectedDate?.toLocal()}".split(' ')[0]; // Display in YYYY-MM-DD format
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.read(themeNotifierProvider.notifier);
    return Apptextfield(
      textController: widget.dateController,
      labelText: 'Pick a date',
      onTap: () {
        _pickDate(context, themeProvider);
      },
    );
  }
}
