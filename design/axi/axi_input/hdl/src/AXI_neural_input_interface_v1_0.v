
`timescale 1 ns / 1 ps

	module AXI_neural_input_interface_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface axi_input
		parameter integer C_axi_input_DATA_WIDTH	= 32,
		parameter integer C_axi_input_ADDR_WIDTH	= 8
	)
	(
		// Users to add ports here
        output wire [31:0] W1_00,
        output wire [31:0] W1_01,
        output wire [31:0] W1_10,
        output wire [31:0] W1_11,
        output wire [31:0] W1_20,
        output wire [31:0] W1_21,
        output wire [31:0] W1_30,
        output wire [31:0] W1_31,
        output wire [31:0] W1_40,
        output wire [31:0] W1_41,
        output wire [31:0] W2_00,
        output wire [31:0] W2_01,
        output wire [31:0] W2_02,
        output wire [31:0] W2_03,
        output wire [31:0] W2_04,
        output wire [31:0] W2_10,
        output wire [31:0] W2_11,
        output wire [31:0] W2_12,
        output wire [31:0] W2_13,
        output wire [31:0] W2_14,
        output wire [31:0] W2_20,
        output wire [31:0] W2_21,
        output wire [31:0] W2_22,
        output wire [31:0] W2_23,
        output wire [31:0] W2_24,
        output wire [31:0] W2_30,
        output wire [31:0] W2_31,
        output wire [31:0] W2_32,
        output wire [31:0] W2_33,
        output wire [31:0] W2_34,
        output wire [31:0] W2_40,
        output wire [31:0] W2_41,
        output wire [31:0] W2_42,
        output wire [31:0] W2_43,
        output wire [31:0] W2_44,
        output wire [31:0] W3_00,
        output wire [31:0] W3_01,
        output wire [31:0] W3_02,
        output wire [31:0] W3_03,
        output wire [31:0] W3_04,
        output wire [31:0] b1_00,
        output wire [31:0] b1_10,
        output wire [31:0] b1_20,
        output wire [31:0] b1_30,
        output wire [31:0] b1_40,
        output wire [31:0] b2_00,
        output wire [31:0] b2_10,
        output wire [31:0] b2_20,
        output wire [31:0] b2_30,
        output wire [31:0] b2_40,
        output wire [31:0] b3_00,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface axi_input
		input wire  axi_input_aclk,
		input wire  axi_input_aresetn,
		input wire [C_axi_input_ADDR_WIDTH-1 : 0] axi_input_awaddr,
		input wire [2 : 0] axi_input_awprot,
		input wire  axi_input_awvalid,
		output wire  axi_input_awready,
		input wire [C_axi_input_DATA_WIDTH-1 : 0] axi_input_wdata,
		input wire [(C_axi_input_DATA_WIDTH/8)-1 : 0] axi_input_wstrb,
		input wire  axi_input_wvalid,
		output wire  axi_input_wready,
		output wire [1 : 0] axi_input_bresp,
		output wire  axi_input_bvalid,
		input wire  axi_input_bready,
		input wire [C_axi_input_ADDR_WIDTH-1 : 0] axi_input_araddr,
		input wire [2 : 0] axi_input_arprot,
		input wire  axi_input_arvalid,
		output wire  axi_input_arready,
		output wire [C_axi_input_DATA_WIDTH-1 : 0] axi_input_rdata,
		output wire [1 : 0] axi_input_rresp,
		output wire  axi_input_rvalid,
		input wire  axi_input_rready
	);
// Instantiation of Axi Bus Interface axi_input
	AXI_neural_input_interface_v1_0_axi_input # ( 
		.C_S_AXI_DATA_WIDTH(C_axi_input_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_axi_input_ADDR_WIDTH)
	) AXI_neural_input_interface_v1_0_axi_input_inst (
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
		.S_AXI_ACLK(axi_input_aclk),
		.S_AXI_ARESETN(axi_input_aresetn),
		.S_AXI_AWADDR(axi_input_awaddr),
		.S_AXI_AWPROT(axi_input_awprot),
		.S_AXI_AWVALID(axi_input_awvalid),
		.S_AXI_AWREADY(axi_input_awready),
		.S_AXI_WDATA(axi_input_wdata),
		.S_AXI_WSTRB(axi_input_wstrb),
		.S_AXI_WVALID(axi_input_wvalid),
		.S_AXI_WREADY(axi_input_wready),
		.S_AXI_BRESP(axi_input_bresp),
		.S_AXI_BVALID(axi_input_bvalid),
		.S_AXI_BREADY(axi_input_bready),
		.S_AXI_ARADDR(axi_input_araddr),
		.S_AXI_ARPROT(axi_input_arprot),
		.S_AXI_ARVALID(axi_input_arvalid),
		.S_AXI_ARREADY(axi_input_arready),
		.S_AXI_RDATA(axi_input_rdata),
		.S_AXI_RRESP(axi_input_rresp),
		.S_AXI_RVALID(axi_input_rvalid),
		.S_AXI_RREADY(axi_input_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
