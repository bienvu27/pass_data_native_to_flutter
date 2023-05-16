import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const channel = MethodChannel("flutter");
  var color = "0XFF00FF00";

  setColor(clr) {
    setState(() {
      color = clr;
    });
  }

  Future<void> changeColor() async {
    try {
      var res = await channel.invokeMethod("changeColor");
      setColor(res);
    } on PlatformException catch (e) {
      print("Failed to get battery level: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse(color)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setColor("0XFF00FFFF");
              },
              child: Text('Flutter'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: ()=> changeColor(),
              child: Text('Native'),
            ),
          ],
        ),
      ),
    );
  }
}
