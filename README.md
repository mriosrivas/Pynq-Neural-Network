# Pynq-Neural-Network
Complete Implementation of a Integer Neural Network using SystemVerilog targeted to the Pynq-Z1 board.

The following implementation was tested using Vivado 2021.2, you can synthesize it by running the following TCL fies in the Vivado command terminal in the following order:

```bash
source neural_network_generation.tclin
source axi_input_generation.tcl
source axi_output_generation.tcl
source axi_controller_generation.tcl
source zynq_neural_network_generation.tcl
```
