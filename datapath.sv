module datapath #(
    parameter WIDTH = 16
)(
    input  logic               clk,
    input  logic               rst,
    input  logic               x_sel,
    input  logic               x_en,
    input  logic               y_sel,
    input  logic               y_en,
    input  logic [WIDTH-1:0]   x,
    input  logic [WIDTH-1:0]   y,
    input  logic               output_en,
    output logic [WIDTH-1:0]   out_data,  
    output logic               x_lt_y,
    output logic               x_ne_y
);

logic [WIDTH-1:0] sub0_out, regX_in, sub1_out, regY_in, regX_out, regY_out;
    
mux2x1 mux0(x_sel, x, sub0_out, regX_in);
mux2x1 mux1(y_sel, y, sub1_out, regY_in);

regg regX(clk, rst, x_en, regX_in, regX_out);
regg regY(clk, rst, y_en, regY_in, regY_out);

comparator comp(regX_out, regY_out, x_lt_y, x_ne_y);

subtractor sub0(regX_out, regY_out, sub0_out);
subtractor sub1(regY_out, regX_out, sub1_out);

regg regOut(clk, rst, output_en, regX_out, out_data);

endmodule
