import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Module'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/args');
  bool? openedWithArgs;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => _invokeMethod());
  }

  _invokeMethod() async {
    try {
      final bool result = await platform.invokeMethod(
        'getArgsValue',
      );
      setState(() {
        openedWithArgs = result;
      });

      _showSnackbar("Invoked With Arguments: $result");
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  void _showSnackbar(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _backWithArgs(bool args) async {
    try {
      await platform.invokeMethod('setArgsValue', {'args': args});
    } catch (e) {
      _showSnackbar(e.toString());
    }
    SystemNavigator.pop(animated: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => _backWithArgs(false),
                child: const Text(
                  'Back Without Args',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => _backWithArgs(true),
                child: const Text(
                  'Back With Args',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Opened With Arguments: ${openedWithArgs ?? 'NULL'}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
