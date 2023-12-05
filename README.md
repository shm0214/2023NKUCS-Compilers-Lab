# 南开大学编译系统原理课程实验
<a href="https://github.com/shm0214/2023NKUCS-Compilers-Lab">
    <img alt="license" src="https://img.shields.io/github/license/shm0214/2023NKUCS-Compilers-Lab.svg"/>
</a>
<a href="https://github.com/shm0214/2023NKUCS-Compilers-Lab">
    <img alt="stars" src="https://img.shields.io/github/stars/shm0214/2023NKUCS-Compilers-Lab.svg"/>
</a>
<a href="https://github.com/shm0214/2023NKUCS-Compilers-Lab">
    <img alt="forks" src="https://img.shields.io/github/forks/shm0214/2023NKUCS-Compilers-Lab.svg"/>
</a>

本项目实现一个SysY语言的编译器，包含[词法分析](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/lab3)、[语法分析](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/lab4)、[语义分析与中间代码生成](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/lab5)、[目标代码生成](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/lab6)等四次实验。你可以仅从[main分支](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/main)开始实验，也可以从[lab3分支](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/lab3)到[lab6分支](https://github.com/shm0214/2023NKUCS-Compilers-Lab/tree/lab6)逐步完成词法分析、语法分析、语义分析与中间代码生成、目标代码生成等实验内容，最终实现一个将SysY语言翻译到arm汇编的编译器。

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

## VSCode调试

提供了VSCode调试所需的`json`文件，使用前需正确设置`launch.json`中`miDebuggerPath`中`gdb`的路径。`launch.json`中`args`值即为编译器的参数，可自行调整。

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
以example.sy文件为输入，输出相应的汇编代码到example.s文件中。

* 测试：
```
    make testlab6
```
该命令会搜索TEST_PATH目录下所有的.sy文件，逐个输入到编译器中，生成相应的汇编代码.s文件。你还可以指定测试目录：
```
    make testlab6 TEST_PATH=dirpath
```
* 批量测试：
```
    make test
```
对TEST_PATH目录下的每个.sy文件，编译器将其编译成汇编代码.s文件， 再使用gcc将.s文件汇编成二进制文件后执行， 将得到的输出与标准输出对比， 验证编译器实现的正确性。错误信息描述如下：
|  错误信息   | 描述  |
|  ----  | ----  |
| Compile Timeout  | 编译超时， 可能是编译器实现错误导致， 也可能是源程序过于庞大导致(可调整超时时间) |
| Compile Error  | 编译错误， 源程序有错误或编译器实现错误 |
|Assemble Error| 汇编错误， 编译器生成的目标代码不能由gcc正确汇编|
| Execute Timeout  |执行超时， 可能是编译器生成了错误的目标代码|
|Execute Error|程序运行时崩溃， 可能原因同Execute Timeout|
|Wrong Answer|答案错误， 执行程序得到的输出与标准输出不同|

具体的错误信息可在对应的.log文件中查看。

* GCC Assembly Code
```
    make gccasm
```
使用gcc编译器生成汇编代码。

* 清理:
```
    make clean
```
清除所有可执行文件和测试输出。
```
    make clean-test
```
清除所有测试输出。
```
    make clean-app
```
清除编译器可执行文件。