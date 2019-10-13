/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include <sleep.h>
#include <xil_io.h>

int main()
{
    init_platform();

    u8 setpoint;

    //Uncommented the following for dynamic adjustment of setpoint (untested!)

//    int nitems;
//    while(1){

    	// Read input and check return value

//    	printf("Insert new Set Point");
//    	SCAN: nitems = scanf("%hhu", &setpoint);
//		if (nitems == EOF){
//			perror("EOF/Failure: ");
//			break;
//		} else if (nitems == 0) {
//			perror("No match, probably wrong input: ");
//			goto SCAN;
//		}
//
//		// Check if input is in range
//
//		if (setpoint > 127 || setpoint < 0){
//			// Setpoint not in range
//			perror("Setpoint not in range.");
//			break;
//		}

    	setpoint = 0x7F;

		// Write data to bus, and check register value
		Xil_Out8(0x40000010, setpoint);

		//Read data from register
		u8 reg_value = Xil_In8(0x40000010);

		//Compare read and write values
		if (reg_value != setpoint){
		 // Written value is not equal to stored value
			printf("Value in register %d is not equal to setpoint %d", reg_value, setpoint);
//			break;
		 }

		 // Wait while motor gets into position
		 sleep(7);

		 // Try some more setpoints here. Add more if needed.
		 setpoint = 0x2B;
		 Xil_Out8(0x40000010, setpoint);
		 sleep(7);
		 setpoint = 8;
		 Xil_Out8(0x40000010, setpoint);
		 sleep(7);
		 Xil_Out8(0x40000010, 0x10);
		 sleep(2);
		 Xil_Out8(0x40000010, 6);
		 sleep(2);
		 Xil_Out8(0x40000010, 0x19);
		 sleep(2);
		 Xil_Out8(0x40000010, 9);
		 sleep(2);
		 Xil_Out8(0x40000010, 5);
		 sleep(2);
		 Xil_Out8(0x40000010, 0);
//     }

    cleanup_platform();
    return 0;
}




