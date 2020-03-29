Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60CC196E5F
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgC2QWN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:22:13 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52516 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgC2QWN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:22:13 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 12:22:10 EDT
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2A5652499B;
        Sun, 29 Mar 2020 18:22:09 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
Date:   Sun, 29 Mar 2020 18:21:23 +0200
Message-Id: <20200329162128.218584-5-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
This device-tree binding documents Summit SMB345, SMB347 and SMB358 chargers.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../power/supply/summit,smb347-charger.yaml   | 224 ++++++++++++++++++
 .../dt-bindings/power/summit,smb347-charger.h |  19 ++
 2 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
new file mode 100644
index 000000000000..1d6bccdcd233
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -0,0 +1,224 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/summit,smb347-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Battery charger driver for SMB345, SMB347 and SMB358
+
+maintainers:
+  - David Heidelberg <david@ixit.cz>
+
+properties:
+  compatible:
+    enum:
+      - summit,smb345
+      - summit,smb347
+      - summit,smb358
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  summit,enable-usb-charging:
+    type: boolean
+    description: Enable charging trough USB.
+
+  summit,enable-otg-charging:
+    type: boolean
+    description: Provide power for USB OTG
+
+  summit,enable-mains-charging:
+    type: boolean
+    description: Enable charging trough mains
+
+  summit,enable-chg-ctrl:
+    description: Enable charging control
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum:
+          - 0 # SMB3XX_CHG_ENABLE_SW SW (I2C interface)
+          - 1 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW Pin control (Active Low)
+          - 2 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH Pin control (Active High)
+
+  summit,max-chg-curr:
+    description: Maximum current for charging (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,max-chg-volt:
+    description: Maximum voltage for charging (in uV)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3500000
+    maximum: 4500000
+
+  summit,pre-chg-curr:
+    description: Pre-charging current for charging (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,term-curr:
+    description: Charging cycle termination current (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,fast-volt-threshold:
+    description: Voltage threshold to transit to fast charge mode (in uV)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2400000
+    maximum: 3000000
+
+  summit,mains-curr-limit:
+    description: Maximum input current from AC/DC input (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,usb-curr-limit:
+    description: Maximum input current from USB input (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,chg-curr-comp:
+    description: Charge current compensation (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,chip-temp-threshold:
+    description: Chip temperature for thermal regulation in °C.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [100, 110, 120, 130]
+
+  summit,soft-cold-temp-limit:
+    description: Cold battery temperature in °C for soft alarm.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 5, 10, 15]
+
+  summit,soft-hot-temp-limit:
+    description: Hot battery temperature in °C for soft alarm.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [40, 45, 50, 55]
+
+  summit,hard-cold-temp-limit:
+    description: Cold battery temperature in °C for hard alarm.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/int32
+    enum: [-5, 0, 5, 10]
+
+  summit,hard-hot-temp-limit:
+    description: Hot battery temperature in °C for hard alarm.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [50, 55, 60, 65]
+
+  summit,soft-comp-method:
+    description: Soft temperature limit compensation method
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum:
+          - 0 # SMB3XX_SOFT_TEMP_COMPENSATE_NONE Compensation none
+          - 1 # SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT Current compensation
+          - 2 # SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE Voltage compensation
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - summit,smb345
+            - summit,smb358
+
+    then:
+      properties:
+        summit,max-chg-curr:
+          enum: [ 200000,  450000,  600000,  900000,
+                 1300000, 1500000, 1800000, 2000000]
+
+        summit,pre-chg-curr:
+          enum: [150000, 250000, 350000, 450000]
+
+        summit,term-curr:
+          enum: [ 30000,  40000,  60000,  80000,
+                 100000, 125000, 150000, 200000]
+
+        summit,mains-curr-limit:
+          enum: [ 300000,  500000,  700000, 1000000,
+                 1500000, 1800000, 2000000]
+
+        summit,usb-curr-limit:
+          enum: [ 300000,  500000,  700000, 1000000,
+                 1500000, 1800000, 2000000]
+
+        summit,chg-curr-comp:
+          enum: [200000, 450000, 600000, 900000]
+
+    else:
+      properties:
+        summit,max-chg-curr:
+          enum: [ 700000,  900000, 1200000, 1500000,
+                 1800000, 2000000, 2200000, 2500000]
+
+        summit,pre-chg-curr:
+          enum: [100000, 150000, 200000, 250000]
+
+        summit,term-curr:
+          enum: [ 37500,  50000, 100000, 150000,
+                 200000, 250000, 500000, 600000]
+
+        summit,mains-curr-limit:
+          enum: [ 300000,  500000,  700000,  900000, 1200000,
+                 1500000, 1800000, 2000000, 2200000, 2500000]
+
+        summit,usb-curr-limit:
+          enum: [ 300000,  500000,  700000,  900000, 1200000,
+                 1500000, 1800000, 2000000, 2200000, 2500000]
+
+        summit,chg-curr-comp:
+          enum: [250000, 700000, 900000, 1200000]
+
+required:
+  - compatible
+  - reg
+
+anyOf:
+  - required:
+      - summit,enable-usb-charging
+  - required:
+      - summit,enable-otg-charging
+  - required:
+      - summit,enable-mains-charging
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/summit,smb347-charger.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@7f {
+            compatible = "summit,smb347";
+            reg = <0x7f>;
+            status = "okay";
+
+            summit,max-chg-curr = <1800000>;
+            summit,mains-curr-limit = <2000000>;
+            summit,usb-curr-limit = <500000>;
+
+            summit,chip-temp-threshold = <110>;
+            summit,soft-cold-temp-limit = <5>;
+
+            summit,enable-usb-charging;
+            summit,enable-mains-charging;
+
+            summit,enable-chg-ctrl = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
+        };
+    };
diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/dt-bindings/power/summit,smb347-charger.h
new file mode 100644
index 000000000000..d918bf321a71
--- /dev/null
+++ b/include/dt-bindings/power/summit,smb347-charger.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later or MIT) */
+/*
+ * Author: David Heidelberg <david@ixit.cz>
+ */
+
+#ifndef _DT_BINDINGS_SMB347_CHARGER_H
+#define _DT_BINDINGS_SMB347_CHARGER_H
+
+/* Charging compensation method */
+#define SMB3XX_SOFT_TEMP_COMPENSATE_NONE	0
+#define SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT	1
+#define SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE	2
+
+/* Charging enable control */
+#define SMB3XX_CHG_ENABLE_SW			0
+#define SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW	1
+#define SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH	2
+
+#endif
-- 
2.25.0

