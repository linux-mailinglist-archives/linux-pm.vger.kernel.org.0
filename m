Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3232E72A0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL2RcL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgL2RcK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 12:32:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381FC061798;
        Tue, 29 Dec 2020 09:31:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id q22so19040367eja.2;
        Tue, 29 Dec 2020 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LI9mt81CVBwBrxE0HZ6xGCeZ8da/K/wOcXVmfavfX5s=;
        b=pm8njTLGUJ7K1PwXHHQDslHwqsbVkJjYnuppHab942yzxoLbwWNduM6UEchzGGwKxl
         ePVhZEET4X4gwA4LsCK8bSj56aVV2QqIIiJtoBa5P4QTVZDuSpI4MQJ7AANYrdU/BggI
         HXLdeSuZFoL4oFsv589ruFIjy2iRntKqFzmtHbPq/G6MnLkwh/POUPoOmKhOgeeP/JPK
         1AWFyHJ+h65KJGoVLNNNicCznoDGXnpom9Lzpg+eMGCEAB7ch3HUJSjsABY2UFTscIKM
         1z+Uann45Es3G4ltixGmkQO0WCH35OgOT1NSzwSQf/hOhwLoQ5MqQ3fP6zKouqV40R9r
         +f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LI9mt81CVBwBrxE0HZ6xGCeZ8da/K/wOcXVmfavfX5s=;
        b=C1MpBWlXcLdPa3F2VWCuqrhbSN7AaSIbZq2Ihb7liaLh46pf6xK7V8eba9zge+IrmS
         qG+p2y4Zfj0ri74CPM+1HyJIpPLE5iooMKaOyGM5rbQrk053whl5+lrCy7eWdvuC89E1
         6gwOdkJwdZ58rqqBB7YnMZj3dnuz9pEqhm01JE8tIrEaKo8gTEKdJPbyYaOq6Ei6Aw5C
         xpD0m/xOH+9QOQ7Ewx9GwM1AxGKe+gB/rmvu/65b5/3YIm3TgYldE+AolVkFeRdaFD3s
         Rfe6zveNoK+UluRtrkptv5+I8byA5MoZGY00wNjeFFAIXKzKBhkZv2ucmncfzVFuigwj
         nXdw==
X-Gm-Message-State: AOAM533csOFJyI4DGcHFbiiMzdsB1Sm2WPhK5AePnBJUFU/Ndj19fpiE
        aRhs5gcXnHU/MsrQpj3CZ9M=
X-Google-Smtp-Source: ABdhPJzCs11i548dmxcQdKR+5d8pp7em8Py5DxbqkP9wIvbdhHIJzJoO9VrIwtdrbGAG6ia6NnYDAQ==
X-Received: by 2002:a17:906:118c:: with SMTP id n12mr47380123eja.167.1609263088702;
        Tue, 29 Dec 2020 09:31:28 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id q25sm37385362eds.85.2020.12.29.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:31:28 -0800 (PST)
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
Subject: [PATCH v4 2/7] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
Date:   Tue, 29 Dec 2020 19:31:17 +0200
Message-Id: <7e15d367eee714c997def0a02383d62845c15c2d.1609258905.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
References: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding for Actions Semi ATC260x PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
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

