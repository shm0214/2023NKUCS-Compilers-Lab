# 2021lab5-Skeleton
For 2021Fall NKUCS Course - Principle of Compilers Lab5

> Author: Emanual20 YoungCoder
> 
> Date: 2021/10/27

## 编译器命令
```
Usage：build/compiler [options] infile
Options:
    -o <file>   Place the output into <file>.
    -t          Print tokens.
    -a          Print abstract syntax tree.
```

## Makefile使用

* 编译：
```
    make
```
编译出我们的编译器。

* 运行：
```
    make run
```
以example.sy文件为输入，输出相应的语法树到example.ast文件中。

* 测试：
```
    make testlab5
```
该命令会默认搜索test目录下所有的.sy文件，逐个输入到编译器中，生成相应的抽象语法树.ast文件到test目录中。你还可以指定测试目录：
```
    make testlab5 TEST_PATH=dirpath
```

* 清理:
```
    make clean
```
清除所有可执行文件和测试输出。
