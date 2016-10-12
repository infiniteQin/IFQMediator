# IFQMediator
iOS组件化Mediator方案
结合CTMediator和蘑菇街protocol方案的中间件
基本参考CTMediator将target-action换成protocol，解决target-action方案中硬编码问题。

* 安全:基本沿用CTMediator的方案，用前缀区分只服务本地调用的方法;

* 动态调度:相比CTMediator四种不同的切点IFQMediator的切点更少，跨业务组件的动态调用更易实现。只要以category调度方法为切点，就能覆盖远程调用和本地跨模块调用。

    至于是启动时下载动态调度列表调用Mediator+category方法时审查，还是Mediator+category调用用Api事实审查就看业务需求了。。


