`ifndef APB_TEST_PKG_INCLUDED_
`define APB_TEST_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: apb base_test
//  Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package apb_test_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import apb_global_pkg::*;
  import apb_master_pkg::*;
  import apb_slave_pkg::*;
  import apb_env_pkg::*;
  import apb_master_seq_pkg::*;
  import apb_slave_seq_pkg::*;
  import apb_virtual_seq_pkg::*;
  
  //-------------------------------------------------------
  // Including the base_test files
  //-------------------------------------------------------
  `include "apb_base_test.sv"
  `include "apb_vd_vws_test.sv"
  `include "apb_8b_write_test.sv"
  `include "apb_8b_write_read_test.sv"
  `include "apb_16b_write_test.sv"
  `include "apb_24b_write_test.sv"
  `include "apb_8b_read_test.sv"
  `include "apb_32b_write_test.sv"
  `include "apb_32b_write_multiple_slave_test.sv"

endpackage : apb_test_pkg

`endif

