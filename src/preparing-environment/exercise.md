## Exercise

Get comfortable with GDB by stepping through the `kfork` function. Here's some reference information to make the process a bit more fun.

`kfork` creates an almost exact copy of the current process, which will then run independently. The parent process receives the child's PID, and the child receives 0, allowing both to determine who is who. The work `kfork` does can be broken down into five steps:

1. The function allocates space for a new empty process and prepares it to run.
2. `kfork` then copies the parent process's memory — everything currently loaded into memory (code, data, etc.) is duplicated for the new process.
3. Next, the function sets up the child's execution context: the new process gets the same starting point as the parent, but with one key difference — when it returns from `kfork`, it will see the value 0, so it can tell it's the child.
4. `kfork` then transfers resources to the child: the new process receives copies of all open files and the parent's current working directory.
5. Finally, the function marks the child process as ready to run, so the scheduler can pick it up and execute it.
