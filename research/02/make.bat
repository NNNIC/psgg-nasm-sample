call "%VS140COMNTOOLS%\VsDevCmd.bat"
nasm -fwin32 helloworld.asm
link helloworld.obj /ENTRY:main /SUBSYSTEM:CONSOLE /defaultlib:kernel32.lib
helloworld.exe
pause