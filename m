Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98A43267AD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZUFV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:05:21 -0500
Received: from relay01.th.seeweb.it ([5.144.164.162]:41385 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBZUFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:05:17 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id E6EBC1F87C;
        Fri, 26 Feb 2021 21:04:29 +0100 (CET)
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
Subject: [PATCH 01/41] arm64: dts: qcom: sdm630: Rewrite memory map
Date:   Fri, 26 Feb 2021 21:03:31 +0100
Message-Id: <20210226200414.167762-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

The memory map was wrong. Fix it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 41 ++++++++++++----------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f91a928466c3..5ea3884b3ccb 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -343,10 +343,19 @@ wlan_msa_mem: wlan-msa-mem@85700000 {
 		};
 
 		qhee_code: qhee-code@85800000 {
-			reg = <0x0 0x85800000 0x0 0x3700000>;
+			reg = <0x0 0x85800000 0x0 0x600000>;
 			no-map;
 		};
 
+		rmtfs_mem: memory@85e00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x85e00000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
 		smem_region: smem-mem@86000000 {
 			reg = <0 0x86000000 0 0x200000>;
 			no-map;
@@ -357,58 +366,44 @@ tz_mem: memory@86200000 {
 			no-map;
 		};
 
-		modem_fw_mem: modem-fw-region@8ac00000 {
+		mpss_region: mpss@8ac00000 {
 			reg = <0x0 0x8ac00000 0x0 0x7e00000>;
 			no-map;
 		};
 
-		adsp_fw_mem: adsp-fw-region@92a00000 {
+		adsp_region: adsp@92a00000 {
 			reg = <0x0 0x92a00000 0x0 0x1e00000>;
 			no-map;
 		};
 
-		pil_mba_mem: pil-mba-region@94800000 {
+		mba_region: mba@94800000 {
 			reg = <0x0 0x94800000 0x0 0x200000>;
 			no-map;
 		};
 
-		buffer_mem: buffer-region@94a00000 {
+		buffer_mem: tzbuffer@94a00000 {
 			reg = <0x0 0x94a00000 0x0 0x100000>;
 			no-map;
 		};
 
-		venus_fw_mem: venus-fw-region@9f800000 {
+		venus_region: venus@9f800000 {
 			reg = <0x0 0x9f800000 0x0 0x800000>;
 			no-map;
 		};
 
-		secure_region2: secure-region2@f7c00000 {
-			reg = <0x0 0xf7c00000 0x0 0x5c00000>;
-			no-map;
-		};
-
 		adsp_mem: adsp-region@f6000000 {
 			reg = <0x0 0xf6000000 0x0 0x800000>;
 			no-map;
 		};
 
-		qseecom_ta_mem: qseecom-ta-region@fec00000 {
-			reg = <0x0 0xfec00000 0x0 0x1000000>;
-			no-map;
-		};
-
 		qseecom_mem: qseecom-region@f6800000 {
 			reg = <0x0 0xf6800000 0x0 0x1400000>;
 			no-map;
 		};
 
-		secure_display_memory: secure-region@f5c00000 {
-			reg = <0x0 0xf5c00000 0x0 0x5c00000>;
-			no-map;
-		};
-
-		cont_splash_mem: cont-splash-region@9d400000 {
-			reg = <0x0 0x9d400000 0x0 0x23ff000>;
+		zap_shader_region: gpu@fed00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xfed00000 0x0 0xa00000>;
 			no-map;
 		};
 	};
-- 
2.30.1

