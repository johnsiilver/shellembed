# ShellEmbed

This is an example of how you could embed versions of a Go binary into a shell script and then use that shell script on any platform you support.

In this version, I support OSX for arm64 and Linux with amd64. This has a builder script that builds the versions I care about, puts them in a tarball and embeds them in a shell script.

When you run the shell script, it determines the OS+Arch version and calls the binary for that platform. If you pass arguments to the shell script they are sent to the binary.

You could modify this to be more size friendly and have it download the version from a repo instead of having it embedded.

## How this works:

* bin/ is where our Go binaries are stored
* hello.go is our Go main file
* kusto.sh is the shell script skeleton
* run.sh is the shell script that embeds our Go binaries and then executes the one for the platform
* build_for_platform.sh build our Go binaries, and build the run.sh file

So, to build the shell script:

```bash
./build_for_platform.sh
```

This is going to build all the go binaries we care about, tar them, make a copy of hello.sh called run.sh and embed the tar file at the end.

To execute:

```bash
./run.sh John
```

This unpacks the tar file into a tmp directory, figures out the os+arch version and calls that binary passing any arguments to the shell script.

With this argument "John", you should see something like:

```bash
hello John from: darwin/arm64
```

If you pass with no arguments, you will get something like:

```bash
hello someone from: darwin/arm64
```
