# RobotFrameworkAppiumIntegration
An integration for RobtFramework and Appium, to support off-line installation with one-click

将RobotFramework 和 Appium 依赖的相关的库，整合在一块儿，方便直接建立自动化测试环境。
整合的内容包括：
1. appium desktop  一个可视化的Appium Server
2. robot framework 一个自动化测试框架
3. appium-python-client  一个appium的客户端，基于python语言实现
4. appium-robotframework-client  一个robotframework的测试库，集成了appium的各种方法
5. 其他以上库依赖的各种库



目前是以python3为基准，因为有一些库实际python3不一定稳定，所以实际可能有意外结果。

使用方法：
双击执行install.bat，运行成功提示install success； 运行失败提示install failed。
