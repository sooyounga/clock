# clock
a set of counters suitable for use as a 12-hour clock (with am/pm indicator) implemented in Verilog

* counters are clocked by a fast-running _clk_, with a pulse on _ena_ whenever the clock should increment (i.e., once per second)
* _reset_ resets the clock to 12:00 AM
* _pm_ is 0 for AM and 1 for PM
* _hh_, _mm_, and _ss_ are two BCD (Binary-Coded Decimal) digits each for hours (01-12), minutes (00-59), and seconds (00-59)
* _reset_ has higher priority than _ena_, and can occur even when not enabled

problem adapted from https://hdlbits.01xz.net/wiki/Count_clock
