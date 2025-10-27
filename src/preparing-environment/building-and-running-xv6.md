## Building and Running xv6

To build and run the operating system, execute the following commands:

```bash
git clone git@github.com:tutorin-tech/xv6-riscv.git
cd xv6-riscv
make docker-qemu
```

xv6 will build, launch, and drop you into its shell. Just remember that everything is running inside QEMU. To quit QEMU, type `Ctrl-a x` (press `Ctrl` and `a` at the same time, then `x`).
