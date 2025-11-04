module gcd_fsm (
    input  logic clk,
    input logic rst,
    input logic go,
    input logic x_ne_y,
    input logic x_lt_y,
    output logic x_sel,
    output logic x_en,
    output logic y_sel,
    output logic y_en,
    output logic output_en,
    output logic done
);
  
typedef enum logic [2:0] {
    S_IDLE,       // waiting for go
    S_LOAD,       // load x and y
    S_COMPARE,    // check if x != y
    S_SUB_X,      // x = x - y
    S_SUB_Y,      // y = y - x
    S_DONE        // output result
} state_t;

state_t state, next_state;

always_ff@(posedge clk or posedge rst) begin
    if(rst) state <= S_IDLE;
    else state <= next_state;

end

always_comb begin
    x_sel     = 0;
    y_sel     = 0;
    x_en      = 0;
    y_en      = 0;
    output_en = 0;
    done      = 0;
    next_state = state;

    case(state)
        S_IDLE: begin
            if(go) next_state = S_LOAD;
        end
        S_LOAD: begin
            x_sel = 0;
            y_sel = 0;
            x_en = 1;
            y_en = 1;
            next_state = S_COMPARE;
        end
        S_COMPARE: begin
            if (!x_ne_y) begin
                output_en = 1;
                next_state = S_DONE;
            end
            else if (x_lt_y)
                next_state = S_SUB_Y;
            else
                next_state = S_SUB_X;
        end
        S_SUB_X: begin
            x_sel = 1;  // select subtractor output
            x_en  = 1;
            next_state = S_COMPARE;
        end
        S_SUB_Y: begin
            y_sel = 1;  // select subtractor output
            y_en  = 1;
            next_state = S_COMPARE;
        end
        S_DONE: begin
            done      = 1;
            if (go)
                next_state = S_IDLE;
        end
        default:begin
            next_state = S_IDLE;
        end
    endcase

end


endmodule