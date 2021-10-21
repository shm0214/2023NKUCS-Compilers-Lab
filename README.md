# 2021lab4-Skeleton
For 2021Fall NKUCS Course - Principle of Compilers Lab4-5

> Author: Emanual20
> 
> Date: 2021/10/21

目前使用方式：

- make testlabfour: 编译lexer.l，测试test/lab4下所有sy文件。注意需要解注释ONLY_FOR_LEX宏定义，测试文件要以sy结尾。
- make cleanlabfour: 清理通过make testlabfour编译出的二进制文件及测试结果。
- make run: 编译完整工程，测试sample.sy。注意需要注释ONLY_FOR_LEX宏定义，为了测试某目录下多文件你可以仿照make testlabfour仿写，测试文件要以sy结尾。
- make clean: 清理通过make run编译出的二进制文件及测试结果。

根目录下有include, src, sysyruntimelibrary, test四个文件夹，分别表示所需头文件，源文件，SysY运行时库，测试样例的存放位置。

include目录下有Ast.h，表示语法树相关实现；SymbolTable.h，表示符号表相关实现；Type.h，表示类型系统相关实现。

src目录下和include目录下文件名相同的可对应理解。

学有余力的同学，鼓励一次性完成语法分析，对理解该过程更具有连贯性。 
