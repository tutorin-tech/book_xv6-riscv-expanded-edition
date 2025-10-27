# Introduction

## What is xv6

xv6 was designed for MIT's operating system classes in the summer of 2006, and its first public release came out in the fall of 2011 for the x86 architecture. In September 2019, it was ported to RISC-V.

Now, you might reasonably ask: why did they need to create a new operating system for this? Why not just use Linux? After all, there's a good precedent: in the book Understanding the Linux Kernel, its authors Daniel Bovet and Marco Cesati described how they used Linux as a case study in their operating systems classes at the University of Tor Vergata in Rome.

However, the authors began using Linux for this purpose back in 1997, and the first edition of their book was published in 2000 — when Linux was still a relatively compact operating system kernel full of straightforward design choices. Even by the third edition in 2005, Linux was still fairly simple. But today, Linux is way too complex to demonstrate operating system design concepts. Every part of the kernel — whether it's the scheduler or the memory management subsystem — could take a lifetime to fully understand. And students usually only have one semester for an OS course.

MIT, of course, took its own path. Back when Linux was still a viable option, they chose to use the sixth edition of the original UNIX, known as V6. It's hard to imagine the kind of hell those students went through — studying a 30-year-old operating system written in an early version of C (a predecessor to K&R) and running on obsolete PDP-11 hardware. By around 2006, though, it became clear that V6 needed to be replaced with something more practical. But by that time, Linux had already grown too complex for teaching. And that's most likely how xv6 came to be.

Today, xv6 has just over 9,000 lines of modern C code, not counting comments. Unlike V6, it supports multicore processors, with concurrency implemented through locks and threads.

As for why xv6 was ported from x86 to RISC-V in 2019 — that part still puzzles me. I've read that it was done to move away from emulators and run the OS on real hardware, but that argument seems weak. In 2019, x86 was still everywhere, while RISC-V was little more than an academic curiosity. That said, RISC-V's position today looks much stronger, and using it as xv6's target architecture now makes perfect sense. Plus, it gives us a good reason to talk about RISC-V later in this guide — which, trust me, we will.

## Architecture of xv6

Now let's talk about where xv6 fits in the world of operating systems.

The xv6 kernel is monolithic — all its services run within a single address space and in privileged mode, which makes interaction between subsystems extremely straightforward — the kernel can simply call functions directly, just like user-space applications do. This design makes monolithic kernels both fast and simple, but at the cost of reliability: if one subsystem crashes, the entire system goes down with it.

Both V6 and Linux are examples of monolithic kernels. In fact, xv6 closely resembles early versions of Linux, making it an ideal starting point for anyone dreaming of one day becoming a Linux kernel hacker.

Monolithic kernels are often contrasted with microkernels, where kernel subsystems are isolated and independent, each running in its own address space and communicating via message passing. According to the principles of microkernel design, only those subsystems that truly need privileged access should have it — everything else should operate separately. As you can imagine, this approach greatly complicates kernel design and reduces performance, but the reward is stability — a crash in one subsystem is only that subsystem's problem.

To strike a balance between performance and reliability, modern microkernel-based operating systems — like macOS — often run most components in privileged mode. This approach saves a significant amount of resources by minimizing context switches during inter-subsystem communication.
