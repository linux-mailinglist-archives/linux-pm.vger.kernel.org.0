Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866BC3267D7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBZUH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBZUHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:07:16 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F279C061793;
        Fri, 26 Feb 2021 12:04:53 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id EC2B61FAB7;
        Fri, 26 Feb 2021 21:04:49 +0100 (CET)
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
Subject: [PATCH 04/41] arm64: dts: qcom: sdm630: Add interconnect provider nodes
Date:   Fri, 26 Feb 2021 21:03:34 +0100
Message-Id: <20210226200414.167762-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect provider nodes to allow for NoC bus scaling.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index e2cbe210048e..c46b7327afbe 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm660.h>
+#include <dt-bindings/clock/qcom,mmcc-sdm660.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -516,11 +517,38 @@ rng: rng@793000 {
 			clock-names = "core";
 		};
 
+		bimc: interconnect@1008000 {
+			compatible = "qcom,sdm660-bimc";
+			reg = <0x01008000 0x78000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
 		restart@10ac000 {
 			compatible = "qcom,pshold";
 			reg = <0x010ac000 0x4>;
 		};
 
+		cnoc: interconnect@1500000 {
+			compatible = "qcom,sdm660-cnoc";
+			reg = <0x01500000 0x10000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+		};
+
+		snoc: interconnect@1626000 {
+			compatible = "qcom,sdm660-snoc";
+			reg = <0x01626000 0x7090>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		anoc2_smmu: iommu@16c0000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x016c0000 0x40000>;
@@ -564,6 +592,25 @@ anoc2_smmu: iommu@16c0000 {
 			status = "disabled";
 		};
 
+		a2noc: interconnect@1704000 {
+			compatible = "qcom,sdm660-a2noc";
+			reg = <0x01704000 0xc100>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+		};
+
+		mnoc: interconnect@1745000 {
+			compatible = "qcom,sdm660-mnoc";
+			reg = <0x01745000 0xA010>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a", "iface";
+			clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
+				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
+				 <&mmcc AHB_CLK_SRC>;
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x01f40000 0x20000>;
@@ -1156,6 +1203,18 @@ mmss_smmu: iommu@cd00000 {
 			status = "disabled";
 		};
 
+		gnoc: interconnect@17900000 {
+			compatible = "qcom,sdm660-gnoc";
+			reg = <0x17900000 0xe000>;
+			#interconnect-cells = <1>;
+			/*
+			 * This one apparently features no clocks,
+			 * so let's not mess with the driver needlessly
+			 */
+			clock-names = "bus", "bus_a";
+			clocks = <&xo_board>, <&xo_board>;
+		};
+
 		apcs_glb: mailbox@17911000 {
 			compatible = "qcom,sdm660-apcs-hmss-global";
 			reg = <0x17911000 0x1000>;
-- 
2.30.1

