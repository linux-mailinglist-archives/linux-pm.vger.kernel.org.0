Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775C24E319
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHUWT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgHUWT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 18:19:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3DC061574;
        Fri, 21 Aug 2020 15:19:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l23so2830935edv.11;
        Fri, 21 Aug 2020 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7m/Ycm4j4fWiwwh3Ai5XjbqkZlZjLtu2RL9no4ARZcc=;
        b=bWY+zeT6qUPGNa632RX7dCtNGQnAIU3MHn91jq24s53q07oz/CbIWQfgekQxJUHMO0
         Z1ii5U3BjgVl9vQkNiEX7q1+dzS3TSguzZC32t4EbTUlJy7UGzzV1xDIyhIic3MRze+T
         C8coh42ER/M8aYroBIalvyokpvDH2NE1imF580FhD+3ZUQeESASyxyV3gyVVnJm6xbZt
         jAEEI8pdFhAYz8DoiSqkyZ0uuG7vgHi237KVbgfwnQCAZpkXB1D2gPJK8uZyiQSgohRR
         esfpXhI+fUMzm+hd43IV62gk/ZI/QiSF5xgx2BUdU8TwpD/7duvo78TpOuLHNkni5E8x
         mv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7m/Ycm4j4fWiwwh3Ai5XjbqkZlZjLtu2RL9no4ARZcc=;
        b=JDuYBz1es+GA1zKnizeCzwLqUf7XilSFLl9Ypot6sb3j4C71MvDBgT5g84bw2maGvl
         blQ6Vy04ztxClthOtbdyBfXriKzhZKn5ilAzvLBJU3L3Nu1rKgPXXCNHJagojT3EoZfg
         YTe0LSdAzkpoRkrFhGfeaNpB553hf8BHbOnlajITh63C9FhrM6QYTEEjxvvyj/xhL5kc
         F5pgTFBCPQt2Fi6D/LYzur1p4TLXn04I0eSsdc6jk1lmEWm2RnztNj33G3XFA2LNoxXz
         XDicbI1mn9bYBC+LrcfLvY2+VFxWUUuNaIN3++c06oas7JpH9Pd2qFuMlNeAOoMk2dza
         qELw==
X-Gm-Message-State: AOAM530s9bIznb6MgXZoOjUARscSoqCvaLq7YyPqRhWtMIV1LwW/yyNO
        j3/NDwMWCyET1jk9zEySupA=
X-Google-Smtp-Source: ABdhPJyBhCtQUY5JBzFhCWX6AOeyeqIpIz/Ri1gFHJUv8auK6JiEeGejeCf695YiI+FwTJ3xCruhwQ==
X-Received: by 2002:a05:6402:1591:: with SMTP id c17mr4888214edv.111.1598048396165;
        Fri, 21 Aug 2020 15:19:56 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id p23sm1780147edm.31.2020.08.21.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:19:55 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
Date:   Sat, 22 Aug 2020 01:19:47 +0300
Message-Id: <863c9c1e44cfbe6184bf0bd4893ff456af0e7bb8.1598043782.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding for Actions Semi ATC260x PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml

diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
new file mode 100644
index 000000000000..4a55bbe1306e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
@@ -0,0 +1,221 @@
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
+  pwrc:
+    type: object
+    description: |
+      The power controller integrated in ATC260x provides system power-off
+      and reboot operations.
+
+    properties:
+      compatible:
+        enum:
+          - actions,atc2603c-pwrc
+          - actions,atc2609a-pwrc
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  onkey:
+    type: object
+    description: |
+      Use the ONKEY built into ATC260x PMICs as an input device reporting
+      power button status. ONKEY can be used to wakeup from low power
+      modes and force a reset on long press.
+
+    properties:
+      compatible:
+        enum:
+          - actions,atc2603c-onkey
+          - actions,atc2609a-onkey
+
+      actions,reset-time-sec:
+        description: |
+          Duration in seconds which the key should be kept pressed for device
+          to reset automatically. The hardware default is 8. Use 0 to disable
+          this functionality.
+        enum: [0, 6, 8, 10, 12]
+
+    required:
+      - compatible
+
+    additionalProperties: false
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
+
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@65 {
+        compatible = "actions,atc2603c";
+        reg = <0x65>;
+        interrupt-parent = <&sirq>;
+        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+
+        pwrc {
+          compatible = "actions,atc2603c-pwrc";
+        };
+
+        onkey {
+          compatible = "actions,atc2603c-onkey";
+          actions,reset-time-sec = <6>;
+        };
+
+        regulators {
+          compatible = "actions,atc2603c-regulator";
+
+          dcdc1-supply = <&reg_5v0>;
+          dcdc3-supply = <&reg_5v0>;
+          ldo5-supply = <&reg_5v0>;
+          switchldo1-supply = <&vcc>;
+
+          vdd_cpu: dcdc1 {
+            regulator-name = "VDD_CPU";
+            regulator-min-microvolt = <700000>;
+            regulator-max-microvolt = <1400000>;
+            regulator-always-on;
+          };
+
+          vcc: dcdc3 {
+            regulator-name = "VCC";
+            regulator-min-microvolt = <2600000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          vcc_3v1: ldo5 {
+            regulator-name = "VCC_3V1";
+            regulator-min-microvolt = <2600000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          sd_vcc: switchldo1 {
+            regulator-name = "SD_VCC";
+            regulator-min-microvolt = <3000000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+            regulator-boot-on;
+          };
+        };
+      };
+    };
+
+...
-- 
2.28.0

