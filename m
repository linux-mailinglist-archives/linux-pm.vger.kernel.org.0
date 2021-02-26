Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B768B32683A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBZUMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBZUMK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:12:10 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0280C0698CE;
        Fri, 26 Feb 2021 12:09:55 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 7D4651FEE6;
        Fri, 26 Feb 2021 21:07:11 +0100 (CET)
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
Subject: [PATCH 35/41] arm64: dts: qcom: sdm630-xperia: Retire sdm630-sony-xperia-ganges.dtsi
Date:   Fri, 26 Feb 2021 21:04:05 +0100
Message-Id: <20210226200414.167762-36-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After further consideration, it is not worth to keep another
separate DTSI, as the differences between Nile and Ganges are
very minimal. Instead, let's just address the minimal differences
between Kirin and Mermaid.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom/sdm630-sony-xperia-ganges-kirin.dts  | 12 +++++-
 .../dts/qcom/sdm630-sony-xperia-ganges.dtsi   | 40 -------------------
 .../sdm630-sony-xperia-nile-discovery.dts     |  1 +
 .../qcom/sdm630-sony-xperia-nile-pioneer.dts  |  1 +
 .../qcom/sdm630-sony-xperia-nile-voyager.dts  |  1 +
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  1 -
 .../sdm636-sony-xperia-ganges-mermaid.dts     | 14 ++++---
 7 files changed, 23 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
index 46a7f2b26e6b..aea949265a2d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
@@ -5,9 +5,19 @@
 
 /dts-v1/;
 
-#include "sdm630-sony-xperia-ganges.dtsi"
+#include "sdm630.dtsi"
+#include "sdm630-sony-xperia-nile.dtsi"
 
 / {
 	model = "Sony Xperia 10";
 	compatible = "sony,kirin-row", "qcom,sdm630";
+
+	chosen {
+		framebuffer@9d400000 {
+			reg = <0 0x9d400000 0 (2520 * 1080 * 4)>;
+			height = <2520>;
+		};
+	};
 };
+
+/delete-node/ &vreg_l18a_1v8;
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
deleted file mode 100644
index cf2e8b5d60e8..000000000000
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2020, Martin Botka
- */
-
-/dts-v1/;
-
-/* Ganges is very similar to Nile, but
- * there are some differences that will need
- * to be addresed when more peripherals are
- * enabled upstream. Hence the separate DTSI.
- */
-#include "sdm630-sony-xperia-nile.dtsi"
-
-/ {
-	chosen {
-		framebuffer@9d400000 {
-			reg = <0 0x9d400000 0 (2520 * 1080 * 4)>;
-			height = <2520>;
-		};
-	};
-
-	/* Yes, this is intentional.
-	 * Ganges devices only use gpio-keys for
-	 * Volume Down, but currently there's an
-	 * issue with it that has to be resolved.
-	 * Until then, let's not make the kernel panic
-	 */
-	/delete-node/ gpio-keys;
-
-	soc {
-
-		i2c@c175000 {
-			status = "okay";
-
-			/* Novatek touchscreen */
-		};
-	};
-
-};
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
index 8fca0b69fa01..c574e430ba67 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include "sdm630.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
index 90dcd4ebaaed..a93ff3ab1b6d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include "sdm630.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
index fae5f1bb6834..59a679c205e0 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include "sdm630.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 0da6dddd5768..deadd8f6ff3a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -5,7 +5,6 @@
  *                     <angelogioacchino.delregno@somainline.org>
  */
 
-#include "sdm630.dtsi"
 #include "pm660.dtsi"
 #include "pm660l.dtsi"
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts b/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
index 7c0830e6a48c..bba1c2bce213 100644
--- a/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
+++ b/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
@@ -5,16 +5,20 @@
 
 /dts-v1/;
 
-/* Mermaid uses sdm636, but it's different ever so slightly
- * that we can ignore it for the time being. Sony also commonizes
- * the Ganges platform as a whole in downstream kernels.
- */
-#include "sdm630-sony-xperia-ganges.dtsi"
+#include "sdm630-sony-xperia-ganges-kirin.dts"
+#include "sdm636.dtsi"
 
 / {
 	model = "Sony Xperia 10 Plus";
 	compatible = "sony,mermaid-row", "qcom,sdm636";
 
+	/* SDM636 v1 */
 	qcom,msm-id = <345 0>;
 	qcom,pmic-id = <0x1001b 0x101011a 0x00 0x00 0x1001b 0x201011a 0x00 0x00 0x1001b 0x102001a 0x00 0x00>;
 };
+
+&sdc2_state_on {
+	pinconf-clk {
+		drive-strength = <14>;
+	};
+};
-- 
2.30.1

