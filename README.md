# Coke Vending Machine (Verilog)

## Project Overview
This project implements a **Coke Vending Machine** using Verilog. The vending machine accepts coins, maintains credit, checks for product selection, and dispenses the product if the required amount is met.

## Features
- Accepts **1 cent**, **5 cents**, and **10 cents** as input coins.
- Tracks and updates the current credit balance.
- Allows the user to select the product.
- Dispenses the product when the required cost (**15 cents**) is met.
- Resets the credit after successful dispensing.
- Implements a **finite state machine (FSM)** to handle different stages of the vending process.

## Requirements
### Hardware/Simulation Tools
- Any **FPGA Board** that supports Verilog.
- **Xilinx Vivado**, **Quartus**, or any Verilog-supported IDE for simulation and synthesis.

### Software Prerequisites
- **Verilog HDL**
- **ModelSim** or **ISE/Vivado Simulator** for testing.

## File Structure
- **coke_vending_machine.v** → Main Verilog module for the vending machine logic.
- **testbench.v** → Testbench for simulation and verification (if created separately).

## Verilog Module Description
### **Module: coke_vending_machine**
```verilog
module coke_vending_machine (
    input wire clk,        // Clock signal
    input wire reset,      // Reset signal
    input wire [1:0] coin, // Coin input (00: No coin, 01: 1 cent, 10: 5 cents, 11: 10 cents)
    input wire select,     // Product selection button
    output reg dispense,   // Output signal to dispense the product
    output reg [6:0] credit // Output to show the current credit
);
```
### **State Machine Description**
The vending machine operates in four states:
1. **IDLE**: Waits for coin input or product selection.
2. **ACCEPT_COIN**: Updates credit based on inserted coin.
3. **CHECK_SELECTION**: Verifies if sufficient credit is available.
4. **DISPENSE**: Dispenses the product and deducts the cost.

### **Credit Calculation**
- The machine accumulates credit based on coin input.
- If the credit reaches **15 cents**, it allows product dispensing.
- After dispensing, the credit is reduced by 15 cents.

## Simulation & Testing
1. Load the **coke_vending_machine.v** file into a Verilog simulator.
2. Apply different test cases:
   - Insert **1 cent**, **5 cents**, **10 cents** and observe credit updates.
   - Check vending functionality when **15 cents** is reached.
   - Test reset conditions.
3. Verify the output signals (**credit & dispense**) using waveform analysis.

## Future Improvements
- Add a display interface to show current credit balance.
- Extend functionality to support multiple products.
- Implement coin return mechanism.



