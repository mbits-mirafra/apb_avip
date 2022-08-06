# Accelerated VIP for APB4 Protocol

The idea of using Accelerated VIP is to push the synthesizable part of the testbench into the separate top module along with the interface and it is named as HDL TOP and the unsynthesizable part is pushed into the HVL TOP. This setup provides the ability to run the longer tests quickly. This particular testbench can be used for the simulation as well as the emulation based on mode of operation.

# Key Features  
1. It supports addresses up to 32 bit wide.
2. APB4 support for write strobe signal to enable sparse data transfer on the write data bus.  
3. Single Master - Multiple Slaves.
4. Programmable Wait state insertion. 
5. Slave supports fine grain control of response per address or per transfer.
6. Programmable character length(multiple of 8 bits).
7. Supports protected access.
8. Random PSLVERR insertion.
9. Supports sending of completely configured data.

# Architecture Diagram  
![apb_tb_architecture](https://user-images.githubusercontent.com/15922511/183239393-2f9c937c-3b62-4c86-8d6f-71a97b8f3f8d.jpg)

# Developers, Welcome
We believe in growing together and if you'd like to contribute, please do check out the contributing guide below:  
https://github.com/mbits-mirafra/apb_avip/blob/main/contribution_guidelines.md

# Installation - Get the VIP collateral from the GitHub repository

```
# Checking for git software, open the terminal type the command
git version

# Get the VIP collateral
git clone git@github.com:mbits-mirafra/apb_avip.git
```

# Running the test

### Using Mentor's Questasim simulator 

```
cd apb_avip/sim/questasim

# Compilation:  
make compile

# Simulation:
make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>

ex: make simulate test=apb_32b_write_test.sv uvm_verbosity=UVM_HIGH

# Note: You can find all the test case names in the path given below   
apb_avip/src/hvl_top/testlists/apb_regression.list

# Wavefrom:  
vsim -view <test_name>/waveform.wlf &

ex: vsim -view apb_32b_write_test/waveform.wlf &

# Regression:
make regression testlist_name=<regression_testlist_name.list>
ex: make regression testlist_name=apb_regression.list.list

# Coverage: 
 ## Individual test:
 firefox <test_name>/html_cov_report/index.html &
 ex: firefox apb_32b_write_test/html_cov_report/index.html &

 ## Regression:
 firefox merged_cov_html_report/index.html &

```

### Using Cadence's Xcelium simulator 

```
cd apb_avip/sim/cadence_sim

# Compilation:  
make compile

# Simulation:
make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>

ex: make simulate test=apb_32b_write_test uvm_verbosity=UVM_HIGH

# Note: You can find all the test case names in the path given below   
apb_avip/src/hvl_top/testlists/apb_regression.list.list

# Wavefrom:  
simvision waves.shm/ &

# Regression:
make regression testlist_name=<regression_testlist_name.list>
ex: make regression testlist_name=apb_simple_fd_regression.list

# Coverage:   
imc -load cov_work/scope/test/ &
```

## Technical Document 
https://github.com/mbits-mirafra/apb_avip/blob/main/doc/apb_avip_architectural_document.pdf    

## User Guide  
https://github.com/mbits-mirafra/apb_avip/blob/main/doc/apb_avip_user_guide.pdf 

## Contact Mirafra Team  
You can reach out to us over mbits@mirafra.com

For more information regarding Mirafra Technologies please do checkout our officail website:  
https://mirafra.com/
