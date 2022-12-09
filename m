Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28406648531
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLIP07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiLIP0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A07900C5
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:34 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L66KVDqgtF9bZOrXWLrpHr9D0eE7kXOXaFnZ7xzX7yc=;
        b=tBONnzruUgMMRYTtp4EV5bC2e6UZp5Z2CNzdiZI25VSzG89Xwxnzfv4w6iZUBDbi2vCTaE
        GkQ4aHtaz+L0UQa5fntMocxHUeP0BzC3mFYBcxopDD5gacdyQRbePxnrCMd/mxdzlbcWZw
        lgXc8c/YZ1f8a08Zjn4wEQNBGzOCVg/DrCSRKgxnRoMGzRdFMGQPlpsQP/zMwDuEUt+10k
        toPkcZK/lXmaFwxJk/B43NoF0QidMuGpf8XRWBcpGpWbHl02W2WxXW6QkisXB/aTGQOSdJ
        CAykHlI6GBrJiJXlEE/eVBBkK5MJ4cVOcXB5U2kGU/9XZGEHzACz/mqri8S8NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L66KVDqgtF9bZOrXWLrpHr9D0eE7kXOXaFnZ7xzX7yc=;
        b=CVQF3Puq/HmEu8MuecFoCQRpAmhqHqLrC9gNDxyuIQoW8ktACTfwYQ2MZkOybwd0dusgmp
        FM16yTuJnYQi1ICA==
From:   "thermal-bot for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: Convert
 generic-adc-thermal to DT schema
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221011175235.3191509-1-robh@kernel.org>
References: <20221011175235.3191509-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <167059959129.4906.7250746047893500403.tip-bot2@tip-bot2>
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

Commit-ID:     baf00b6096b41571741153da3e7c8ef778649726
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//baf00b6096b41571741153da3e7c8ef778649726
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Tue, 11 Oct 2022 12:52:35 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

dt-bindings: thermal: Convert generic-adc-thermal to DT schema

Convert the 'generic-adc-thermal' binding to DT schema format.

The binding said '#thermal-sensor-cells' should be 1, but all in tree
users are 0 and 1 doesn't make sense for a single channel.

Drop the example's related providers and consumers of the
'generic-adc-thermal' node as the convention is to not have those in
the examples.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221011175235.3191509-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt  | 95 +----------------------------------------------------------------------
 2 files changed, 84 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
new file mode 100644
index 0000000..f1fc3b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/generic-adc-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: General Purpose Analog To Digital Converter (ADC) based thermal sensor
+
+maintainers:
+  - Laxman Dewangan <ldewangan@nvidia.com>
+
+description:
+  On some of platforms, thermal sensor like thermistors are connected to
+  one of ADC channel and sensor resistance is read via voltage across the
+  sensor resistor. The voltage read across the sensor is mapped to
+  temperature using voltage-temperature lookup table.
+
+properties:
+  compatible:
+    const: generic-adc-thermal
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  io-channels:
+    maxItems: 1
+
+  io-channel-names:
+    const: sensor-channel
+
+  temperature-lookup-table:
+    description: |
+      Lookup table to map the relation between ADC value and temperature.
+      When ADC is read, the value is looked up on the table to get the
+      equivalent temperature.
+
+      If not specified, driver assumes the ADC channel gives milliCelsius
+      directly.
+    $ref: /schemas/types.yaml#/definitions/int32-matrix
+    items:
+      items:
+        - description: Temperature in milliCelsius
+        - description: ADC read value
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+
+    thermal-sensor {
+        compatible = "generic-adc-thermal";
+        #thermal-sensor-cells = <0>;
+        io-channels = <&ads1015 1>;
+        io-channel-names = "sensor-channel";
+        temperature-lookup-table = <
+              (-40000) 2578
+              (-39000) 2577
+              (-38000) 2576
+              (-37000) 2575
+              (-36000) 2574
+              (-35000) 2573
+              (-34000) 2572
+              (-33000) 2571
+              (-32000) 2569
+              (-31000) 2568
+              (-30000) 2567
+              /* skip */
+              118000 254
+              119000 247
+              120000 240
+              121000 233
+              122000 226
+              123000 220
+              124000 214
+              125000 208>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
deleted file mode 100644
index e136946..0000000
--- a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
+++ /dev/null
@@ -1,95 +0,0 @@
-General Purpose Analog To Digital Converter (ADC) based thermal sensor.
-
-On some of platforms, thermal sensor like thermistors are connected to
-one of ADC channel and sensor resistance is read via voltage across the
-sensor resistor. The voltage read across the sensor is mapped to
-temperature using voltage-temperature lookup table.
-
-Required properties:
-===================
-- compatible:		     Must be "generic-adc-thermal".
-- #thermal-sensor-cells:     Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description
-		             of this property.
-Optional properties:
-===================
-- temperature-lookup-table:  Two dimensional array of Integer; lookup table
-			     to map the relation between ADC value and
-			     temperature. When ADC is read, the value is
-			     looked up on the table to get the equivalent
-			     temperature.
-
-			     The first value of the each row of array is the
-			     temperature in milliCelsius and second value of
-			     the each row of array is the ADC read value.
-
-			     If not specified, driver assumes the ADC channel
-			     gives milliCelsius directly.
-
-Example :
-#include <dt-bindings/thermal/thermal.h>
-
-i2c@7000c400 {
-	ads1015: ads1015@4a {
-		reg = <0x4a>;
-		compatible = "ads1015";
-		sampling-frequency = <3300>;
-		#io-channel-cells = <1>;
-	};
-};
-
-tboard_thermistor: thermal-sensor {
-	compatible = "generic-adc-thermal";
-	#thermal-sensor-cells = <0>;
-	io-channels = <&ads1015 1>;
-	io-channel-names = "sensor-channel";
-	temperature-lookup-table = <    (-40000) 2578
-					(-39000) 2577
-					(-38000) 2576
-					(-37000) 2575
-					(-36000) 2574
-					(-35000) 2573
-					(-34000) 2572
-					(-33000) 2571
-					(-32000) 2569
-					(-31000) 2568
-					(-30000) 2567
-					::::::::::
-					118000 254
-					119000 247
-					120000 240
-					121000 233
-					122000 226
-					123000 220
-					124000 214
-					125000 208>;
-};
-
-dummy_cool_dev: dummy-cool-dev {
-	compatible = "dummy-cooling-dev";
-	#cooling-cells = <2>; /* min followed by max */
-};
-
-thermal-zones {
-	Tboard {
-		polling-delay = <15000>; /* milliseconds */
-		polling-delay-passive = <0>; /* milliseconds */
-		thermal-sensors = <&tboard_thermistor>;
-
-		trips {
-			therm_est_trip: therm_est_trip {
-				temperature = <40000>;
-				type = "active";
-				hysteresis = <1000>;
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&therm_est_trip>;
-				cooling-device = <&dummy_cool_dev THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				contribution = <100>;
-			};
-
-		};
-	};
-};
