# qemu-aarch64-pi
This build is used to compile and run assembly / C++ / C code on an ARMv8 - AArch64 - Raspberry Pi using QEMU.

**Use only for education**

Most of the incredible work comes from: **Mikolaj Stawiski**

- [His original Article](https://interrupt.memfault.com/blog/emulating-raspberry-pi-in-qemu)
- [His Docker container](https://hub.docker.com/r/stawiski/qemu-raspberrypi-3b)
- [His repository](https://github.com/memfault/interrupt/blob/master/example/emulating-raspberry-pi-in-qemu/Dockerfile)

*Note:* The emulation doesn't have good performance so it may not be suited for big projects.

It is possible to change the Pi model, the architecture, and the OS.
In this build, the legacy and lite version of Raspberry Pi OS is used.
**Using a newer version of the Raspberry Pi OS may not work.**
(I tested it with the newest lite version and it wasn't working.)

*Note:* I tried to keep the Docker image small.

If you don't have Docker on your local machine, use a GitHub Codespace.

# Run the Docker container from Docker Hub
```sh
  $ docker run -it --rm -p 2222:2222 dockertomschmidt/qemu-aarch64-pi:latest
```
In GitHub Codespace, use port 55555 (or another port) instead of 2222:
```sh
  $ docker run -it --rm -p 55555:2222 dockertomschmidt/qemu-aarch64-pi:latest
```

## OR

## Build and Run the Docker container
Build the Dockerfile with:
```sh
  $ docker build -t qemu-aarch64 .
  $ docker run -it --rm -p 2222:2222
```

Wait for the login prompt to appear. Maybe press enter to show the login message from the Raspberry Pi OS.
The basic username | password is: pi | raspberry

## Login over SSH
```sh
  $ ssh -p2222 pi@localhost
```

Login with the default username | password: pi | raspberry

Use the following to login without a password to make the section "Compile and Run" work smoothly:
```sh
  $ ssh-keygen -t rsa
  $ ssh-copy-id -p 2222 -i ~/.ssh/id_rsa.pub pi@localhost
```

You may need to change ownership and permissions:
```sh
  $ chown user:user /home/user/.ssh/known_hosts
  $ chown user:user /home/user/.ssh
  $ chmod 700 /home/user/.ssh
  $ chmod 600 /home/user/.ssh/known_hosts
```

## Compile and Run
Use these VS Code included tasks to copy the files from the working directory to the Pi.
The tasks must be in .vscode -> tasks.json.
Run with Ctrl + Shift + B.

Use the included CompileAndRun.sh bash script on the Pi to compile and run all .c, .cpp, .s files in the directory.
```sh
source ./CompileAndRun.sh
```
to run the script.
