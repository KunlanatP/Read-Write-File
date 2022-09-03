import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read/Write',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fullPath =
      '/Users/kunlanat.p/KUNLANAT/Flutter-Dev/Read-Write File/read_write_file_example/lib/AndroidManifest.xml';

  String oldText = '';
  String newText = '';

  @override
  void initState() {
    debugPrint('[LOG] :: initState');
    _read();
    super.initState();
  }

  Future<void> _read() async {
    try {
      if (kIsWeb) {
      } else {
        final io.File file = io.File(fullPath);
        String text = await file.readAsString();
        setState(() => oldText = text);
      }
    } catch (e) {
      debugPrint("Couldn't read file :: $e");
    }
  }

  // _downloadFile(String path) {
  //   AnchorElement anchorElement = AnchorElement(href: path);
  //   anchorElement.download = 'Download';
  //   anchorElement.click();
  // }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
            color: Colors.grey.shade800,
          ),
          const BoxShadow(
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
            color: Colors.white,
          ),
        ]);

    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Android Package Kit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Divider(thickness: 2, color: Colors.black38),
        const SizedBox(height: 20),
        SizedBox(
          height: 42,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'NAME',
            ),
            onSubmitted: (value) {},
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 42,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'PACKAGE',
            ),
            onSubmitted: (value) {},
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () => _showMyDialog(),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300, 40),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text('Compare'),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Container(
          width: 500,
          height: 300,
          decoration: decoration,
          padding: const EdgeInsets.all(30),
          child: child,
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Compare'),
          content: SingleChildScrollView(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 200,
                  height: 600,
                  color: Colors.amber,
                  child: SingleChildScrollView(child: Text(oldText)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 200,
                  height: 600,
                  color: Colors.green,
                  child: SingleChildScrollView(child: Text(newText)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
