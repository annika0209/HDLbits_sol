module top_module(
    input clk,
    input load,
    input ena,
    input [63:0] data,
    input areset,
    input [1:0] amount,
    output reg [63:0] q
    );

    always @(posedge clk) begin
        if (load) begin
            // 동기식 로드
            q <= data;
        end
        else if (ena) begin
            case (amount) //arithmetic shift mode
                2'b00: q <= {q[62:0], 1'h0};   //shift left by 1 bit 
                2'b01: q <= {q[55:0], 8'h0};   //shift left by 8 bits (1 byte)
                2'b10: q <= {q[63], q[63:1]};   //shift right by 1 bit
                2'b11: q <= {{8{q[63]}}, q[63:8]};   //shift right by 8 bits (1 byte)
                default: q <= q;
            endcase
        end
    end

endmodule
//
//
