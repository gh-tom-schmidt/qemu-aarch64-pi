# qemu-aarch64-pi
This build is used to compile and run assembly / cpp / c code on an armv8 - aarch64 - raspberry pi using QEMU.

**Use only for education** 

Most of the increadible work comes from: **Mikolaj Stawiski**
- [His original Article][https://interrupt.memfault.com/blog/emulating-raspberry-pi-in-qemu]
- [His docker conatiner][https://hub.docker.com/r/stawiski/qemu-raspberrypi-3b]
- [His repo][https://github.com/memfault/interrupt/blob/master/example/emulating-raspberry-pi-in-qemu/Dockerfile]

*Note:* The emulation hasnt a good performance so it may not be suited for big projects.

## Run the docker container
Build the docker file with:
```sh
  $ docker build -t qemu-aarch64 .
  $ docker run -it --rm -p 2222:2222
```

Wait for the loggin to appeare. Maybe press enter to show the login message from the raspberry os.
The basic username | password is: pi | raspberry

## Login over ssh
```sh
  $ ssh -p2222 pi@localhost
```

Login with the default username | password: pi | raspberry

Use the following to login without a password to make the section "Comile and Run" worke smoothly:
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
Use these VS Code included task to copy the files from the working directory to the pi.
The task must be in .vscode -> tasks.json
Run with STRG + SHIFT + B.

Use the included CompileAndRun.sh bash script on the pi to compile and run all .c , .cpp, .s files in the directory.
User
```sh
source ./CompileAndRun.sh
```
to run the script.
