# Introduction

### What is xv6

xv6 was originally created for the MIT operating systems course in the summer of 2006, and its first public release came out in the fall of 2011 for the x86 architecture. In September 2019, xv6 was ported to RISC-V. Now, you might reasonably ask: why create a new operating system at all? Why not just use Linux? After all, there's a successful precedent: in the book **Understanding the Linux Kernel**, its authors **Daniel Bovet** and **Marco Cesati** described how they used Linux as a case study in their operating systems lectures at the University of Tor Vergata in Rome. But here is an interesting detail: they started using Linux for teaching in 1997, and the first edition of their book was published in 2000. At that time, Linux was still a relatively compact kernel with many straightforward design decisions. Even by the time the third edition came out in 2005, Linux was still simple enough to study meaningfully in an academic context. Today, however, it's no longer suitable for demonstrating core operating-system design concepts, since every subsystem — whether it's the scheduler or the memory-management system — requires a significant part of one's life to properly understand. Meanwhile, students typically only have a single semester for an operating systems course.

MIT has always had its own way of doing things. Back when it was still feasible to use early Linux for teaching, the institute chose to rely instead on the 6th Edition of the original UNIX — known as V6. It's hard to imagine what kind of hell those students had to go through — armed with **John Lions**'s commentary on V6, they dove into a 30-year-old operating system written in an early version of C (a predecessor of K&R) and running on aging PDP-11 hardware. And when it became clear around 2006 that it was time to move away from V6 toward something more practical, Linux had already grown too complex for teaching purposes. That is most likely how the teaching operating system xv6 came to be. It was inspired by V6 and built by reworking it, but xv6 is not a direct port. Unlike V6, it uses the modern ELF executable format, like modern Unix-like systems[^1] systems from the Linux and BSD families, and it supports multicore processors. Concurrency in xv6 is implemented with locks and threads. Today, the operating system consists of just over 9,000 lines of modern C code, not counting comments.

Why xv6 was ported from x86 to RISC-V in 2019 is not entirely clear to me. I've seen claims that the goal was to move away from emulators and run the OS on real hardware, but that argument feels pretty weak — in 2019 x86 was still an extremely popular architecture with plenty of hardware available in every shape and size, while RISC-V still looked like an academic curiosity. That said, RISC-V's position today is much stronger than it used to be, and using it as the target architecture for xv6 now looks perfectly reasonable. Even better, it gives us a chance to talk about RISC-V in this book — which is exactly what we're about to do.

### RISC-V

RISC-V began as a research project at the University of California, Berkeley in May 2010. Today, RISC-V provides an open and flexible instruction set architecture (ISA), allowing the development of processors for any application areas without licensing fees or usage restrictions.

RISC-V support is pretty much everywhere now. Here are a few key examples:

- In Linux, starting from version 4.15 (released January 28, 2018)
- In Debian, unofficially starting April 2, 2018, and officially from July 23, 2023
- In Android, starting October 23, 2022

On March 1, 2021, it became known that MIPS Technologies was switching to developing the eighth generation of MIPS based on RISC-V. Previously, MIPS processors were used in the Nintendo 64, Sony PlayStation, PlayStation 2, PlayStation Portable, and in many routers. That's how RISC-V pushed MIPS out — and ARM might be next. The thing is, unlike RISC-V, ARM requires licensing fees, so in the near future we may well see RISC-V displacing ARM in the consumer electronics market.

Despite the progress in building hardware on this open architecture, Linus Torvalds expressed concern in April 2024[^2] that RISC-V may repeat the mistakes of its predecessors. According to him, we've seen this before: when ARM became a server platform, it began stepping on the same rakes as x86.

### xv6 architecture

Operating systems can be classified by purpose and by kernel architecture. As for purpose, we've already discussed that xv6 is a narrowly focused OS designed to serve as a case study for students learning operating-system design. Now let's turn to its kernel architecture.

The xv6 kernel is _monolithic_. This means that all of its services run in a single address space in _privileged mode_, so interaction between different kernel subsystems is very straightforward: the kernel can simply call functions directly, just like user-space programs do. This makes monolithic kernels very fast and keeps their design simple. The downside is reliability: if one subsystem crashes, the entire system crashes with it. V6 and Linux are both monolithic kernels. In many ways, xv6 resembles early Linux.

Monolithic kernels are typically contrasted with _microkernels_, where kernel subsystems are isolated and independent, each running in its own address space, and communication between them is message-based. Moreover, according to the canons of microkernel architecture, only those components that truly require privileged execution should run in privileged mode; everything else should run in _non-privileged mode_. As you might guess, this significantly complicates the kernel design and leads to performance loss — but the reward is reliability: a failure in one subsystem only affects that subsystem. To avoid sacrificing performance while still benefiting from microkernel reliability, modern microkernel-based operating systems — such as macOS — run all major OS components in privileged mode. This approach is known as a _hybrid_ design. In this case, substantial resources are saved by avoiding context switches during message passing between subsystems.

### Overview of Other Operating Systems

The goal of this section is to help you answer the question of where you can apply the knowledge and skills you've gained after you turn the last page of this book. Certainly, some of you may decide to become kernel hackers and start building a path toward contributing to the Linux kernel. But for others, Linux development might feel like too ambitious a starting point. So in this section, I suggest looking at two other compact specialized operating systems and two general-purpose ones that you may want to explore more deeply later on — and perhaps even contribute to.

All of the operating systems listed below are open-source.

#### Hermit

[Hermit](https://hermit-os.org) is a unikernel written in Rust. It provides a runtime environment for a single application written in C/C++, Go, or Fortran. This application is bundled together with the kernel, making it self-contained and able to run on machines without an operating system. Hermit is particularly well suited for running applications in virtual machines, where the hardware set is limited and predictable, eliminating the need to ship drivers for every possible device. However, nothing prevents you from running such a system on bare metal — especially when targeting a specific device with a known, fixed hardware configuration.

#### Redox

[Redox](https://redox-os.org) is a microkernel-based, Unix-like general-purpose operating system, also written in Rust. True to microkernel principles, all driver code in Redox runs in non-privileged mode.

For compatibility with existing applications, Redox provides a POSIX compatibility layer that allows many programs to run without modification. Moreover, on May 31, 2025, support for X11 was announced in the display server, meaning Redox can now run unmodified X11-based applications.

Redox has a real chance of maturing into a full-fledged Unix-like operating system where Linux users will feel at home and won't suffer from a lack of software, since most applications will run without porting. Notably, for its userland, Redox uses the Rust-based `uutils coreutils` suite — the same one used in Ubuntu starting from version 25.10.

#### MicroPythonOS

[MicroPythonOS](https://micropythonos.com) is an operating system for microcontrollers such as the ESP32. It is written in Python and uses the MicroPython interpreter — a lightweight and efficient implementation of the language specifically designed for embedded systems.

The architecture of MicroPythonOS follows the “everything is an app” philosophy: the system kernel handles hardware initialization, multitasking, and the UI, while system functions like Wi-Fi configuration or updates are implemented as separate applications. Applications are also meant to be written in Python.

MicroPythonOS features an Android-like user interface, an app store, and over-the-air updates.

#### Asterinas

[Asterinas](https://asterinas.github.io) is a general-purpose operating-system kernel, also written in Rust. Its key feature is binary compatibility with Linux. Thanks to this, the Linux kernel can be seamlessly replaced by Asterinas without breaking user-space applications, while improving memory-safety guarantees.

[^1]: Except for macOS, which uses Mach-O.

[^2]: The interview “Keynote: Linus Torvalds, Creator of Linux & Git, in Conversation with Dirk Hohndel” on The Linux Foundation channel, published on April 26, 2024.
