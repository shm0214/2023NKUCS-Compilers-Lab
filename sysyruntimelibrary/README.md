# 测试用例

`section1`:存放初赛的测试用例

`section1\functinal_test` ：存放功能测试用例,共111个测试用例，每个测试用例由同名文件的`.sy` , `.out`和`.in`文件组成

`section1\performance_test` ：存放性能测试用例,共15个测试用例

`section2`:存放决赛赛的测试用例

`section2\performance_test` ：存放性能测试用例,共15个测试用例

`libsysy.a`: arm架构的SysY运行时静态库

`libsysy.so`: arm架构的SysY运行时动态库

`sylib.h`: SysY运行时库头文件

`sylib.c`: SysY运行时库源文件

# 测评程序代码

`source`:用于存放测评程序的部分代码,`Compiler.java`负责编译从gitlab上拉取的项目

# 测评镜像

测评镜像的Dockerfile被存放在`docker`文件夹下,其中ARM-Dockerfile是树莓派上的汇编链接镜像,x86-Dockerfile是x86上的编译测评镜像