Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762452D2BC
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiESMoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbiESMoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237EBA98C
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:06 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MipY6BWsRxQ9IN24bzY+2magn6bWwPkvA6hN+gVE9vA=;
        b=W2oVmhmaatG6stMVjTmYUTQhA8LzjHMq1qq48EyTXbgEWWNQgBIXNY+0nH1gOl+uuKaxHi
        ciIZ4EzBEhakwaCT5nsGmoZkSK3wXApGEyQ3PXo0RRnOn3UDzskRw4ePHO+0zel3ZZqb+f
        /zVtNO72cjG0F1gspnEF/gIbzxxEgirDv4eHIbf10m7/6+iio0ZiHeMeFr5b4vy4YXY1D6
        4ULBNuD/PSN1bSbYhoPbWx6wbK7eKxkNWV9LCOR9aib2wskAB83fZay1SbQl5qB5d4kxYc
        sSgOL7iDn/59kADoX/spv1IKYZLGcGh+7piR6v3sd8qrfrA875OsKex0o6MQaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MipY6BWsRxQ9IN24bzY+2magn6bWwPkvA6hN+gVE9vA=;
        b=rpuOCn/mFOX7QrWN3fjN3bU9hAGTeEue+YJVXCLiJ2Ab15SFjL2LjWJ4WiHYP7UCgOxaa2
        5//muNSQoPCCk7DQ==
From:   "thermal-bot for Keerthy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: k3-j72xx: Add VTM
 bindings documentation
Cc:     Keerthy <j-keerthy@ti.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220517172920.10857-2-j-keerthy@ti.com>
References: <20220517172920.10857-2-j-keerthy@ti.com>
MIME-Version: 1.0
Message-ID: <165296424352.4207.15120944950429601793.tip-bot2@tip-bot2>
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

Commit-ID:     031c2952d1588d47829da3639eaaa5e35ffe4e6e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//031c2952d1588d47829da3639eaaa5e35ffe4e6e
Author:        Keerthy <j-keerthy@ti.com>
AuthorDate:    Tue, 17 May 2022 22:59:19 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:53 +02:00

dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation

Add VTM bindings documentation. In the Voltage Thermal
Management Module(VTM), K3 J72XX supplies a voltage
reference and a temperature sensor feature that are gathered in the band
gap voltage and temperature sensor (VBGAPTS) module. The band
gap provides current and voltage reference for its internal
circuits and other analog IP blocks. The analog-to-digital
converter (ADC) produces an output value that is proportional
to the silicon temperature.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220517172920.10857-2-j-keerthy@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
new file mode 100644
index 0000000..c74f124
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments J72XX VTM (DTS) binding
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,j721e-vtm
+      - ti,j7200-vtm
+
+  reg:
+    items:
+      - description: VTM cfg1 register space
+      - description: VTM cfg2 register space
+      - description: VTM efuse register space
+
+  power-domains:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    wkup_vtm0: thermal-sensor@42040000 {
+        compatible = "ti,j721e-vtm";
+        reg = <0x42040000 0x350>,
+              <0x42050000 0x350>,
+              <0x43000300 0x10>;
+        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+        #thermal-sensor-cells = <1>;
+    };
+
+    mpu_thermal: mpu-thermal {
+        polling-delay-passive = <250>; /* milliseconds */
+        polling-delay = <500>; /* milliseconds */
+        thermal-sensors = <&wkup_vtm0 0>;
+
+        trips {
+            mpu_crit: mpu-crit {
+                temperature = <125000>; /* milliCelsius */
+                hysteresis = <2000>; /* milliCelsius */
+                type = "critical";
+            };
+        };
+    };
+...
