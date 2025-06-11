#bits 16

#subruledef reg {
    r0 => 0
    r1 => 1
    r2 => 2
    r3 => 3
}
#ruledef {
    add {rd:reg}, {value} => value`8 @ 0`2 @ rd`2 @ 0`3 @ 0`1
    add {rd:reg}, {rs:reg} => 0`8 @ rs`2 @ rd`2 @ 0`3 @ 1`1
    move {rd:reg}, {value} => value`8 @ 0`2 @ rd`2 @ 6`3 @ 0`1
    move {rd:reg}, {rs:reg} => 0`8 @ rs`2 @ rd`2 @ 6`3 @ 1`1
    jump {rd:reg}, {value} => value`8 @ 0`2 @ 0`2 @ rd`2 @ 1`1
}


    add r1, 5

    