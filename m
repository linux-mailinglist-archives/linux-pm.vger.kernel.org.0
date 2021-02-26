Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725823267DF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBZUIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:08:12 -0500
Received: from relay01.th.seeweb.it ([5.144.164.162]:45967 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBZUHY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:07:24 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 969751FAC6;
        Fri, 26 Feb 2021 21:06:03 +0100 (CET)
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
Subject: [PATCH 20/41] arm64: dts: qcom: sdm630: Add Adreno 508 GPU configuration
Date:   Fri, 26 Feb 2021 21:03:50 +0100
Message-Id: <20210226200414.167762-21-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

The SDM630 SoC features an Adreno 508.0 GPU with a minimum frequency
of 160MHz and a maximum of (depending on the speed-bin) 775MHz.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 84 +++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index d4dd8624cac5..1da9b8aa5c0f 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Copyright (c) 2020, Konrad Dybcio
+ * Copyright (c) 2020, Konrad Dybcio <konradybcio@gmail.com>
+ * Copyright (c) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm660.h>
@@ -1137,6 +1138,87 @@ pinconf-sd-cd {
 			};
 		};
 
+		adreno_gpu: gpu@5000000 {
+			compatible = "qcom,adreno-508.0", "qcom,adreno";
+			#stream-id-cells = <16>;
+
+			reg = <0x05000000 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
+				<&gpucc GPUCC_RBBMTIMER_CLK>,
+				<&gcc GCC_BIMC_GFX_CLK>,
+				<&gcc GCC_GPU_BIMC_GFX_CLK>,
+				<&gpucc GPUCC_RBCPR_CLK>,
+				<&gpucc GPUCC_GFX3D_CLK>;
+
+			clock-names = "iface",
+				"rbbmtimer",
+				"mem",
+				"mem_iface",
+				"rbcpr",
+				"core";
+
+			power-domains = <&rpmpd SDM660_VDDMX>;
+			iommus = <&kgsl_smmu 0>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			interconnects = <&gnoc 1 &bimc 5>;
+			interconnect-names = "gfx-mem";
+
+			operating-points-v2 = <&gpu_sdm630_opp_table>;
+
+			gpu_sdm630_opp_table: opp-table {
+				compatible  = "operating-points-v2";
+				opp-775000000 {
+					opp-hz = /bits/ 64 <775000000>;
+					opp-level = <RPM_SMD_LEVEL_TURBO>;
+					opp-peak-kBps = <5412000>;
+					opp-supported-hw = <0xA2>;
+				};
+				opp-647000000 {
+					opp-hz = /bits/ 64 <647000000>;
+					opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					opp-peak-kBps = <4068000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-588000000 {
+					opp-hz = /bits/ 64 <588000000>;
+					opp-level = <RPM_SMD_LEVEL_NOM>;
+					opp-peak-kBps = <3072000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-465000000 {
+					opp-hz = /bits/ 64 <465000000>;
+					opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					opp-peak-kBps = <2724000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-370000000 {
+					opp-hz = /bits/ 64 <370000000>;
+					opp-level = <RPM_SMD_LEVEL_SVS>;
+					opp-peak-kBps = <2188000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <1648000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-160000000 {
+					opp-hz = /bits/ 64 <160000000>;
+					opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+					opp-peak-kBps = <1200000>;
+					opp-supported-hw = <0xFF>;
+				};
+			};
+		};
+
 		kgsl_smmu: iommu@5040000 {
 			compatible = "qcom,sdm630-smmu-v2",
 				     "qcom,adreno-smmu", "qcom,smmu-v2";
-- 
2.30.1

