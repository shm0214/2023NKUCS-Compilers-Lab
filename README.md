# 2021Fall NKUCS Course - Principle of Compilers

> Lab6: Type Check & Intermediate Code Generation
>
> Author: Emanual20 YoungCoder
> 
> Date: 2021/11/14

## 编译器命令
```
Usage：build/compiler [options] infile
Options:
    -o <file>   Place the output into <file>.
    -t          Print tokens.
    -a          Print abstract syntax tree.
    -i          Print intermediate code
```

## Makefile使用

* 修改测试路径：

默认测试路径为test，你可以修改为任意要测试的路径。我们已将最终所有测试样例分级上传。

如：要测试level1-1下所有sy文件，可以将makefile中的

```
TEST_PATH ?= test
```

修改为

```
TEST_PATH ?= test/level1-1
```

* 编译：

```
    make
```
编译出我们的编译器。

* 运行：
```
    make run
```
以example.sy文件为输入，输出相应的中间代码到example.ast文件中。

* 测试：
```
    make testlab6
```
该命令会默认搜索test目录下所有的.sy文件，逐个输入到编译器中，生成相应的中间代码.ll文件到test目录中。你还可以指定测试目录：
```
    make testlab6 TEST_PATH=dirpath
```

* LLVM IR
```
    make llvmir
```
使用llvm编译器生成中间代码。

* 清理:
```
    make clean
```
清除所有可执行文件和测试输出。
