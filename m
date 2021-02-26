Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE33267C6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBZUGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:06:41 -0500
Received: from relay01.th.seeweb.it ([5.144.164.162]:42833 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhBZUGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:06:16 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 1A55C1F87C;
        Fri, 26 Feb 2021 21:05:23 +0100 (CET)
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
Subject: [PATCH 11/41] arm64: dts: qcom: sdm630: Add interconnect and opp table to sdhc_1
Date:   Fri, 26 Feb 2021 21:03:41 +0100
Message-Id: <20210226200414.167762-12-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

The SDHC port 1 has interconnects and can make use of DVFS:
define the interconnections and the OPP table in order to
optimize performance and power consumption.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index c85a4a71fb0c..ed7d22aa734c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1106,14 +1106,42 @@ sdhc_1: sdhci@c0c4000 {
 				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
 			clock-names = "core", "iface", "xo", "ice";
 
+			interconnects = <&a2noc 2 &a2noc 10>,
+					<&gnoc 0 &cnoc 27>;
+			interconnect-names = "sdhc1-ddr", "cpu-sdhc1";
+			operating-points-v2 = <&sdhc1_opp_table>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_state_on>;
 			pinctrl-1 = <&sdc1_state_off>;
+			power-domains = <&rpmpd SDM660_VDDCX>;
 
 			bus-width = <8>;
 			non-removable;
 
 			status = "disabled";
+
+			sdhc1_opp_table: sdhc1-opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <200000 140000>;
+					opp-avg-kBps = <130718 133320>;
+				};
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <250000 160000>;
+					opp-avg-kBps = <196078 150000>;
+				};
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <4096000 4096000>;
+					opp-avg-kBps = <1338562 1338562>;
+				};
+			};
 		};
 
 		mmcc: clock-controller@c8c0000 {
-- 
2.30.1

