module coke_vending_machine (
    input wire clk,        // Clock signal
    input wire reset,      // Reset signal
    input wire [1:0] coin, // Coin input (00: No coin, 01: 1 cent, 10: 5 cents, 11: 10 cents)
    input wire select,     // Product selection button
    output reg dispense,   // Output signal to dispense the product
    output reg [6:0] credit // Output to show the current credit
);

    // Define states for the state machine
    typedef enum reg [1:0] {
        IDLE      = 2'b00,
        ACCEPT_COIN = 2'b01,
        CHECK_SELECTION = 2'b10,
        DISPENSE = 2'b11
    } state_t;

    state_t state, next_state;

    // Parameters for the vending machine
    parameter COST = 15; // Cost of the product in cents (e.g., 15 cents)

    // Register to store the credit amount
    reg [6:0] credit_reg;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (coin != 2'b00)
                    next_state = ACCEPT_COIN;
                else if (select)
                    next_state = CHECK_SELECTION;
                else
                    next_state = IDLE;
            end
            ACCEPT_COIN: begin
                if (coin == 2'b01)       // 1 cent
                    credit_reg = credit_reg + 1;
                else if (coin == 2'b10)  // 5 cents
                    credit_reg = credit_reg + 5;
                else if (coin == 2'b11)  // 10 cents
                    credit_reg = credit_reg + 10;

                next_state = IDLE;
            end
            CHECK_SELECTION: begin
                if (credit_reg >= COST)
                    next_state = DISPENSE;
                else
                    next_state = IDLE;
            end
            DISPENSE: begin
                dispense = 1;           // Activate dispensing mechanism
                credit_reg = credit_reg - COST;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dispense <= 0;
            credit_reg <= 0;
        end else begin
            credit <= credit_reg;
            if (state == DISPENSE)
                dispense <= 0;     // Deactivate dispensing mechanism after dispensing
        end
    end

endmodule
