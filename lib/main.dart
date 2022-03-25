import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'month_transactions/transactions_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FamiFinApp());
}

class FamiFinApp extends StatelessWidget {
  const FamiFinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FamiFin',
      theme:   ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.amber,

        // Define the default font family.
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      home: TransactionList(),
    );
  }
}
