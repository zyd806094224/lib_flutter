import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFlutterPage extends StatelessWidget {
  static const platform = MethodChannel('com.example/custom_flutter_activity');

  const CustomFlutterPage({super.key});

  // 调用原生 Toast
  void _showNativeToast() async {
    try {
      await platform.invokeMethod('showNativeToast', {
        'message': '这是 Flutter 调用的原生 Toast',
      });
    } on PlatformException catch (e) {
      log("调用失败：${e.message}");
    }
  }

  // 调用原生关闭页面
  void _finishActivity() async {
    await platform.invokeMethod('finishActivity');
  }

  @override
  Widget build(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    final String? route = routeSettings?.name; // 路由字符串：/detail?id=123&name=测试商品...

    // 解析参数（类似 URL Query 解析）
    final params = <String, String>{};
    if (route != null && route.contains('?')) {
      final query = Uri.parse(route).queryParameters;
      params['id'] = query['id'] ?? '';
      params['name'] = query['name'] ?? '';
      params['price'] = query['price'] ?? '';
    }

    // 使用 WillPopScope 拦截返回事件
    return WillPopScope(
      onWillPop: () async {
        // 调用原生方法关闭 Activity
        _finishActivity();
        // 返回 false，阻止 Flutter 的默认返回行为
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("自定义 FlutterActivity 页面")),
        body: Center(
          child: Column(
            children: [
              // 显示接收到的参数
              if (params.isNotEmpty) ...[
                const Text('接收到的参数:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('ID: ${params['id']}'),
                Text('Name: ${params['name']}'),
                const SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: _showNativeToast,
                child: const Text("调用原生 Toast"),
              ),
              ElevatedButton(
                onPressed: _finishActivity,
                child: const Text("关闭页面（原生处理）"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}