`ifndef APB_SLAVE_8B_WRITE_SEQ_INCLUDED_
`define APB_SLAVE_8B_WRITE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_slave_8b_write_seq
//  Extends the apb_slave_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class apb_slave_8b_write_seq extends apb_slave_base_seq;
  `uvm_object_utils(apb_slave_8b_write_seq)

  rand bit choose_packet_data_seq;
  constraint choose_packet_data_seq_c {soft choose_packet_data_seq==1;} 
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name="apb_slave_8b_write_seq");
  extern task body();
endclass : apb_slave_8b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_slave_vd_vws
//--------------------------------------------------------------------------------------------
function apb_slave_8b_write_seq::new(string name="apb_slave_8b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : Body
//  Creates the req of type slave transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task apb_slave_8b_write_seq::body();
  req=apb_slave_tx::type_id::create("req");
  start_item(req);
  
  if(!req.randomize() with {req.choose_packet_data == choose_packet_data_seq;}) begin
    `uvm_fatal("APB","Rand failed");
  end
  finish_item(req);
endtask : body

`endif

