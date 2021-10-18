Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF84317C0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJRLsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhJRLsP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534D2C06161C
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 04:46:04 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:46:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIBcUXCwY2J9qebf0j7LSoGgvurufIj+Rvu8t9ytaR4=;
        b=PyjRfW6XzKZQFSnyner5VpA4nwR/xTFx/xT/8LD5GC8G9QieqruT7PSh+Tar2JMnjDdj47
        fW0A6TvT69pCHoTsfLXu1lnicJt+3ipX+i7lbJzcmxs9pwPuMpfNfSsLqNCcI7Z/c6/ddX
        E86pNYMOJ/7oGNriC2X+x9mphl01+w0yhriKFMPYoohKbPz0dXd8NaAx3PKoobHqRL5u1Q
        klex/cPVVhOGgCD5o9h6+rEwxaqu1C/vYK+bY6724Ig7phQ5x4ie6UKYX0sMZ/v5tsLz3n
        9EpN0AOjSnI1/9abL3RDsp30r62ffe3W6W21ObpavnF3meXi3rvHOuSzaDhBnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIBcUXCwY2J9qebf0j7LSoGgvurufIj+Rvu8t9ytaR4=;
        b=TzDQeys1TH99x630c7zj6VeL6KjVXkqmwOXle09VFSmAJPWcJ3Q466iEUdx+tBkRnxO8hz
        sJlynDUBDD7xu+Bw==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom: add HC variant of
 adc-thermal monitor bindings
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211005032531.2251928-2-bjorn.andersson@linaro.org>
References: <20211005032531.2251928-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <163455756206.25758.3202806553805517036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     db03874b854368c14f21bdc41f1044cf6cda6200
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//db03874b854368c14f21bdc41f1044cf6cda6200
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Mon, 04 Oct 2021 20:25:28 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 15 Oct 2021 09:13:55 +02:00

dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor bindings

The HC generation of the ADC Thermal Monitor is quite similar to the 5th
generation, but differs in valid values for a few properties. Create a
new binding for the HC version of the hardware, rather than sprinkle
conditionals throughout the existing binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211005032531.2251928-2-bjorn.andersson@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
new file mode 100644
index 0000000..8273ac5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm-hc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC HC Thermal Monitoring
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,spmi-adc-tm-hc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  qcom,avg-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of samples to be used for measurement.
+    enum:
+      - 1
+      - 2
+      - 4
+      - 8
+      - 16
+    default: 1
+
+  qcom,decimation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This parameter is used to decrease ADC sampling rate.
+            Quicker measurements can be made by reducing decimation ratio.
+    enum:
+      - 256
+      - 512
+      - 1024
+    default: 1024
+
+patternProperties:
+  "^([-a-z0-9]*)@[0-7]$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        description: Specify the sensor channel. There are 8 channels in PMIC5's ADC TM
+        minimum: 0
+        maximum: 7
+
+      io-channels:
+        description:
+          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
+
+      qcom,ratiometric:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Channel calibration type.
+          If this property is specified VADC will use the VDD reference
+          (1.875V) and GND for channel calibration. If property is not found,
+          channel will be calibrated with 0V and 1.25V reference channels,
+          also known as absolute calibration.
+
+      qcom,hw-settle-time-us:
+        description: Time between AMUX getting configured and the ADC starting conversion.
+        enum: [0, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, 6000, 8000, 10000]
+
+      qcom,pre-scaling:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Used for scaling the channel input signal before the
+          signal is fed to VADC. The configuration for this node is to know the
+          pre-determined ratio and use it for post scaling. It is a pair of
+          integers, denoting the numerator and denominator of the fraction by
+          which input signal is multiplied. For example, <1 3> indicates the
+          signal is scaled down to 1/3 of its value before ADC measurement.  If
+          property is not found default value depending on chip will be used.
+        items:
+          - const: 1
+          - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
+
+    required:
+      - reg
+      - io-channels
+
+    additionalProperties:
+      false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pm8998_adc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc-rev2";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* Other propreties are omitted */
+            adc-chan@4c {
+                reg = <ADC5_XO_THERM_100K_PU>;
+            };
+        };
+
+        pm8998_adc_tm: adc-tm@3400 {
+            compatible = "qcom,spmi-adc-tm-hc";
+            reg = <0x3400>;
+            interrupts = <0x2 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+            #thermal-sensor-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            thermistor@1 {
+                reg = <1>;
+                io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+        };
+    };
+...
