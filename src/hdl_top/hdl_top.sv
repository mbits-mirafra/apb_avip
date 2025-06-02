`ifndef HDL_TOP_INCLUDED
`define HDL_TOP_INCLUDED

//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and slave agent bfm.
//--------------------------------------------------------------------------------------------
module hdl_top;

  //-------------------------------------------------------
  // Importing uvm package and Including uvm macros file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  //-------------------------------------------------------
  // Importing apb global package
  //-------------------------------------------------------
  import apb_global_pkg::*;

  initial begin
    `uvm_info("HDL_TOP","HDL_TOP",UVM_LOW);
  end

  //Variable : pclk
  //Declaration of system clock
  bit pclk;

  //Variable : preset_n
  //Declaration of system reset
  bit preset_n;

  //-------------------------------------------------------
  // Generation of system clock at frequency rate of 20ns
  //-------------------------------------------------------
  initial begin
    pclk = 1'b0;
    forever #10 pclk =!pclk;
  end

  //-------------------------------------------------------
  // Generation of system preset_n
  //  system reset can be asserted asynchronously,
  //  but system reset de-assertion is synchronous.
  //-------------------------------------------------------
  initial begin
    preset_n = 1'b1;
    #15 preset_n = 1'b0;

    repeat(1) begin
      @(posedge pclk);
    end
    preset_n = 1'b1;
  end

  initial begin
    $dumpfile("waveform.vcd");      // name of the VCD file
    $dumpvars(0,hdl_top);    // dump variables from the testbench top
  end
  //-------------------------------------------------------
  // APB Interface Instantiation
  //-------------------------------------------------------
  apb_if intf_s[NO_OF_SLAVES](pclk,preset_n);
  apb_if intf(pclk,preset_n);

  //-------------------------------------------------------
  // APB Master BFM Agent Instantiation
  //-------------------------------------------------------
  apb_master_agent_bfm apb_master_agent_bfm_h(intf); 
  
  always_comb begin
    case(intf.pselx)
      2'b01: begin
               intf_s[0].pselx   = intf.pselx[0];
               intf_s[0].penable = intf.penable;
               intf_s[0].paddr   = intf.paddr;
               intf_s[0].pwrite  = intf.pwrite;
               intf_s[0].pstrb   = intf.pstrb;
               intf_s[0].pwdata  = intf.pwdata;
               intf_s[0].pprot   = intf.pprot;
               intf.pready  = intf_s[0].pready;
               intf.prdata  = intf_s[0].prdata;
               intf.pslverr = intf_s[0].pslverr;
             end
     //-------------------------------------------------------------------------------------------
     //whenever you require multiple slaves like 2 slave then uncomment below case
     //So if you uncomment then case 1 and case 2 will select particular slave
     //As of now using single slave and connected using case 1
     //Change NO_OF_SLAVES 1 to 2 inside the global pkg then you will get 2 slave interface handle
     //-------------------------------------------------------------------------------------------
     // 2'b10: begin
     //          intf_s[1].pselx = intf.pselx[1];
     //          intf_s[1].penable = intf.penable;
     //          intf_s[1].paddr   = intf.paddr;
     //          intf_s[1].pwrite  = intf.pwrite;
     //          intf_s[1].pstrb   = intf.pstrb;
     //          intf_s[1].pwdata  = intf.pwdata;
     //          intf_s[1].pprot   = intf.pprot;
     //          intf.pready  = intf_s[1].pready;
     //          intf.prdata  = intf_s[1].prdata;
     //          intf.pslverr = intf_s[1].pslverr;
     //        end
      default : begin
                  intf_s[0].pselx   = 'b0;
                  intf_s[0].penable = 'b0;
                  //intf_s[1].pselx   = 'b0;
                  //intf_s[1].penable = 'b0;
                end
    endcase
  end

  //-------------------------------------------------------
  // APB Slave BFM Agent Instantiation
  //-------------------------------------------------------
  genvar i;
  generate
    for (i=0; i < NO_OF_SLAVES; i++) begin : apb_slave_agent_bfm
      apb_slave_agent_bfm #(.SLAVE_ID(i)) apb_slave_agent_bfm_h(intf_s[i]);
      defparam apb_slave_agent_bfm[i].apb_slave_agent_bfm_h.SLAVE_ID = i;
    end
  endgenerate

endmodule : hdl_top

`endif

