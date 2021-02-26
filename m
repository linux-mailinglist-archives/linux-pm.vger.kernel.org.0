Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2D3267C3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBZUGb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:06:31 -0500
Received: from m-r1.th.seeweb.it ([5.144.164.170]:37401 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBZUGL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:06:11 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id B5A891F995;
        Fri, 26 Feb 2021 21:05:18 +0100 (CET)
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
Subject: [PATCH 10/41] arm64: dts: qcom: sdm630: Add SDHCI2 node
Date:   Fri, 26 Feb 2021 21:03:40 +0100
Message-Id: <20210226200414.167762-11-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

This will enable usage of (generally) uSD cards.
While at it, add accompanying OPP table for DVFS.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 410a97ea2bb3..c85a4a71fb0c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1039,6 +1039,56 @@ qusb2phy: phy@c012000 {
 			status = "disabled";
 		};
 
+		sdhc_2: sdhci@c084000 {
+			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0c084000 0x1000>;
+			reg-names = "hc";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			bus-width = <4>;
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+					<&gcc GCC_SDCC2_AHB_CLK>,
+					<&xo_board>;
+			clock-names = "core", "iface", "xo";
+
+			interconnects = <&a2noc 3 &a2noc 10>,
+				        <&gnoc 0 &cnoc 28>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_state_on>;
+			pinctrl-1 = <&sdc2_state_off>;
+			power-domains = <&rpmpd SDM660_VDDCX>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: sdhc1-opp-table {
+				 compatible = "operating-points-v2";
+
+				 opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <200000 140000>;
+					opp-avg-kBps = <130718 133320>;
+				 };
+				 opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <250000 160000>;
+					opp-avg-kBps = <196078 150000>;
+				 };
+				 opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <4096000 4096000>;
+					opp-avg-kBps = <1338562 1338562>;
+				 };
+			};
+		};
+
 		sdhc_1: sdhci@c0c4000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c0c4000 0x1000>,
-- 
2.30.1

