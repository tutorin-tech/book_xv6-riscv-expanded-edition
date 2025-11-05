## Tooling

To build and run xv6, you only need **Docker** and the **make** utility installed. Everything else happens automatically: **QEMU** will run inside the Docker container, and xv6 will run inside QEMU.

QEMU is currently one of the most rapidly evolving open-source projects and plays a critical role for GNU/Linux distributions and other open-source systems that support multiple architectures. Instead of having physical hardware for every architecture you want to build for, you simply use the most common hardware on the market and rely on QEMU to emulate the rest. Over the years, QEMU has grown to support full emulation for 14 hardware architectures, and the number of emulated devices now exceeds 400.

xv6 supports only the RISC-V architecture. Most likely, your machine uses either an ARM or x86 processor, so we'll take the same approach: we'll use QEMU to build and run xv6.
