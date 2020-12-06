Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85112D0019
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 02:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgLFB17 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 20:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLFB14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 20:27:56 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85419C0613D4;
        Sat,  5 Dec 2020 17:27:15 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so14218272ejb.13;
        Sat, 05 Dec 2020 17:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hhr+PSpxdrsAQvt323Tq1/gTyUseyObVcoODids+lqA=;
        b=VIdVUCWnufid9JZlpun9gF+LCvqCnlUjubxxJehhofR3y/3C7BRVg41DStuHKhM12Y
         qSAmwSxyBG5frrV/6Bq0VyVEMyUj9/GfadRX7Vdk4vE/7pMHdc17HSFNv1E84oORslC4
         3YyqUxf7zuAc2shTr5enMJEeX/G081pw0hKGQOMcnHx5htE3eRMfsmJbygsMFiiBVkOv
         mPosECN8ZMXiDV69X5XnJC+XtvXNtlT7ahH7XN0WKqr25oMb66QWrwejHtHhtgCIwAaH
         G97P+HtIIdapiOQZN80V0jmkYC2cyDmnx2Vgz5xdu4zQHhXKq3fhBBHSDaN829HpQEyB
         nA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hhr+PSpxdrsAQvt323Tq1/gTyUseyObVcoODids+lqA=;
        b=TRQ0TB0Z1wfqChppu1M7dxM0sw9LzTvwPPTTzVyEipXttxMGQ7H7HtGlReahIuKQmB
         3E+tSfC245Zxz643ejzmtukJmIJi/t9JXt3+9mWOml91hHRNeytH601g6c0v/a5PgsaV
         rcp1c3pQMNphTkW3rjXDq0DAjBsOqsk/BQqf9/HzRMtYCuA26K9ENrI0LUSU4bfslL4/
         BpXcbQxkHnPP2jOgGczR4dwz7OQz7HhNVV3JyuE6AQ4APC9Atf21whHgN7yJcYDppIVC
         f/WJ/mj26pgkso6HW7Q6ozUaSknLIMPVUIB2hl9gXj4/MnBlHphugrFQa/8YZJh3iFRa
         kUOQ==
X-Gm-Message-State: AOAM530E3g3sJI0O3/Wtrh0P0jAopxnR7M6Frx6tKky8d231DGBbKugA
        L2RP+vAlPTd53rXB5R6Z/cI=
X-Google-Smtp-Source: ABdhPJxJCPKxxJZgH3tiYHf0CObocUm0OhfT/xethdm+fsQSsEXUrjha6DRhbhlKDbrxp06PPfGWTQ==
X-Received: by 2002:a17:907:9627:: with SMTP id gb39mr13621713ejc.267.1607218034248;
        Sat, 05 Dec 2020 17:27:14 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id a10sm6157023ejk.92.2020.12.05.17.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 17:27:13 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/7] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
Date:   Sun,  6 Dec 2020 03:27:02 +0200
Message-Id: <fe0ab8ef20813a2623cd1e543b16bb21c5b63367.1607216141.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding for Actions Semi ATC260x PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3 (according to Rob's review):
 - Dropped the 'pwrc' and 'onkey' nodes
 - Used a common 'reset-time-sec' property

 .../bindings/mfd/actions,atc260x.yaml         | 181 ++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml

diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
new file mode 100644
index 000000000000..86aab77ba688
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/actions,atc260x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi ATC260x Power Management IC bindings
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  ATC260x series PMICs integrates Audio Codec, Power Management, RTC, IR
+  and GPIO controller blocks. Currently only the PM related functionalities
+  (i.e. regulators and system power-off/reboot) for the ATC2603C and ATC2609A
+  chip variants are supported.
+  ATC2603C includes 3 programmable DC-DC converters and 9 LDO regulators.
+  ATC2609A includes 5 programmable DC-DC converters and 10 LDO regulators.
+
+allOf:
+  - $ref: ../input/input.yaml
+
+properties:
+  compatible:
+    enum:
+      - actions,atc2603c
+      - actions,atc2609a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-time-sec:
+    description: |
+      Duration in seconds which the key should be kept pressed for device
+      to reset automatically. The hardware default is 8. Use 0 to disable
+      this functionality.
+    enum: [0, 6, 8, 10, 12]
+
+  regulators:
+    type: object
+    description: |
+      List of child nodes specifying the regulators, depending on chip variant:
+      * ATC2603C: dcdc[1-3], ldo[1-3,5-8,11], switchldo1
+      * ATC2609A: dcdc[0-4], ldo[0-9]
+
+    properties:
+      compatible:
+        enum:
+          - actions,atc2603c-regulator
+          - actions,atc2609a-regulator
+
+      switchldo1:
+        type: object
+        $ref: ../regulator/regulator.yaml
+
+        properties:
+          regulator-name: true
+          regulator-boot-on: true
+          regulator-always-on: true
+          regulator-min-microvolt: true
+          regulator-max-microvolt: true
+          regulator-allow-bypass: true
+          regulator-active-discharge: true
+
+        additionalProperties: false
+
+    patternProperties:
+      "^(dcdc[0-4]|ldo[0-9]|ldo11|switchldo1)-supply$":
+        description: ATC260x voltage regulators supplies
+
+      "^(dcdc[0-4]|ldo[0-9]|ldo11)$":
+        type: object
+        $ref: ../regulator/regulator.yaml
+
+        properties:
+          regulator-name: true
+          regulator-boot-on: true
+          regulator-always-on: true
+          regulator-min-microvolt: true
+          regulator-max-microvolt: true
+          regulator-allow-bypass: true
+
+        additionalProperties: false
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: actions,atc2603c-regulator
+        then:
+          patternProperties:
+            "^(dcdc[0,4]|ldo[0,4,9])(-supply)?$": false
+
+            "^(ldo|dcdc)":
+              properties:
+                regulator-allow-bypass: false
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: actions,atc2609a-regulator
+        then:
+          patternProperties:
+            "^(ldo11|switchldo1)(-supply)?$": false
+
+            "^(dcdc|ldo[3-9])":
+              properties:
+                regulator-allow-bypass: false
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@65 {
+            compatible = "actions,atc2603c";
+            reg = <0x65>;
+            interrupt-parent = <&sirq>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+
+            reset-time-sec = <6>;
+
+            regulators {
+                compatible = "actions,atc2603c-regulator";
+
+                dcdc1-supply = <&reg_5v0>;
+                dcdc3-supply = <&reg_5v0>;
+                ldo5-supply = <&reg_5v0>;
+                switchldo1-supply = <&vcc>;
+
+                vdd_cpu: dcdc1 {
+                    regulator-name = "VDD_CPU";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1400000>;
+                    regulator-always-on;
+                };
+
+                vcc: dcdc3 {
+                    regulator-name = "VCC";
+                    regulator-min-microvolt = <2600000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vcc_3v1: ldo5 {
+                    regulator-name = "VCC_3V1";
+                    regulator-min-microvolt = <2600000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                sd_vcc: switchldo1 {
+                    regulator-name = "SD_VCC";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
+
+...
-- 
2.29.2

