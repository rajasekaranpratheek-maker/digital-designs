
# Digital Designs

A collection of digital design projects developed using Verilog/VHDL,
with a focus on FPGA-based digital systems and hardware interfaces.


## Projects

### 1. HUB75 LED Matrix Text Controller

A Verilog-based controller for driving a HUB75 LED matrix panel and
displaying text using a font ROM and text memory.

#### Current modules

- HUB75 driver FSM
- Text controller
- Font ROM
- Text RAM
- Top-level module

#### Architecture

```text
Text Input
    |
    v
+---------------+
|  Text RAM     |
+---------------+
        |
        v
+---------------+
|  Text          |
|  Controller    |
+---------------+
        |
        v
+---------------+
|   Font ROM    |
+---------------+
        |
        v
+---------------+
| HUB75 Driver  |
|     FSM       |
+---------------+
        |
        v
   HUB75 Panel
