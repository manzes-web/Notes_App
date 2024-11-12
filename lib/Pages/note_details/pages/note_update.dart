// import 'package:date_field/date_field.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:notes_app/Pages/note_page.dart';
// import 'package:notes_app/Pages/widgets/apptextfield.dart';
// import 'package:provider/provider.dart';

// class NoteUpdate extends StatefulWidget {
//   const NoteUpdate({super.key});

//   @override
//   State<NoteUpdate> createState() => _NoteUpdateState();
// }

// class _NoteUpdateState extends State<NoteUpdate> {
//   @override
//   Widget build(BuildContext context) {
//     final textController = TextEditingController();
//     final descriptionController = TextEditingController();
//     // final dateController = TextEditingController();
//     DateTime? selectedDate = DateTime.now();

//     @override
//     void dispose() {
//       textController.dispose();
//       descriptionController.dispose();

//       super.dispose();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         title: const Text('UPDATE NOTE'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Apptextfield(textController: textController, labelText: 'Update title'),
//             const SizedBox(
//               height: 12,
//             ),
//             Apptextfield(textController: descriptionController, labelText: 'Update description'),
//             const SizedBox(
//               height: 12,
//             ),
//             DateTimeFormField(
//               decoration: InputDecoration(
//                 labelText: 'Enter date..',
//                 labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
//                 focusColor: Theme.of(context).colorScheme.inversePrimary,
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
//               ),
//               firstDate: DateTime.now().subtract(const Duration(days: 1)),
//               lastDate: DateTime.now().add(const Duration(days: 40)),
//               initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
//               onChanged: (DateTime? value) {
//                 selectedDate = value;
//               },
//               initialValue: selectedDate,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:date_field/date_field.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:notes_app/Pages/note_page.dart';
// import 'package:notes_app/Pages/widgets/apptextfield.dart';
// import 'package:provider/provider.dart';

// class NoteUpdate extends StatefulWidget {
//   const NoteUpdate({super.key});

//   @override
//   State<NoteUpdate> createState() => _NoteUpdateState();
// }

// class _NoteUpdateState extends State<NoteUpdate> {
//   final textController = TextEditingController();
//   final descriptionController = TextEditingController();
//   DateTime? selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now(); // Initialize selectedDate with a default value.
//   }

//   @override
//   void dispose() {
//     textController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime.now().subtract(const Duration(days: 1)),
//       lastDate: DateTime.now().add(const Duration(days: 40)),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedDate = pickedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         title: const Text('UPDATE NOTE'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Apptextfield(textController: textController, labelText: 'Update title'),
//             const SizedBox(height: 12),
//             Apptextfield(textController: descriptionController, labelText: 'Update description'),
//             const SizedBox(height: 12),
//             GestureDetector(
//               onTap: () => _pickDate(context), // Opens the date picker on tap
//               child: AbsorbPointer(
//                 child: DateTimeFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Enter date..',
//                     labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
//                     ),
//                   ),
//                   initialValue: selectedDate,
//                   mode: DateTimeFieldPickerMode.date,
//                   // enabled: false, // Prevents the default date picker, relies on GestureDetector tap
//                   onChanged: (DateTime? value) {
//                     setState(() {
//                       selectedDate = value;
//                     });
//                     context.pop();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/Themes/theme_provider.dart';

class NoteUpdate extends ConsumerStatefulWidget {
  const NoteUpdate({super.key});

  @override
  ConsumerState<NoteUpdate> createState() => _NoteUpdateState();
}

class _NoteUpdateState extends ConsumerState<NoteUpdate> {
  final textController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Set initial date value
    dateController.text = DateFormat.yMd().format(selectedDate!); // Display initial date in the text field
  }

  @override
  void dispose() {
    textController.dispose();
    descriptionController.dispose();
    dateController.dispose();
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
        dateController.text = "${selectedDate?.toLocal()}".split(' ')[0]; // Display in YYYY-MM-DD format
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.read(themeNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('UPDATE NOTE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Apptextfield(
              textController: textController,
              labelText: 'Update title..',
            ),
            const SizedBox(height: 12),
            Apptextfield(
              textController: descriptionController,
              labelText: 'Update description...',
            ),
            const SizedBox(height: 12),
            Apptextfield(
              textController: dateController,
              labelText: 'Pick a date',
              onTap: () {
                _pickDate(context, themeProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}
