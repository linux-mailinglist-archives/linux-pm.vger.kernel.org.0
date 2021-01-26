Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737ED304032
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbhAZN0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 08:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391749AbhAZJ5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 04:57:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD4AC061786;
        Tue, 26 Jan 2021 01:56:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so4295670edb.9;
        Tue, 26 Jan 2021 01:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06PBoT937iPmfRNftqV4radm7GXUsZecDfli3DIAGK0=;
        b=C0ntFk1xOH3aYdDDj+4d4fThcAlydMznRVFIahM3+2agbMray9eFjT8IHk7ExdUyJy
         FiS01OYdPHimY3yj9wwFbBMD5Q8jPug/uZB2X4h7AEfh2MratygQLzf+4c9smEo4oqLS
         iI0DR875AOyDK2wWjJpgn3FENjhJUeH8WqUM8GBE6ZZNf5C9n0PH8qb95lkUFwj9uF+z
         CZ3J2AYWVSNa/rXYkgp9qpwceVikhEqNxnyaiNqhfXlKom7OaVLiJFKZvLEgfEfFQ4fy
         WGt+BP5Bg9OADgrl2o2KS5IeWCb6jteU4kawKCTll8vBf/pm2SezUYQNoWYaiHLUjP31
         Du1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06PBoT937iPmfRNftqV4radm7GXUsZecDfli3DIAGK0=;
        b=aww8q4sn0Sob2sJANi5AYfUKWAw9BowFBaA3VxY2aKyQ0gvNpA6PVnuWzrBC+YXAfE
         x9WlDw0di8yGbVB43A81ePQaOU1/iLj8sugpLaSnPP67bZWQZ9f2Q2C9jRwmnK0vi/+Z
         FtopLYn8sEaRvEqJ13peSLXKAeF5WUvCyB0WxBL8SN7lBpHzgljVmzfWmpT+18JA8AkH
         PFU9Vly1dF2JB1YB9SmSqUXdKA8rGjhIWRlCvP1A0NOZrFyvXmKBJZuyw4v/tZfYfH8+
         ybGv2/rJiwkn9jTvVuPKC8JlWTz7cDfH8d/j3Vwqeoddkn76XYYhnNlQWYK57vdFGI6Z
         cm1A==
X-Gm-Message-State: AOAM5334+ip1u3RlYgsKjzIYZO8nAfFDUeDEZ7i2F3xCOkD1Ufjb+8Jy
        Dn4lnv9jR+BK8dMkiQjYQrI=
X-Google-Smtp-Source: ABdhPJzYfeOiC9T4MBpqLzLV8/76oAIyaZLhmWZ5XYcyeN4Vb0+H9K8YwYfZiI13STEpTDZVZh1dsw==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr3889876edb.117.1611654966863;
        Tue, 26 Jan 2021 01:56:06 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id h12sm11648310edb.16.2021.01.26.01.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:56:06 -0800 (PST)
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
Subject: [PATCH v7 2/5] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
Date:   Tue, 26 Jan 2021 11:55:58 +0200
Message-Id: <43dc8093fa5c5bdf518d5b448459ec3495045a33.1611653995.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding for Actions Semi ATC260x PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
 - None

Changes in v6:
 - None

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

