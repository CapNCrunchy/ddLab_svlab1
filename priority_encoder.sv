module priority_encoder (
  input  logic [7:0] req,
  output logic [2:0] enc,
  output logic       valid
);

always_comb begin
  valid = 1'b1;
  if(req[7]) enc = 3'b111;
    else if(req[6]) enc = 3'b110;
    else if(req[5]) enc = 3'b101;
    else if(req[4]) enc = 3'b100;
    else if(req[3]) enc = 3'b011;
    else if(req[2]) enc = 3'b010;
    else if(req[1]) enc = 3'b001;
    else if(req[0]) enc = 3'b000;
    else begin
      enc = 3'b000;
      valid = 1'b0;
    end
  
end

endmodule
