# lib_flutter

这是一个用于原生Android/iOS应用集成的Flutter模块项目。该模块演示了如何在原生应用中嵌入Flutter页面，并实现Flutter与原生平台之间的双向通信。

## 功能特性

- 作为可嵌入原生应用的Flutter模块
- 实现Flutter与原生平台的双向通信
- 支持通过路由参数传递数据到Flutter页面
- 自定义页面关闭逻辑，允许原生应用处理页面关闭事件
- 提供调用原生Toast功能的示例

## 核心组件

### CustomFlutterPage

这是项目的主要页面，展示了以下功能：

1. 接收并解析从原生应用传递的路由参数（如 `/custom_flutter_page?id=123&name=测试商品`）
2. 通过MethodChannel实现Flutter调用原生功能：
   - 显示原生Toast提示
   - 调用原生方法关闭当前页面
3. 拦截返回事件，将页面关闭操作交由原生处理

## 集成说明

此Flutter模块设计为嵌入到现有的原生移动应用中，而非独立运行的应用程序。有关如何将Flutter模块集成到现有应用程序的详细信息，请参阅[add-to-app文档](https://flutter.dev/docs/development/add-to-app)。

## 开发环境

- Flutter SDK 3.0.6 或更高版本
- Android API level 21 或更高版本
- iOS 9.0 或更高版本

## 快速开始

如需在原生应用中使用此模块，请参考官方[add-to-app文档](https://flutter.dev/docs/development/add-to-app)进行集成。
