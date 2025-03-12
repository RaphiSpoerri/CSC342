
# Add/Sub Processor

Unfortunately, I was not able to make it work in the end. It has a bug that causes registers to hold undefined values, and I don't have enough time to fix it.
I have a working example in `test/debug.vhd`, which doubles a number.

To run it, install GHDL with LLVM or GCC as a backend. Then run
```
./proj -r debug
```
Output
```
src/processor/processor.vhd:34:17:@5ns:(report note): 00000000000000000000000000001111
test/debug.vhd:29:17:@20ns:(report note): 00000000000000000000000000001111
src/processor/processor.vhd:34:17:@26ns:(report note): 00000000000000000000000000001111
src/processor/processor.vhd:34:17:@42ns:(report note): 00000000000000000000000000011110
```
