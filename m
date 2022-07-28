Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695D58435B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiG1PmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiG1PmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8D675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:00 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMQ7dR9GxrnQe/Zbmb4AnJae1cd2i2RNMEcv0uTYWz0=;
        b=3nB4HSc5sugUhw8aYm9N3lNPBWIXFPbeBwTgl9uVCOUlL87Vid5A93QSoGh1nT2nXPGHsH
        fh1ZXdig807K/Ai1gFssIMnxYnYYlpd2CuOc8I57iwsPcYMBB9SlmHvJsXP0zDjm4WZylS
        eN2TsHWuLzi/3J3ib67b6Xpeg6R+RauR6nCGifkfC174Ovo34UJkDfB//CNf7xXkpo3IQC
        QMb3X1PTS9eRale46bIYng8LwvpZvrwpRQg4urPDxug2mOsUkwgipuJBtGTEUPdfDqb4HZ
        oCFDPUAgMlz5hi6Xbbjdw+etaPMaXPYOB9oZGwLJ/+zWhUnZadBWrYsfRcLQyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMQ7dR9GxrnQe/Zbmb4AnJae1cd2i2RNMEcv0uTYWz0=;
        b=30IedFXlQe3Ixx6nY4Nzg6w9hczjqVW6vgGvdC7dE05ekFbPKRsor7WSXz92g73Zds9UQy
        FusZtLH7CGBQRLBg==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom,spmi-temp-alarm:
 convert to dtschema
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <165902291832.15455.6793939608370586121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f16d37056be2feeae0680b3675b95ae876ab8c5c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f16d37056be2feeae0680b3675b95ae876ab8c5c
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Wed, 08 Jun 2022 13:27:01 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:44 +02:00

dt-bindings: thermal: qcom,spmi-temp-alarm: convert to dtschema

Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220608112702.80873-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt  | 51 +------------------------------------------
 2 files changed, 85 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt

diff --git a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
new file mode 100644
index 0000000..5f08b6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom,spmi-temp-alarm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QPNP PMIC Temperature Alarm
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chips
+  that utilize the Qualcomm SPMI implementation. These peripherals provide an
+  interrupt signal and status register to identify high PMIC die temperature.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: qcom,spmi-temp-alarm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  io-channels:
+    items:
+      - description: ADC channel, which reports chip die temperature
+
+  io-channel-names:
+    items:
+      - const: thermal
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pm8350_temp_alarm: temperature-sensor@a00 {
+            compatible = "qcom,spmi-temp-alarm";
+            reg = <0xa00>;
+            interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
+
+    thermal-zones {
+        pm8350_thermal: pm8350c-thermal {
+            polling-delay-passive = <100>;
+            polling-delay = <0>;
+            thermal-sensors = <&pm8350_temp_alarm>;
+
+            trips {
+                pm8350_trip0: trip0 {
+                    temperature = <95000>;
+                    hysteresis = <0>;
+                    type = "passive";
+                };
+
+                pm8350_crit: pm8350c-crit {
+                    temperature = <115000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
deleted file mode 100644
index 2d5b2ad..0000000
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-Qualcomm QPNP PMIC Temperature Alarm
-
-QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chips
-that utilize the Qualcomm SPMI implementation. These peripherals provide an
-interrupt signal and status register to identify high PMIC die temperature.
-
-Required properties:
-- compatible:      Should contain "qcom,spmi-temp-alarm".
-- reg:             Specifies the SPMI address.
-- interrupts:      PMIC temperature alarm interrupt.
-- #thermal-sensor-cells: Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Optional properties:
-- io-channels:     Should contain IIO channel specifier for the ADC channel,
-                   which report chip die temperature.
-- io-channel-names: Should contain "thermal".
-
-Example:
-
-	pm8941_temp: thermal-alarm@2400 {
-		compatible = "qcom,spmi-temp-alarm";
-		reg = <0x2400>;
-		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
-		#thermal-sensor-cells = <0>;
-
-		io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
-		io-channel-names = "thermal";
-	};
-
-	thermal-zones {
-		pm8941 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&pm8941_temp>;
-
-			trips {
-				stage1 {
-					temperature = <105000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-				stage2 {
-					temperature = <125000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-		};
-	};
-
