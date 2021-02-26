Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023432681F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhBZULb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBZUK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:10:59 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58FC06121F;
        Fri, 26 Feb 2021 12:06:56 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 3BE141F981;
        Fri, 26 Feb 2021 21:06:54 +0100 (CET)
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
Subject: [PATCH 31/41] arm64: dts: qcom: sdm630-nile: Use &labels
Date:   Fri, 26 Feb 2021 21:04:01 +0100
Message-Id: <20210226200414.167762-32-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Refer to nodes by their labels to match the current
convention.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     | 61 +++++++++++--------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index b7f3da0d72e7..34a38bff09b8 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -5,8 +5,6 @@
  *                     <angelogioacchino.delregno@somainline.org>
  */
 
-/dts-v1/;
-
 #include "sdm630.dtsi"
 #include "pm660.dtsi"
 #include "pm660l.dtsi"
@@ -150,40 +148,38 @@ removed_region@85800000 {
 			no-map;
 		};
 	};
+};
 
-	soc {
-		sdhci@c0c4000 {
-			status = "okay";
+&blsp_i2c1 {
+	status = "okay";
 
-			mmc-ddr-1_8v;
-			/* SoMC Nile platform's eMMC doesn't support HS200 mode */
-			mmc-hs400-1_8v;
-		};
+	/* Synaptics touchscreen */
+};
 
-		i2c@c175000 {
-			status = "okay";
+&blsp_i2c2 {
+	status = "okay";
 
-			/* Synaptics touchscreen */
-		};
+	/* SMB1351 charger */
+};
 
-		i2c@c176000 {
-			status = "okay";
+/* I2C3, 4, 5, 7 and 8 are disabled on this board. */
 
-			/* SMB1351 charger */
-		};
+&blsp_i2c6 {
+	status = "okay";
 
-		serial@c1af000 {
-			status = "okay";
-		};
+	/* NXP NFC */
+};
 
-		/* I2C3, 4, 5, 7 and 8 are disabled on this board. */
+&blsp1_uart2 {
+	status = "okay";
 
-		i2c@c1b6000 {
-			status = "okay";
+	/* MSM serial console */
+};
 
-			/* NXP NFC */
-		};
-	};
+&blsp2_uart1 {
+	status = "okay";
+
+	/* HCI Bluetooth */
 };
 
 &rpm_requests {
@@ -503,6 +499,19 @@ vreg_l19a_3p3: l19 {
 	};
 };
 
+&sdhc_1 {
+	status = "okay";
+	supports-cqe;
+
+	/* SoMC Nile platform's eMMC doesn't support HS200 mode */
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+
+	vmmc-supply = <&vreg_l4b_29p5>;
+	vqmmc-supply = <&vreg_l8a_1p8>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <8 4>;
 
-- 
2.30.1

