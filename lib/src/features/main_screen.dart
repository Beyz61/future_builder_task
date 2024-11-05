import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  Future<String>? _getCityFromZip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Postleitzahl"),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () {setState(() {
                    _getCityFromZip = getCityFromZip(_controller.text);
                  });
                },
                child: const Text("Suche"),
              ),
              const SizedBox(height: 32),

              FutureBuilder(
                  future: _getCityFromZip,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text("Fehler beim Laden der Stadt");
                    } else if (snapshot.hasData) {
                      return Text(
                        "Ergebnis: ${snapshot.data}",
                      );
                    } else {
                      return const Text("Noch keine PLZ gesucht");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "34":
        return "Istanbul";
      case "61":
        return "Trabzon";
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}









