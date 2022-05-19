Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6E52D2D6
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiESMod (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiESMo3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EC9BA99D
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:27 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXYEHgnNnqiTJzC/gUhWoyUQ/IUWe2ejIqgC4eM/G94=;
        b=BRGEmuQhqwA70QTPM9OZ8EWUbww63JMokehdTQq5y0OhVy8qtdg7lZqSrovNme8cvaAA0W
        R8IOcQDYCOR6HkWqIGAJYI55ZTdp/TodtLI3M3CqlBj1XtQqugAUPd1uoEG1SDb2XkU4NA
        /zWnnX3JjkFBhjaWX+5495x2ZUiOhatjXK2X2Rb1F3W0AdwGAg2IC7bgKqDGXT/EajX93K
        uN0xLI/oAtTqXsHKbUS4ku6ZxiZjZ6YkzytY9EXCm4iyYZNsTH0BKn6yBFs8kpXRgSCFJJ
        26xFlBu6tG1tj+csilMnD/VkC8BezZPn4X7SnDmnzQcrSrhJzZvTbB7We0fKHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXYEHgnNnqiTJzC/gUhWoyUQ/IUWe2ejIqgC4eM/G94=;
        b=PVQzF6YTWpcROjvP1vzLr/3ZTm4p9U5/R/7P5yDo7DvU037lpQ/pTK8TDU+4IvqAm2tpOi
        Rer4049Ne6MNUrCg==
From:   "thermal-bot for Jishnu Prakash" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom: add PMIC5 Gen2
 ADC_TM bindings
Cc:     Jishnu Prakash <quic_jprakash@quicinc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1648991869-20899-2-git-send-email-quic_jprakash@quicinc.com>
References: <1648991869-20899-2-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Message-ID: <165296426530.4207.10810517684041896093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e46e003a4897385886f932013673ecfd317c8156
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e46e003a4897385886f932013673ecfd317c8156
Author:        Jishnu Prakash <quic_jprakash@quicinc.com>
AuthorDate:    Sun, 03 Apr 2022 18:47:46 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:50 +02:00

dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings

Add documentation for PMIC5 Gen2 ADC_TM peripheral.
It is used for monitoring ADC channel thresholds for PMIC7-type
PMICs. It is present on PMK8350, like PMIC7 ADC and can be used
to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
on a target, through PBS(Programmable Boot Sequence).

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1648991869-20899-2-git-send-email-quic_jprakash@quicinc.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 3ea8c0c..feb390d 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -10,7 +10,9 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,spmi-adc-tm5
+    enum:
+      - qcom,spmi-adc-tm5
+      - qcom,spmi-adc-tm5-gen2
 
   reg:
     maxItems: 1
@@ -33,6 +35,7 @@ properties:
   qcom,avg-samples:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Number of samples to be used for measurement.
+            Not applicable for Gen2 ADC_TM peripheral.
     enum:
       - 1
       - 2
@@ -45,6 +48,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: This parameter is used to decrease ADC sampling rate.
             Quicker measurements can be made by reducing decimation ratio.
+            Not applicable for Gen2 ADC_TM peripheral.
     enum:
       - 250
       - 420
@@ -93,6 +97,29 @@ patternProperties:
           - const: 1
           - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
 
+      qcom,avg-samples:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Number of samples to be used for measurement.
+          This property in child node is applicable only for Gen2 ADC_TM peripheral.
+        enum:
+          - 1
+          - 2
+          - 4
+          - 8
+          - 16
+        default: 1
+
+      qcom,decimation:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: This parameter is used to decrease ADC sampling rate.
+          Quicker measurements can be made by reducing decimation ratio.
+          This property in child node is applicable only for Gen2 ADC_TM peripheral.
+        enum:
+          - 85
+          - 340
+          - 1360
+        default: 1360
+
     required:
       - reg
       - io-channels
@@ -100,6 +127,31 @@ patternProperties:
     additionalProperties:
       false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,spmi-adc-tm5
+
+    then:
+      patternProperties:
+        "^([-a-z0-9]*)@[0-7]$":
+          properties:
+            qcom,decimation: false
+            qcom,avg-samples: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,spmi-adc-tm5-gen2
+
+    then:
+      properties:
+        qcom,avg-samples: false
+        qcom,decimation: false
+
 required:
   - compatible
   - reg
@@ -124,7 +176,7 @@ examples:
             #size-cells = <0>;
             #io-channel-cells = <1>;
 
-            /* Other propreties are omitted */
+            /* Other properties are omitted */
             conn-therm@4f {
                 reg = <ADC5_AMUX_THM3_100K_PU>;
                 qcom,ratiometric;
@@ -148,4 +200,58 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmk8350_vadc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc7";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* Other properties are omitted */
+            xo-therm@44 {
+                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+
+            conn-therm@47 {
+                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+
+        pmk8350_adc_tm: adc-tm@3400 {
+            compatible = "qcom,spmi-adc-tm5-gen2";
+            reg = <0x3400>;
+            interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+            #thermal-sensor-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pmk8350-xo-therm@0 {
+                reg = <0>;
+                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                qcom,decimation = <340>;
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+
+            conn-therm@1 {
+                reg = <1>;
+                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU>;
+                qcom,avg-samples = <2>;
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+        };
+    };
 ...
