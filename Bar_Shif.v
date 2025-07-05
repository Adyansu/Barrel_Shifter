// 8-bit Barrel Shifter (Supports Logical Left, Logical Right, Arithmetic Right, and Rotate Right)
// Control Encoding:
// ctrl[2:0]: amount to shift (0 to 7)
// mode[1:0]:
//   00 = logical left shift
//   01 = logical right shift
//   10 = arithmetic right shift
//   11 = rotate right

module barrel_shifter_all (
    input  [7:0] in,
    input  [2:0] ctrl,
    input  [1:0] mode,
    output [7:0] out
);
    wire [7:0] stage1, stage2, stage3;
    wire [7:0] s;

    // Stage 1: Shift by 4 if ctrl[2] is set
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : SHIFT4
            wire in0 = in[i];
            wire in1;
            assign in1 = (mode == 2'b00) ? ((i+4 < 8) ? in[i+4] : 1'b0) :
                         (mode == 2'b01) ? ((i >= 4) ? in[i-4] : 1'b0) :
                         (mode == 2'b10) ? ((i >= 4) ? in[i-4] : in[7]) :
                         (mode == 2'b11) ? in[(i-4+8)%8] : 1'b0;
            assign stage1[i] = ctrl[2] ? in1 : in0;
        end
    endgenerate

    // Stage 2: Shift by 2 if ctrl[1] is set
    generate
        for (i = 0; i < 8; i = i + 1) begin : SHIFT2
            wire in0 = stage1[i];
            wire in1;
            assign in1 = (mode == 2'b00) ? ((i+2 < 8) ? stage1[i+2] : 1'b0) :
                         (mode == 2'b01) ? ((i >= 2) ? stage1[i-2] : 1'b0) :
                         (mode == 2'b10) ? ((i >= 2) ? stage1[i-2] : in[7]) :
                         (mode == 2'b11) ? stage1[(i-2+8)%8] : 1'b0;
            assign stage2[i] = ctrl[1] ? in1 : in0;
        end
    endgenerate

    // Stage 3: Shift by 1 if ctrl[0] is set
    generate
        for (i = 0; i < 8; i = i + 1) begin : SHIFT1
            wire in0 = stage2[i];
            wire in1;
            assign in1 = (mode == 2'b00) ? ((i+1 < 8) ? stage2[i+1] : 1'b0) :
                         (mode == 2'b01) ? ((i >= 1) ? stage2[i-1] : 1'b0) :
                         (mode == 2'b10) ? ((i >= 1) ? stage2[i-1] : in[7]) :
                         (mode == 2'b11) ? stage2[(i-1+8)%8] : 1'b0;
            assign stage3[i] = ctrl[0] ? in1 : in0;
        end
    endgenerate

    assign out = stage3;

endmodule


 
