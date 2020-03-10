# FSMDesignTestRTL
SystemVerilog Design For Testability (DFT) as applied to Finate State Machines (FSMs).
Aims to show how DFT structures can be built into an integrated circuit (IC) to assist testing via a scan path.
Fault detection and analysis can be perofrmed. Stuck-at-0/1 implemented.

The main problem in testing is the access (or lack of it) to the internal nodes of the circuit;
the main point of DFT is to provide means for improving this access.
The pin allocation is designed to work with CycloneV FPGA.
If using another FPGA/CPLD please note the changes needed by the pin sheet documentation.
The code can be synthesised, and the board programmed with a tool as Quartus.

Please check the PDF documentation for full design spec.
