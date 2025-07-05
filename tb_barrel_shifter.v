`timescale 1ns/1ps

module tb_barrel_shifter();
    reg  [7:0] in;
    reg  [2:0] ctrl;
    reg  [1:0] mode;
    wire [7:0] out;

    // Instantiate the design
    barrel_shifter_8bit uut (
        .in(in),
        .ctrl(ctrl),
        .mode(mode),
        .out(out)
    );

    initial begin
        $dumpfile("barrel_shifter.vcd");
        $dumpvars(0, tb_barrel_shifter);

        // Test 1: Logical Left Shift by 1
        in = 8'b00011001;
        ctrl = 3'd1;
        mode = 2'b00;
        #10;

        // Test 2: Logical Right Shift by 2
        in = 8'b10011001;
        ctrl = 3'd2;
        mode = 2'b01;
        #10;

        // Test 3: Arithmetic Right Shift by 3
        in = 8'b10011001;
        ctrl = 3'd3;
        mode = 2'b10;
        #10;

        // Test 4: Rotate Right by 4
        in = 8'b10011001;
        ctrl = 3'd4;
        mode = 2'b11;
        #10;

        // Test 5: Logical Left Shift by 7
        in = 8'b11110000;
        ctrl = 3'd7;
        mode = 2'b00;
        #10;

        $finish;
    end
endmodule
