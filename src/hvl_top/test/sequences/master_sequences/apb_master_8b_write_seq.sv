`ifndef APB_MASTER_8B_WRITE_SEQ_INCLUDE_
`define APB_MASTER_8B_WRITE_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: apb_master_8b_write_seq
// Extends the apb_master_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class apb_master_8b_write_seq extends apb_master_base_seq;
  `uvm_object_utils(apb_master_8b_write_seq)
  
  //Variable: address
  //Used to store the address to pass to the write and read sequence 
  rand bit [ADDRESS_WIDTH-1:0]address_seq;
  
  //Variable: cont_write_read
  //Used to count the writes and reads 
  rand bit cont_write_read_seq;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="apb_master_8b_write_seq");
  extern task body();
  
endclass : apb_master_8b_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - apb_master_8b_write_seq
//--------------------------------------------------------------------------------------------
function apb_master_8b_write_seq::new(string name="apb_master_8b_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task: body
//  Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task apb_master_8b_write_seq::body();
  super.body();
  req=apb_master_tx::type_id::create("req");
  req.apb_master_agent_cfg_h = p_sequencer.apb_master_agent_cfg_h;
  start_item(req);
  if(!req.randomize() with {pselx == SLAVE_0;
                            paddr == address_seq;
                            transfer_size == BIT_8;
                            cont_write_read == cont_write_read_seq;
                            pwrite == WRITE;}) begin
    `uvm_fatal("APB","Rand failed");
  end
  req.paddr = address_seq;
  req.print();
  finish_item(req);
 
endtask : body

`endif

