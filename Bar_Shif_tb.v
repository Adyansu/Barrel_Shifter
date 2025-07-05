module barrel_shifter_8bit_tb;
    reg [7:0] in;
    reg [2:0] ctrl;
    wire [7:0] out; 
  
    barrel_shifter_8bit BS(.in(in), .ctrl(ctrl), .out(out));
  
initial 
    begin
        $display($time, " << Starting the Simulation >>");
        in = 8'd0;  ctrl = 3'd0;      // no shift
        #10 in = 8'd128; ctrl = 3'd4; // shift 4 bits
        #10 in = 8'd128; ctrl = 3'd2; // shift 2 bits
        #10 in = 8'd128; ctrl = 3'd1; // shift by 1 bit
        #10 in  =8'd255; ctrl = 3'd7; // shift by 7 bits
    end
initial 
    $monitor("Input = %d, Control = %d, Output = %d", in, ctrl, out);
endmodule
