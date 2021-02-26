Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C186E3267CA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBZUGr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:06:47 -0500
Received: from m-r1.th.seeweb.it ([5.144.164.170]:40971 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhBZUGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:06:41 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id B1BCC1FADD;
        Fri, 26 Feb 2021 21:05:27 +0100 (CET)
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
Subject: [PATCH 12/41] arm64: dts: qcom: sdm630: Add GPU Clock Controller node
Date:   Fri, 26 Feb 2021 21:03:42 +0100
Message-Id: <20210226200414.167762-13-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add the GPU Clock Controller in SDM630 and keep it disabled by
default.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index ed7d22aa734c..cc8589cb5095 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm660.h>
+#include <dt-bindings/clock/qcom,gpucc-sdm660.h>
 #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -925,6 +926,22 @@ kgsl_smmu: iommu@5040000 {
 			status = "disabled";
 		};
 
+		gpucc: clock-controller@5065000 {
+			compatible = "qcom,gpucc-sdm630";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x05065000 0x9038>;
+
+			clocks = <&xo_board>,
+				 <&gcc GCC_GPU_GPLL0_CLK>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK>;
+			clock-names = "xo",
+				      "gcc_gpu_gpll0_clk",
+				      "gcc_gpu_gpll0_div_clk";
+			status = "disabled";
+		};
+
 		lpass_smmu: iommu@5100000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x05100000 0x40000>;
-- 
2.30.1

