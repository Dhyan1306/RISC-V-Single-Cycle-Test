
module if_stage (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,
    input  logic        and_out,
    input  logic [31:0] pc_signed_offset,
    output logic [31:0] address,
    output logic [31:0] pc_new
);

    logic [31:0] next_pc;

    // Calculate the next sequential instruction address
    assign pc_new = address + 32'd4;

    // Select between branch/jump target and sequential address
    assign next_pc = and_out ? pc_signed_offset : pc_new;

    // Program Counter with asynchronous active-high reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            address <= 32'h8000_0000;
        end
        else if (!stall) begin
            address <= next_pc;
        end
    end

endmodule
