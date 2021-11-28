# 2021Fall NKUCS Course - Principle of Compilers

> Lab7: Machine Code Generation
>
> Author: Emanual20 YoungCoder feilll
> 
> Date: 2021/11/28

## 编译器命令
```
Usage：build/compiler [options] infile
Options:
    -o <file>   Place the output into <file>.
    -t          Print tokens.
    -a          Print abstract syntax tree.
    -i          Print intermediate code
    -S          Print assembly code
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
以example.sy文件为输入，输出相应的中间代码到example.s文件中。

* 测试：
```
    make testlab7
```
该命令会默认搜索test目录下所有的.sy文件，逐个输入到编译器中，生成相应的汇编代码.s文件到test目录中。你还可以指定测试目录：
```
    make testlab7 TEST_PATH=dirpath
```
* 批量测试：
```
    make test
```
使用gcc将.s文件汇编成二进制文件后执行， 将得到的输出与标准输出对比， 验证编译器实现的正确性。
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
