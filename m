Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455E8326839
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhBZUMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhBZUMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:12:09 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F0EC0698CD;
        Fri, 26 Feb 2021 12:09:40 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 035C61F87C;
        Fri, 26 Feb 2021 21:06:40 +0100 (CET)
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
Subject: [PATCH 28/41] arm64: dts: qcom: sdm630: Configure the camera subsystem
Date:   Fri, 26 Feb 2021 21:03:58 +0100
Message-Id: <20210226200414.167762-29-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add nodes for camss, cci and its pinctrl in order to bring up
camera functionality.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 215 +++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index c74423474884..a5a06afc2c94 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1035,6 +1035,32 @@ i2c8_sleep: i2c8-sleep {
 				bias-pull-up;
 			};
 
+			cci0_default: cci0_default {
+				pinmux {
+					pins = "gpio36","gpio37";
+					function = "cci_i2c";
+				};
+
+				pinconf {
+					pins = "gpio36","gpio37";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
+			cci1_default: cci1_default {
+				pinmux {
+					pins = "gpio38","gpio39";
+					function = "cci_i2c";
+				};
+
+				pinconf {
+					pins = "gpio38","gpio39";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
 			sdc1_state_on: sdc1-on {
 				pinconf-clk {
 					pins = "sdc1_clk";
@@ -1941,6 +1967,195 @@ pil-reloc@94c {
 			};
 		};
 
+		camss: camss@ca00000 {
+			compatible = "qcom,sdm660-camss";
+			reg = <0x0c824000 0x1000>,
+			      <0x0ca00120 0x4>,
+			      <0x0c825000 0x1000>,
+			      <0x0ca00124 0x4>,
+			      <0x0c826000 0x1000>,
+			      <0x0ca00128 0x4>,
+			      <0x0ca30000 0x100>,
+			      <0x0ca30400 0x100>,
+			      <0x0ca30800 0x100>,
+			      <0x0ca30c00 0x100>,
+			      <0x0ca31000 0x500>,
+			      <0x0ca00020 0x10>,
+			      <0x0ca10000 0x1000>,
+			      <0x0ca14000 0x1000>;
+			reg-names = "csiphy0",
+				    "csiphy0_clk_mux",
+				    "csiphy1",
+				    "csiphy1_clk_mux",
+				    "csiphy2",
+				    "csiphy2_clk_mux",
+				    "csid0",
+				    "csid1",
+				    "csid2",
+				    "csid3",
+				    "ispif",
+				    "csi_clk_mux",
+				    "vfe0",
+				    "vfe1";
+			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 314 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 315 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "csiphy0",
+					  "csiphy1",
+					  "csiphy2",
+					  "csid0",
+					  "csid1",
+					  "csid2",
+					  "csid3",
+					  "ispif",
+					  "vfe0",
+					  "vfe1";
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				<&mmcc THROTTLE_CAMSS_AXI_CLK>,
+				<&mmcc CAMSS_ISPIF_AHB_CLK>,
+				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI0_AHB_CLK>,
+				<&mmcc CAMSS_CSI0_CLK>,
+				<&mmcc CAMSS_CPHY_CSID0_CLK>,
+				<&mmcc CAMSS_CSI0PIX_CLK>,
+				<&mmcc CAMSS_CSI0RDI_CLK>,
+				<&mmcc CAMSS_CSI1_AHB_CLK>,
+				<&mmcc CAMSS_CSI1_CLK>,
+				<&mmcc CAMSS_CPHY_CSID1_CLK>,
+				<&mmcc CAMSS_CSI1PIX_CLK>,
+				<&mmcc CAMSS_CSI1RDI_CLK>,
+				<&mmcc CAMSS_CSI2_AHB_CLK>,
+				<&mmcc CAMSS_CSI2_CLK>,
+				<&mmcc CAMSS_CPHY_CSID2_CLK>,
+				<&mmcc CAMSS_CSI2PIX_CLK>,
+				<&mmcc CAMSS_CSI2RDI_CLK>,
+				<&mmcc CAMSS_CSI3_AHB_CLK>,
+				<&mmcc CAMSS_CSI3_CLK>,
+				<&mmcc CAMSS_CPHY_CSID3_CLK>,
+				<&mmcc CAMSS_CSI3PIX_CLK>,
+				<&mmcc CAMSS_CSI3RDI_CLK>,
+				<&mmcc CAMSS_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_CLK>,
+				<&mmcc CAMSS_CSI_VFE0_CLK>,
+				<&mmcc CAMSS_VFE0_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_STREAM_CLK>,
+				<&mmcc CAMSS_VFE1_CLK>,
+				<&mmcc CAMSS_CSI_VFE1_CLK>,
+				<&mmcc CAMSS_VFE1_AHB_CLK>,
+				<&mmcc CAMSS_VFE1_STREAM_CLK>,
+				<&mmcc CAMSS_VFE_VBIF_AHB_CLK>,
+				<&mmcc CAMSS_VFE_VBIF_AXI_CLK>,
+				<&mmcc CSIPHY_AHB2CRIF_CLK>,
+				<&mmcc CAMSS_CPHY_CSID0_CLK>,
+				<&mmcc CAMSS_CPHY_CSID1_CLK>,
+				<&mmcc CAMSS_CPHY_CSID2_CLK>,
+				<&mmcc CAMSS_CPHY_CSID3_CLK>;
+			clock-names = "top_ahb",
+				"throttle_axi",
+				"ispif_ahb",
+				"csiphy0_timer",
+				"csiphy1_timer",
+				"csiphy2_timer",
+				"csi0_ahb",
+				"csi0",
+				"csi0_phy",
+				"csi0_pix",
+				"csi0_rdi",
+				"csi1_ahb",
+				"csi1",
+				"csi1_phy",
+				"csi1_pix",
+				"csi1_rdi",
+				"csi2_ahb",
+				"csi2",
+				"csi2_phy",
+				"csi2_pix",
+				"csi2_rdi",
+				"csi3_ahb",
+				"csi3",
+				"csi3_phy",
+				"csi3_pix",
+				"csi3_rdi",
+				"ahb",
+				"vfe0",
+				"csi_vfe0",
+				"vfe0_ahb",
+				"vfe0_stream",
+				"vfe1",
+				"csi_vfe1",
+				"vfe1_ahb",
+				"vfe1_stream",
+				"vfe_ahb",
+				"vfe_axi",
+				"csiphy_ahb2crif",
+				"cphy_csid0",
+				"cphy_csid1",
+				"cphy_csid2",
+				"cphy_csid3";
+			interconnects = <&mnoc 5 &bimc 5>;
+			interconnect-names = "vfe-mem";
+			iommus = <&mmss_smmu 0xc00>,
+				 <&mmss_smmu 0xc01>,
+				 <&mmss_smmu 0xc02>,
+				 <&mmss_smmu 0xc03>;
+			power-domains = <&mmcc CAMSS_VFE0_GDSC>,
+					<&mmcc CAMSS_VFE1_GDSC>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci: cci@ca0c000 {
+			compatible = "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0ca0c000 0x1000>;
+			interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
+
+			assigned-clocks = <&mmcc CAMSS_CCI_AHB_CLK>,
+					  <&mmcc CAMSS_CCI_CLK>;
+			assigned-clock-rates = <80800000>, <37500000>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CLK>,
+				 <&mmcc CAMSS_AHB_CLK>;
+			clock-names = "camss_top_ahb",
+				      "cci_ahb",
+				      "cci",
+				      "camss_ahb";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&cci0_default &cci1_default>;
+			power-domains = <&mmcc CAMSS_TOP_GDSC>;
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		mmss_smmu: iommu@cd00000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x0cd00000 0x40000>;
-- 
2.30.1

