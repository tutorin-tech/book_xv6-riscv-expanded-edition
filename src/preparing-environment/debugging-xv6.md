## Debugging xv6

There are several ways to understand how an operating system works. One of them is debugging — executing different parts of the kernel code and inspecting variables and data structures to see what's happening at each stage.

The goal of this section is to introduce you to the **GNU Debugger** (GDB) and give you a hands-on task to help you get comfortable using it.

Debugging an operating-system kernel is different from debugging any other program: the kernel must be debugged remotely, meaning the debugger runs on one machine while the OS kernel runs on another. In the modern world, virtual machines and emulators make this much easier. You've just learned how to run xv6 in QEMU, which emulates RISC-V. The choice of QEMU was not accidental — it includes a built-in stub for remote interaction with GDB. So now we'll move on to the second step: running xv6 in debug mode and attaching GDB to it. But first, let's cover a bit of theory.

There are two types of debugging:

- _Source-level debugging_ — when we have the source code, compile it with debugging information, and can step through the program line by line.
- _Binary-level debugging_ — when we don't have the source code and must rely on a disassembler, tracing, and runtime memory inspection.

Our case is source-level debugging, since we do have the xv6 source code. Moreover, you've already built xv6 with debugging information — it wasn't useful last time, but it will come in handy now.

To run the xv6 kernel under the debugger, execute the following commands:

```bash
cd xv6-riscv  # go back to the xv6 source directory
git pull
make docker-qemu-gdb
```

After that, you will see the hint:

> \*\*\* Now run 'gdb' in another window.

Now open another terminal, enter the container that is currently running, and start GDB, passing it the xv6 kernel binary:

```bash
docker exec -it <container-name> bash
gdb-multiarch kernel/kernel
```

If you see something like this:

```bash
Reading symbols from kernel/kernel...
The target architecture is set to "riscv:rv64".
0x0000000000001000 in ?? ()
(gdb)
```

then everything is working correctly. The remote debugging stub in QEMU stops the emulator before the first instruction is executed after reset — at address `0x1000` in physical memory. As a result, if you switch back to the first terminal where you started xv6 in debug mode, you'll notice that nothing appears to be happening there yet.

Return to the terminal where GDB is running. It should look familiar — much like a Bash shell — except that the prompt is `(gdb)` instead of `$`. The debugger is always in one of three states:

1. the program being debugged is running;
2. the program is paused;
3. the program is not running.

Most commands can be entered in the latter two states. Right now, the xv6 kernel is paused, and GDB is waiting for your command.

I hope you've already used debuggers in various IDEs and that the term breakpoint is familiar to you. Let's set a breakpoint on the system call `kfork` (don't worry if the term “system call” doesn't mean much to you yet, or if `kfork` just looks like a random set of letters — we'll get to all of that soon). To do this, type `b kfork`, and then c to continue execution of the xv6 kernel.

Switch back to the first terminal where xv6 is running in debug mode, and you'll see that the operating system has started booting and then stopped at:

```bash
init: starting sh
```

The reason this happens is that `kfork` is the implementation of the Unix system call `fork`, which is used to create a child process. So when the kernel finished initializing the virtual hardware and reached the point where it needed to start the shell `(sh)`, it was paused again and the debugger stopped inside `kfork`. From here, you can step through the code to see how processes are created inside the operating system. To do that, you have two commands at your disposal — `step` and `next`, which can be shortened to `s` and `n`.

- `step` executes the program one line at a time, and when it encounters a function call, it steps into that function and continues executing it line by line, recursively.
- `next` does the same thing, but does not step into functions.

By the way, using the shortcut commands `s` and `n` is not the only way to boost your productivity in the debugger. If you need to run `next` several times in a row, type `n` once and then just press Enter — GDB remembers the last executed command and repeats it when you submit an empty input.
