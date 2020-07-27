# Image filter on FPGAs

This project implements certain image filters on FPGAs, which can be used as standalone filters. The demo filters in include detail capturing and blurring of images with a given choice of modes, and this can be customized to other filters as well.

## Running instructions

1. First synthesize the code and upload the bitstream file to an FPGA.

2. Then rename the file to in.pgm in the same directory

3. Compile and run filegen.cpp (for converting the image into a machine-readable format)

4. Send the file out.txt to the FPGA board using gtkterm.

5. Save the file received from the FPGA to rawout, then run convertoutput.sh.

6. Compile and run fileread.cpp and the output would be in out.pgm, which is in a viewable format.
