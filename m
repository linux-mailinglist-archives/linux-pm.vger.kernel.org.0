Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3B3267DA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBZUIC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhBZUHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:07:22 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC26C0617A7;
        Fri, 26 Feb 2021 12:04:58 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 01EA11FAC6;
        Fri, 26 Feb 2021 21:04:54 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/41] arm64: dts: qcom: sdm630: Add MDSS nodes
Date:   Fri, 26 Feb 2021 21:03:35 +0100
Message-Id: <20210226200414.167762-6-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add MDSS node along with its children to enable display
functionality.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 198 ++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index c46b7327afbe..e0c6099d0810 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -941,14 +941,208 @@ mmcc: clock-controller@c8c0000 {
 					<&sleep_clk>,
 					<&gcc GCC_MMSS_GPLL0_CLK>,
 					<&gcc GCC_MMSS_GPLL0_DIV_CLK>,
-					<0>,
-					<0>,
+					<&dsi0_phy 1>,
+					<&dsi0_phy 0>,
 					<0>,
 					<0>,
 					<0>,
 					<0>;
 		};
 
+		dsi_opp_table: dsi-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-131250000 {
+				opp-hz = /bits/ 64 <131250000>;
+				required-opps = <&rpmpd_opp_svs>;
+			};
+
+			opp-210000000 {
+				opp-hz = /bits/ 64 <210000000>;
+				required-opps = <&rpmpd_opp_svs_plus>;
+			};
+
+			opp-262500000 {
+				opp-hz = /bits/ 64 <262500000>;
+				required-opps = <&rpmpd_opp_nom>;
+			};
+		};
+
+		mdss: mdss@c900000 {
+			compatible = "qcom,mdss";
+			reg = <0x0c900000 0x1000>,
+			      <0x0c9b0000 0x1040>;
+			reg-names = "mdss_phys", "vbif_phys";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_AXI_CLK>,
+				 <&mmcc MDSS_VSYNC_CLK>,
+				 <&mmcc MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "bus",
+				      "vsync",
+				      "core";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			mdp: mdp@c901000 {
+				compatible = "qcom,mdp5";
+				reg = <0x0c901000 0x89000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+				assigned-clocks = <&mmcc MDSS_MDP_CLK>,
+						  <&mmcc MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <300000000>,
+						       <19200000>;
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "vsync";
+
+				interconnects = <&mnoc 2 &bimc 5>,
+						<&mnoc 3 &bimc 5>,
+						<&gnoc 0 &mnoc 17>;
+				interconnect-names = "mdp0-mem",
+						     "mdp1-mem",
+						     "rotator-mem";
+				iommus = <&mmss_smmu 0>;
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmpd SDM660_VDDCX>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: mdp-opp {
+					compatible = "operating-points-v2";
+
+					opp-150000000 {
+						opp-hz = /bits/ 64 <150000000>;
+						opp-peak-kBps = <320000 320000 76800>;
+						required-opps = <&rpmpd_opp_low_svs>;
+					};
+					opp-275000000 {
+						opp-hz = /bits/ 64 <275000000>;
+						opp-peak-kBps = <6400000 6400000 160000>;
+						required-opps = <&rpmpd_opp_svs>;
+					};
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						opp-peak-kBps = <6400000 6400000 190000>;
+						required-opps = <&rpmpd_opp_svs_plus>;
+					};
+					opp-330000000 {
+						opp-hz = /bits/ 64 <330000000>;
+						opp-peak-kBps = <6400000 6400000 240000>;
+						required-opps = <&rpmpd_opp_nom>;
+					};
+					opp-412500000 {
+						opp-hz = /bits/ 64 <412500000>;
+						opp-peak-kBps = <6400000 6400000 320000>;
+						required-opps = <&rpmpd_opp_turbo>;
+					};
+				};
+			};
+
+			dsi0: dsi@c994000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0x0c994000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmpd SDM660_VDDCX>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+
+				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
+						  <&mmcc PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&dsi0_phy 0>,
+							 <&dsi0_phy 1>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_BYTE0_INTF_CLK>,
+					 <&mmcc MNOC_AHB_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MISC_AHB_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>;
+				clock-names = "mdp_core",
+					      "byte",
+					      "byte_intf",
+					      "mnoc",
+					      "iface",
+					      "bus",
+					      "core_mmss",
+					      "pixel",
+					      "core";
+
+				phys = <&dsi0_phy>;
+				phy-names = "dsi";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi0_phy: dsi-phy@c994400 {
+				compatible = "qcom,dsi-phy-14nm-660";
+				reg = <0x0c994400 0x100>,
+				      <0x0c994500 0x300>,
+				      <0x0c994800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&xo_board>;
+				clock-names = "iface", "ref";
+			};
+		};
+
 		blsp1_dma: dma-controller@c144000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0c144000 0x1f000>;
-- 
2.30.1

