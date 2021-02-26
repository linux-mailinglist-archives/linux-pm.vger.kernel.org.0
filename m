Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F453267CF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBZUHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhBZUGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:06:41 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C667C06178A
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 12:05:36 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 1BF051FABA;
        Fri, 26 Feb 2021 21:05:32 +0100 (CET)
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
Subject: [PATCH 13/41] arm64: dts: qcom: sdm630: Add clocks and power domains to SMMU nodes
Date:   Fri, 26 Feb 2021 21:03:43 +0100
Message-Id: <20210226200414.167762-14-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add the required clocks and power domains for the SMMUs to work.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index cc8589cb5095..9e50c9adada6 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -563,9 +563,14 @@ snoc: interconnect@1626000 {
 		anoc2_smmu: iommu@16c0000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x016c0000 0x40000>;
-			#iommu-cells = <1>;
 
+			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			assigned-clock-rates = <1000>;
+			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			clock-names = "bus";
 			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+
 			interrupts =
 				<GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
@@ -907,9 +912,22 @@ pinconf-sd-cd {
 		kgsl_smmu: iommu@5040000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x05040000 0x10000>;
-			#iommu-cells = <1>;
 
+			/*
+			 * GX GDSC parent is CX. We need to bring up CX for SMMU
+			 * but we need both up for Adreno. On the other hand, we
+			 * need to manage the GX rpmpd domain in the adreno driver.
+			 * Enable CX/GX GDSCs here so that we can manage just the GX
+			 * RPM Power Domain in the Adreno driver.
+			 */
+			power-domains = <&gpucc GPU_GX_GDSC>;
+			clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
+				 <&gcc GCC_BIMC_GFX_CLK>,
+				 <&gcc GCC_GPU_BIMC_GFX_CLK>;
+			clock-names = "iface", "mem", "mem_iface";
 			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+
 			interrupts =
 				<GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
@@ -1600,9 +1618,16 @@ blsp_i2c8: i2c@c1b8000 {
 		mmss_smmu: iommu@cd00000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x0cd00000 0x40000>;
-			#iommu-cells = <1>;
 
+			clocks = <&mmcc MNOC_AHB_CLK>,
+				 <&mmcc BIMC_SMMU_AHB_CLK>,
+				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
+				 <&mmcc BIMC_SMMU_AXI_CLK>;
+			clock-names = "iface-mm", "iface-smmu",
+				      "bus-mm", "bus-smmu";
 			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+
 			interrupts =
 				<GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.30.1

