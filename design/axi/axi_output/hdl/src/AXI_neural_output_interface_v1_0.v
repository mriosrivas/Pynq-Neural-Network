
`timescale 1 ns / 1 ps

	module AXI_neural_output_interface_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 8
	)
	(
		// Users to add ports here
		input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_00,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_01,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_10,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_11,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_20,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_21,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_30,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_31,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_40,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W1_41,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_00,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_01,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_02,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_03,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_04,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_10,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_11,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_12,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_13,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_14,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_20,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_21,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_22,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_23,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_24,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_30,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_31,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_32,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_33,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_34,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_40,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_41,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_42,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_43,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W2_44,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W3_00,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W3_01,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W3_02,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W3_03,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] W3_04,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b1_00,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b1_10,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b1_20,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b1_30,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b1_40,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b2_00,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b2_10,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b2_20,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b2_30,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b2_40,
        input [C_S00_AXI_DATA_WIDTH-1 : 0] b3_00,

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	AXI_neural_output_interface_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) AXI_neural_output_interface_v1_0_S00_AXI_inst (
	     
	    .W1_00(W1_00),
        .W1_01(W1_01),
        .W1_10(W1_10),
        .W1_11(W1_11),
        .W1_20(W1_20),
        .W1_21(W1_21),
        .W1_30(W1_30),
        .W1_31(W1_31),
        .W1_40(W1_40),
        .W1_41(W1_41),
        .W2_00(W2_00),
        .W2_01(W2_01),
        .W2_02(W2_02),
        .W2_03(W2_03),
        .W2_04(W2_04),
        .W2_10(W2_10),
        .W2_11(W2_11),
        .W2_12(W2_12),
        .W2_13(W2_13),
        .W2_14(W2_14),
        .W2_20(W2_20),
        .W2_21(W2_21),
        .W2_22(W2_22),
        .W2_23(W2_23),
        .W2_24(W2_24),
        .W2_30(W2_30),
        .W2_31(W2_31),
        .W2_32(W2_32),
        .W2_33(W2_33),
        .W2_34(W2_34),
        .W2_40(W2_40),
        .W2_41(W2_41),
        .W2_42(W2_42),
        .W2_43(W2_43),
        .W2_44(W2_44),
        .W3_00(W3_00),
        .W3_01(W3_01),
        .W3_02(W3_02),
        .W3_03(W3_03),
        .W3_04(W3_04),
        .b1_00(b1_00),
        .b1_10(b1_10),
        .b1_20(b1_20),
        .b1_30(b1_30),
        .b1_40(b1_40),
        .b2_00(b2_00),
        .b2_10(b2_10),
        .b2_20(b2_20),
        .b2_30(b2_30),
        .b2_40(b2_40),
        .b3_00(b3_00),
	     
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
