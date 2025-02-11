`ifndef APB_SLAVE_TX_INCLUDED_
`define APB_SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_tx
//  Contains the apb_transaction_items which will be randomised
//--------------------------------------------------------------------------------------------
class apb_slave_tx extends uvm_sequence_item;
  `uvm_object_utils(apb_slave_tx)
  
  //Variable: psel
  //Used to select the slave
  bit psel;
    
  //Variable: paddr
  //Address selected in apb_slave
   bit [ADDRESS_WIDTH-1:0]paddr;

  //Varibale: pwrite
  //pwrite when write is 1 and read is 0
  tx_type_e pwrite;

  //Variable: pwdata
  //Used to store the wdata
  bit [DATA_WIDTH-1:0]pwdata;

  //Variable: pslverr
  //Goes high when a transfer fails
  rand slave_error_e pslverr;

  //Variable: pready
  //Used to extend the transfer
  bit pready;

  //Variable: prdata
  //Used to store the rdata from the slave
  rand bit [DATA_WIDTH-1:0]prdata;
 
  //Variable: pprot
  //Used for different access
  rand protection_type_e pprot;

  //Variable: no_of_wait_states
  //Used to decide the number of wait states
  rand bit [2:0]no_of_wait_states;

  //Variable: choose_packet_data
  //Used for driving the prdata from this packet rather than from the Slave memory
  rand bit choose_packet_data;

  //Variable: transfer_size
  //Used to decide the transfer size of the data
  transfer_size_e transfer_size;

  //-------------------------------------------------------
  // Constraints
  //-------------------------------------------------------
  //To randomise the wait states in range of 0 to 3
  constraint wait_states_c1 {soft no_of_wait_states inside {[0:3]};}

  //To randomize the pslverr as NO_ERROR by defualt
  constraint pslverr_c2 {soft pslverr == NO_ERROR;}

  //To choose the randomised pslverr and prdata make choose_packet_data as high
  constraint choose_data_packet_c3 {soft choose_packet_data==1;} 

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_slave_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : apb_slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function apb_slave_tx::new(string name = "apb_slave_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_copy
//  Copy method is implemented using handle rhs
//
// Parameters:
//  rhs - uvm_object
//--------------------------------------------------------------------------------------------
function void apb_slave_tx::do_copy (uvm_object rhs);
  apb_slave_tx apb_slave_tx_copy_obj;

  if(!$cast(apb_slave_tx_copy_obj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  
  paddr   = apb_slave_tx_copy_obj.paddr;
  psel    = apb_slave_tx_copy_obj.psel;
  pwrite  = apb_slave_tx_copy_obj.pwrite;
  pwdata  = apb_slave_tx_copy_obj.pwdata;
  pready  = apb_slave_tx_copy_obj.pready;
  prdata  = apb_slave_tx_copy_obj.prdata;
  pslverr = apb_slave_tx_copy_obj.pslverr;
  pprot   = apb_slave_tx_copy_obj.pprot;

endfunction:do_copy

//--------------------------------------------------------------------------------------------
// Function: do_compare
//  Compare method is implemented using handle rhs
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function bit apb_slave_tx::do_compare (uvm_object rhs, uvm_comparer comparer);
  apb_slave_tx apb_slave_tx_compare_obj;

  if(!$cast(apb_slave_tx_compare_obj,rhs)) begin
    `uvm_fatal("FATAL_APB_SLAVE_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(apb_slave_tx_compare_obj, comparer) &&
  paddr   == apb_slave_tx_compare_obj.paddr &&
  psel    == apb_slave_tx_compare_obj.psel &&
  pwrite  == apb_slave_tx_compare_obj.pwrite &&
  pwdata  == apb_slave_tx_compare_obj.pwdata &&
  pready  == apb_slave_tx_compare_obj.pready &&
  prdata  == apb_slave_tx_compare_obj.prdata &&
  pslverr == apb_slave_tx_compare_obj.pslverr && 
  pprot   == apb_slave_tx_compare_obj.pprot;

endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
//  Print method can be added to display the data members values
//
// Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void apb_slave_tx::do_print(uvm_printer printer);

  printer.print_field("psel",psel,1,UVM_DEC);
  printer.print_field("paddr",paddr,$bits(paddr),UVM_HEX);
  printer.print_string("pwrite",pwrite.name());
  printer.print_field("pwdata",pwdata,$bits(pwdata),UVM_HEX);
  printer.print_field("pready",pready,1,UVM_DEC);
  printer.print_field("prdata",prdata,$bits(prdata),UVM_HEX);
  printer.print_string("pslverr",pslverr.name());
  printer.print_string("pprot",pprot.name());
  printer.print_field ("no_of_wait_states",no_of_wait_states,$bits(no_of_wait_states),UVM_DEC);
  printer.print_field ("choose_packet_data",choose_packet_data,$bits(choose_packet_data),UVM_DEC);

endfunction : do_print

`endif

