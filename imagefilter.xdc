## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# txoutleds
set_property PACKAGE_PIN U16 [get_ports {txoutled[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[0]}]
set_property PACKAGE_PIN E19 [get_ports {txoutled[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[1]}]
set_property PACKAGE_PIN U19 [get_ports {txoutled[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[2]}]
set_property PACKAGE_PIN V19 [get_ports {txoutled[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[3]}]
set_property PACKAGE_PIN W18 [get_ports {txoutled[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[4]}]
set_property PACKAGE_PIN U15 [get_ports {txoutled[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[5]}]
set_property PACKAGE_PIN U14 [get_ports {txoutled[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[6]}]
set_property PACKAGE_PIN V14 [get_ports {txoutled[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[7]}]

#USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports data]						
set_property IOSTANDARD LVCMOS33 [get_ports data]
set_property PACKAGE_PIN A18 [get_ports outdata]						
set_property IOSTANDARD LVCMOS33 [get_ports outdata]

#set_property PACKAGE_PIN V13 [get_ports {txoutled[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[0]}]
#set_property PACKAGE_PIN V3 [get_ports {txoutled[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[1]}]
#set_property PACKAGE_PIN W3 [get_ports {txoutled[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[2]}]
#set_property PACKAGE_PIN U3 [get_ports {txoutled[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[3]}]
#set_property PACKAGE_PIN P3 [get_ports {txoutled[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[4]}]
#set_property PACKAGE_PIN N3 [get_ports {txoutled[5]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[5]}]
#set_property PACKAGE_PIN P1 [get_ports {txoutled[6]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {txoutled[6]}]
set_property PACKAGE_PIN L1 [get_ports {memfull}]					
set_property IOSTANDARD LVCMOS33 [get_ports {memfull}]


set_property PACKAGE_PIN V17 [get_ports {sw}]                    
set_property IOSTANDARD LVCMOS33 [get_ports {sw}]


#Buttons
set_property PACKAGE_PIN U18 [get_ports btnreset]						
set_property IOSTANDARD LVCMOS33 [get_ports btnreset]
set_property PACKAGE_PIN T18 [get_ports btnstart]						
set_property IOSTANDARD LVCMOS33 [get_ports btnstart]

