Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB442F499D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbhAMLGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 06:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbhAMLGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 06:06:45 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE264C061794;
        Wed, 13 Jan 2021 03:06:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id e18so2416460ejt.12;
        Wed, 13 Jan 2021 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+3UStuQq3y4rxdsDL99lzZ9R2xBoDkbhFoWyr+zqXE=;
        b=jY5TNqmm7mZksx1Z3xMWtZ/kspQIjI59tk+U584PQ40QGaUJLJsLSEd9DeotHUK3bK
         kwqxgn+I/4xo5oX3XzkKX2mUsW0xj3vrDLVwGmnKkqI8JS62u/n3+9b/8dIch4JZw7e0
         DFVvWaA0FRo+yHDkI3FFR57+zAlKB949T0KqIprjMJ4naUDD+3CO9V8gel/PBcPDv3Jo
         ihgaO9/0aCgECE1g69q+eQpTrWjPjtd9/gvQFJACrF4uMQ167QCasimbD7Veh3uEePcR
         1M145hkWht1/6JtM6aD6hao+6fKjzThdDJEZjEv/9qRTQqxEFaWCRoswU9QZlDkHjYOg
         6keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+3UStuQq3y4rxdsDL99lzZ9R2xBoDkbhFoWyr+zqXE=;
        b=uZC6EtlXWM9A2bKLmkAHpLLwh6cIHNcp/8Wu/Mv3xbsV6jbtsw1fTFvKdLz55EZ72p
         xmS0thIZNxevp+vJKFg1FaIBLFuGKlOd59FfUtyGj0vV2dhn4HJrRRKStnenKh+Hd9+K
         elNleg74SEvo6wLYSDg3AU87/64xGwlPKm6dnmHbARaCZ6GR343s4GUmX0Gf3+ujDCEG
         utnrZJ81wa1fjEnVkW3qDKZ1s7wM0lwegMVuaBYwSL0whAN9W6OHwqfVy/mjgmUoARdD
         c715NY7IAJdOhv1wKnT6xtjFTQiHb6IpFKgac+xeAFFsCyVSKSKtQavkqNN+8WWBtJaF
         X37g==
X-Gm-Message-State: AOAM531LF8xhOxK+6Q+cVl581dUpv9qfY3QaDiQf9GoRvQWYV6HtbmKD
        GHaeKVtojAUpcwm+cqIu4xy5OMH8Vfg=
X-Google-Smtp-Source: ABdhPJyTIAjOsVx5Z3ymU8SHC3dMCsdZvF+PBEi9QPqaPo1LBFNusNMEzhmoM5KCsAgTxeoVXiSIpA==
X-Received: by 2002:a17:906:c45a:: with SMTP id ck26mr1183230ejb.200.1610535963621;
        Wed, 13 Jan 2021 03:06:03 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id zn8sm597343ejb.39.2021.01.13.03.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:06:02 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/7] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
Date:   Wed, 13 Jan 2021 13:05:52 +0200
Message-Id: <0fe2072b32faaf5db430b9a1979bb99e18887e7e.1610534765.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
References: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding for Actions Semi ATC260x PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
 - None

Changes in v4
 - Added Reviewed-by from Rob
 - Added support for ATC2603C LDO12 fixed regulator per Mark's suggestion

Changes in v3 (according to Rob's review):
 - Dropped the 'pwrc' and 'onkey' nodes
 - Used a common 'reset-time-sec' property

 .../bindings/mfd/actions,atc260x.yaml         | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml

diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
new file mode 100644
index 000000000000..dd43a0c766f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
@@ -0,0 +1,183 @@
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
+  ATC2603C includes 3 programmable DC-DC converters, 9 programmable LDO
+  regulators and 1 fixed LDO regulator.
+  ATC2609A includes 5 programmable DC-DC converters and 10 programmable LDO
+  regulators.
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
+      * ATC2603C: dcdc[1-3], ldo[1-3,5-8,11,12], switchldo1
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
+      "^(dcdc[0-4]|ldo[0-9]|ldo1[1-2]|switchldo1)-supply$":
+        description: ATC260x voltage regulators supplies
+
+      "^(dcdc[0-4]|ldo[0-9]|ldo1[1-2])$":
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
+            "^(ldo1[1-2]|switchldo1)(-supply)?$": false
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
2.30.0

