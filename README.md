# cuebf
Brainf*ck interpreter written in CUE (https://cuelang.org/)

# usage

```bash
# evaluate hello.bf
$ cue bf
```

NOTE: Though this can evaluate helloworld program technically,
it spends too much memory to execute...

```bash
$ cue bf
runtime: VirtualAlloc of 8192 bytes failed with errno=1455
fatal error: out of memory
```
