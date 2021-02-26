Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A03267BD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBZUF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:05:57 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:33239 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhBZUFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:05:55 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 1C6781FABC;
        Fri, 26 Feb 2021 21:05:10 +0100 (CET)
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
Subject: [PATCH 08/41] arm64: dts: qcom: sdm630: Add USB configuration
Date:   Fri, 26 Feb 2021 21:03:38 +0100
Message-Id: <20210226200414.167762-9-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This will let us use USB2 on our devices. The SoC
supposedly supports USB3, but there are no known
cases of devices that actually have USB3 wired up in
hardware.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 6a6a34438ac8..551b70a8f22a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -904,6 +904,70 @@ spmi_bus: spmi@800f000 {
 			cell-index = <0>;
 		};
 
+		usb3: usb@a8f8800 {
+			compatible = "qcom,sdm660-dwc3", "qcom,dwc3";
+			reg = <0x0a8f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "bus",
+				      "mock_utmi", "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>,
+					  <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>,
+					       <19200000>;
+
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
+			power-domains = <&gcc USB_30_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
+
+			resets = <&gcc GCC_USB_30_BCR>;
+
+			usb3_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0x0a800000 0xc8d0>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+
+				/*
+				 * SDM630 technically supports USB3 but I
+				 * haven't seen any devices making use of it.
+				 */
+				maximum-speed = "high-speed";
+				phys = <&qusb2phy>;
+				phy-names = "usb2-phy";
+				snps,hird-threshold = /bits/ 8 <0>;
+			};
+		};
+
+		qusb2phy: phy@c012000 {
+			compatible = "qcom,sdm660-qusb2-phy";
+			reg = <0x0c012000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2_hstx_trim>;
+			status = "disabled";
+		};
+
 		sdhc_1: sdhci@c0c4000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c0c4000 0x1000>,
-- 
2.30.1

