import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: app());
  }
}

class app extends StatefulWidget {
  app({super.key, required});

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  final _textController = TextEditingController();
  final List<String> _elements = [];
  final _random = Random();
  var _selectedElement = -1;

  void selectRandomNumber() {
    setState(() {
      _selectedElement = _random.nextInt(_elements.length);

      print(_selectedElement);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 40,
                left: 20,
                right: 20,
              ),
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: _elements.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        _elements.removeAt(index);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 27, 27, 27),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: (_selectedElement == index)
                              ? Colors.green
                              : const Color.fromARGB(255, 89, 89, 89),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _elements[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: const Color.fromARGB(163, 138, 200, 255),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 108, 174, 255),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Kararsız kaldığın şey'),
                                  content: TextField(
                                    autofocus: true,
                                    controller: _textController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Kapat'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _elements.add(_textController.text);
                                        });

                                        Navigator.of(context).pop();
                                        _textController.clear();
                                      },
                                      child: Text('Kaydet'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.add),
                            iconSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 125,
                        height: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 30, 232, 36),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              selectRandomNumber();
                            },
                            icon: Icon(Icons.play_arrow_rounded),
                            iconSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
