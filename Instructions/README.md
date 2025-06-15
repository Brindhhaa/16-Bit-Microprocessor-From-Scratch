# 📄 16-bit Processor Instruction Documentation

Below is the documentation for the custom 16-bit processor’s instruction set.

---

## Instruction List

### `nop`
- **Opcode:** `0`
- **Asm:** `nop`
- **Description:**  
  Does nothing. Stalls the processor for one clock cycle.

---

### `rets`
- **Opcode:** `1`
- **Asm:** `rets`
- **Description:**  
  Swaps the register set and program counter between system (kernel) mode and user mode. Execution resumes at the instruction after `rets` in the program for each mode. The return address and PC are restored from a saved register.

---

### `move`
- **Opcode:** `6`
- **Asm:** `move rd, rs/imm8`
- **Description:**  
  Moves the value in a register or an 8-bit immediate into another register.

---

### `loadc`
- **Opcode:** `7`
- **Asm:** `loadc rd, rs/imm8`
- **Description:**  
  Loads a constant from program memory:  
  - `rd ← pmem[pc + imm8]`  
  - `rd ← pmem[rs]`

---

### `jump`
- **Opcode:** `8`
- **Asm:** `jump rd/imm11`
- **Description:**  
  Sets the program counter to jump within the instruction stream:  
  - `pc ← rd`  
  - `pc ← pc + imm11`

---

### `call`
- **Opcode:** `10`
- **Asm:** `call rd/imm12`
- **Description:**  
  Calls a subroutine:  
  - `r0 ← pc`, `pc ← pc + imm11`  
  - `r0 ← pc`, `pc ← rd`

---

### `load`
- **Opcode:** `12`
- **Asm:** `load rd, [rs, imm4]`
- **Description:**  
  Loads a 2-byte word from memory (aligned access):  
  - `rd ← mem[rs + imm4 * 2]`

---

### `store`
- **Opcode:** `13`
- **Asm:** `store [rs, imm4], rd`
- **Description:**  
  Stores a 2-byte word into memory (aligned access):  
  - `mem[rs + imm4 * 2] ← rd`

---

### `loadb`
- **Opcode:** `14`
- **Asm:** `loadb rd, [rs, imm4]`
- **Description:**  
  Loads a single byte from memory:  
  - `rd ← mem[rs + imm4]`

---

### `storeb`
- **Opcode:** `15`
- **Asm:** `store [rs, imm4], rd`
- **Description:**  
  Stores a single byte into memory:  
  - `mem[rs + imm4] ← rd`

---

### `add`
- **Opcode:** `16`
- **Asm:** `add rd, rs/imm6`
- **Description:**  
  Adds a register value or 6-bit immediate to `rd`:  
  - `rd ← rd + rsval`

---

### `sub`
- **Opcode:** `17`
- **Asm:** `sub rd, rs/imm6`
- **Description:**  
  Subtracts a register value or 6-bit immediate from `rd`:  
  - `rd ← rd - rsval`

---

### `xor`
- **Opcode:** `20`
- **Asm:** `xor rd, rs/imm6`
- **Description:**  
  Bitwise XOR:  
  - `rd ← rd XOR rsval`

---

### `and`
- **Opcode:** `21`
- **Asm:** `and rd, rs/imm6`
- **Description:**  
  Bitwise AND:  
  - `rd ← rd AND rsval`

---

### `or`
- **Opcode:** `22`
- **Asm:** `or rd, rs/imm6`
- **Description:**  
  Bitwise OR:  
  - `rd ← rd OR rsval`

---

### `shl`
- **Opcode:** `23`
- **Asm:** `shl rd, rs/imm6`
- **Description:**  
  Logical shift left:  
  - `rd ← rd << val`

---

### `shr`
- **Opcode:** `24`
- **Asm:** `shr rd, rs/imm6`
- **Description:**  
  Logical shift right:  
  - `rd ← rd >> rsval`

---

### `asr`
- **Opcode:** `25`
- **Asm:** `asr rd, rs/imm6`
- **Description:**  
  Arithmetic shift right (signed, two’s complement):  
  - `rd ← rd >> rsval`

---

## 🔍 Conditional Instructions

These instructions set a **skip flag (S)**. If the condition evaluates to false, the next instruction is skipped (treated as a `nop`). Only **one** instruction is skipped and it still consumes one clock cycle.

---

### `if.eq`
- **Opcode:** `26`
- **Asm:** `if.eq rd, rs/imm6`
- **Description:**  
  Check if `rd` equals `rsval`:  
  - `S ← !(rd == rsval)`

---

### `if.ne`
- **Opcode:** `27`
- **Asm:** `if.ne rd, rs/imm6`
- **Description:**  
  Check if `rd` is not equal to `rsval`:  
  - `S ← !(rd != rsval)`

---

### `if.lt`
- **Opcode:** `28`
- **Asm:** `if.lt rd, rs/imm6`
- **Description:**  
  Check if `rd` is less than `rsval`:  
  - `S ← !(rd < rsval)`

---

### `if.ge`
- **Opcode:** `29`
- **Asm:** `if.ge rd, rs/imm6`
- **Description:**  
  Check if `rd` is greater than or equal to `rsval`:  
  - `S ← !(rd >= rsval)`

---

## Notes on Skipping Behavior

- If a condition is **false**, exactly one regular instruction is skipped.
- The skipped instruction still takes one clock cycle and is treated as a `nop`.

---

