# Operating system interface

The job of an operating system is to share a computer among multiple programs and to provide a more useful set of services than the hardware alone supports. An operating system manages and abstracts the low-level hardware, so that, for example, a word processor need not concern itself with which type of disk hardware is being used. An operating system shares the hardware among multiple programs so that they run (or appear to run) at the same time. Finally, operating systems provide controlled ways for programs to interact, so that they can share data or work together.

An operating system provides services to user programs through an interface. Designing a good interface turns out to be difficult. On the one hand, we would like the interface to be simple and narrow because that makes it easier to get the implementation right. On the other hand, we may be tempted to offer many sophisticated features to applications. The trick in resolving this tension is to design an interface that relies on a few mechanisms that can be combined to provide much generality.

xv6, a reimplementation of the Sixth Edition of UNIX, inherits the basic interface designed by **Ken Thompson** and **Dennis Ritchie**, as well as mimicking the internal design of that operating system. Unix provides a narrow interface whose mechanisms combine well, offering a surprising degree of generality. This interface has been so successful that modern operating systems—BSD, Linux, macOS, Solaris, and even, to a lesser extent, Microsoft Windows—have a Unix-like interface. Understanding xv6 is a good start toward understanding any of these systems and many others.

As [Figure 1.1](#figure-1-1) shows, xv6 takes the traditional form of a _kernel_, a special program that provides services to running programs. Each running program, called a _process_, has memory containing instructions, data, and a stack. The _instructions_ implement the program's computation. The _data_ are the variables on which the computation acts. The _stack_ organizes the program's procedure calls. A given computer typically has many processes but _usually_[^3] only one kernel.

<div align="center">
    <figure id="figure-1-1">
      <img src="fig/os.svg">
      <figcaption><strong>Figure 1.1</strong> A kernel and two user processes.</figcaption>
    </figure>
</div>

When a process needs to invoke a kernel service, it invokes a _system call_, one of the calls in the operating system's interface. The system call enters the kernel; the kernel performs the service and returns. Thus a process alternates between executing in user space and kernel space. As described in detail in subsequent chapters, the kernel uses the hardware protection mechanisms provided by a CPU[^4] to ensure that each process executing in user space can access only its own memory. The kernel executes with the hardware privileges required to implement these protections; user programs execute without those privileges. When a user program invokes a system call, the hardware raises the privilege level and starts executing a pre-arranged function in the kernel.

The collection of system calls that a kernel provides is the interface that user programs see. The xv6 kernel provides a subset of the services and system calls that Unix kernels traditionally offer.

The rest of this chapter outlines xv6's services—processes, memory, file descriptors, pipes, and a file system—and illustrates them with code snippets and discussions of how the shell, Unix's command-line user interface, uses them. The shell's use of system calls illustrates how carefully they have been designed.

The shell is an ordinary program that reads commands from the user and executes them. The fact that the shell is a user program, and not part of the kernel, illustrates the power of the system call interface: there is nothing special about the shell. It also means that the shell is easy to replace; as a result, modern Unix systems have a variety of shells to choose from, each with its own user interface and scripting features. The xv6 shell is a simple implementation of the essence of the Unix Bourne shell. Its implementation can be found at [(user/sh.c:1)](https://github.com/tutorin-tech/xv6-riscv/blob/riscv/user/sh.c).

[^3]: Running multiple Linux kernels on a single machine is now of interest not only academically but also in practice. Over time, you’ll see such multi-kernel setups more often. That said, this configuration definitely won’t be typical, which is why I emphasized the word “usually” in the text.

[^4]: This text generally refers to the hardware element that executes a computation with the term CPU, an acronym for central processing unit. Other documentation (e.g., the RISC-V specification) also uses the words processor, core, and hart instead of CPU.
