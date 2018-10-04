module counter_tb; 
reg clock, reset, entrada; 
wire [7:0] saida; 
  
Morse Morse1 ( 
.clock    (clock), 
.reset  (reset), 
.entrada (entrada), 
.saida  (saida) 
); 
  
initial begin
clock = 0; 
reset = 1; 
entrada = 0;

// E
@(posedge clock)
entrada = 0;
reset = 0; 
entrada = 1;
@(posedge clock) 
entrada = 1;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// A
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// I
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// NP
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 1;

// M
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// A
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// N
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// I
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// N
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// H
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 1;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;

// O
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;
@(posedge clock) 
entrada = 0;

// NC
@(posedge clock) 
entrada = 1;
@(posedge clock) 
entrada = 0;


end 

always  
    #5  clock =  ! clock; 
  
endmodule 
  

 
  
