import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0C0E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF6A00),
          secondary: Color(0xFF262B34),
          surface: Color(0xFF14171D),
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
