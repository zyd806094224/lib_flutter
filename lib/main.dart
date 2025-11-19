import 'package:flutter/material.dart';
import 'package:lib_flutter/CustomFlutterPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // 移除 routes 属性，改用 onGenerateRoute
      initialRoute: '/', // 设置初始路由
      onGenerateRoute: (settings) {
        // settings.name 将会是原生传递过来的完整路由字符串
        // 例如：/custom_flutter_page?id=123&name=测试商品

        final uri = Uri.parse(settings.name ?? '');

        switch (uri.path) {
          case '/custom_flutter_page':
            // 直接返回 CustomFlutterPage 即可，页面内部会解析参数
            // 将 settings 传递过去，以便页面能访问到 name 和 arguments
            return MaterialPageRoute(
              builder: (context) => const CustomFlutterPage(),
              settings: settings, // 关键步骤：传递 settings
            );
          case '/':
          default:
            // 默认路由
            return MaterialPageRoute(
              builder: (context) =>
                  const MyHomePage(title: 'Flutter Demo Home Page'),
            );
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}