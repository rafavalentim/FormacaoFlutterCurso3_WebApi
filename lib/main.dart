import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/async_study.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/screens/add_journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());

  //Testando o acesso ao serviço criado com http e o json-server
  JournalService service = JournalService();
  service.register("Olá Mundo Doido!");

  //Acessando o conteúdo enviado por meio de um get.
  //service.get();

 asyncStudy();


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: "add-journal",
      routes: {
        "home": (context) => const HomeScreen(),
        "add-journal" : (context) => AddJournalScreen(journal: Journal(id:"id", content: "content", createdAt: DateTime.now(), updatedAt: DateTime.now()),),
      },
    );
  }
}
