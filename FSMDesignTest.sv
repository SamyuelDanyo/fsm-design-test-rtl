module inject_fault (output logic o, input logic i, sa0, sa1);

always_comb
  if (sa0)
    o = 1'b0;
  else if (sa1)
    o = 1'b1;
  else
    o = i;
    
endmodule

module d_ff (output logic q, qbar, input logic clk, rst, d);

always_ff @(posedge clk, negedge rst)
  if (~rst)
    begin
    q <= 1'b0;
    qbar <= 1'b1;
    end
  else
    begin
    q <= d;
    qbar <= ~d;
    end

endmodule

module scan_dff (output logic q, qbar, input logic clk, rst, d, mode, scan_in);

always_ff @(posedge clk, negedge rst)
  if (~rst)
    begin
    q <= 1'b0;
    qbar <= 1'b1;
    end
  else if (mode)
    begin
    q <= scan_in;
    qbar <= ~scan_in;
    end
  else
    begin
    q <= d;
    qbar <= ~d;
    end
    
endmodule

module next_state (output logic s_plus, t_plus, input logic s, s_bar, t, t_bar, a);

logic a_bar, e, f, g, h;

nand g0 (s_plus, e, f);
nand g1 (e, s_bar, t);
//inject_fault f0 (.o(f_prime), .i(f), .sa0(sa0), .sa1(sa1));
nand g2 (f, s, a, t_bar);

nand g3 (t_plus, g, h);
nand g4 (g, a, s_bar, t_bar);
nand g5 (h, a_bar, s_bar, t);
not g6 (a_bar, a);

endmodule

module output_comb (output logic k, l, input logic s, t, b);

always_comb
  k = (~s & t) | (~t & b);
  
always_comb
  l = (t & ~b);
  
endmodule

module output_reg (output logic n, input logic clk, s, t, c);

always_ff @(posedge clk)
  if (s)
    n <= t & c;
    
endmodule


module FSMDesignTest (output logic s, t, input logic n_clk, rst, a);

logic s_plus, t_plus, s_bar, t_bar, clk;

assign clk = ~n_clk

next_state n0 (.*);
d_ff d0 (.q(s), .qbar(s_bar), .clk(clk), .rst(rst), .d(s_plus));
d_ff d1 (.q(t), .qbar(t_bar), .clk(clk), .rst(rst), .d(t_plus));
//output_comb o0 (.*);
//output_reg o1 (.*);

endmodule

module test_FSMDesignTest;

logic s, t;
logic n_clk, rst, a;

FSMDesignTest dut (.*);

initial 
  begin
  n_clk = 0;
  #20ns;
  forever #10ns n_clk = ~n_clk;
  end
  
initial
// 	Reset		00
// 	A=0		00
// 	A=1		01
// 	A=1		10
// 	A=1		10
// 	A=0		00
// 	A=1		01
// 	A=0		11
// 	A=0		00
// 	A=1		01
// 	A=0		11
// 	A=1		00
  begin
  rst = 1;
  a = 0;
  #10ns rst = 0;
  #10ns rst = 1;
  #40ns a = 1;
  #60ns a = 0;
  #20ns a = 1;
  #20ns a = 0;
  #40ns a = 1;
  #20ns a = 0;
  #20ns a = 1;
  end
endmodule
  

    