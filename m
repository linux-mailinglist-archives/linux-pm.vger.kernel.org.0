Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AE1F0BFD
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFGOpV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFGOpU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A6C08C5C3;
        Sun,  7 Jun 2020 07:45:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so17282773lji.10;
        Sun, 07 Jun 2020 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ke1Nk6rN9w+vzVhHvqubAjAEPlQYN8nHibugQnM0Ib4=;
        b=CQlv8AtvDQXs/6SB51nCxr6V5fN3KyVllmhXO698ZSNy/DSddiiGG1WthUe4EzSLYe
         rkmN8yU0XM2KaF9lzzbhjvfAf5iID0MOkVpascNgMYwZAK1ucotb7KLhMLqxNoOhkqQX
         U8A+5AvD1czJm9H9JhadSPxsY5qIz0B0pZao9zHmwxcukLO+gg3qVMJZ1hbIfLunUBPx
         MU4RGAn6IKqjv4c7j4YPLBVw5N7LRotzuTt4mie1gTQWjWGaVfvMEGwQ7RSFZZV1x724
         gnPwx3XK2C1p+PgOXZDpLhvKTvNQMZNKAeEf7pfH7QnahcKfXWSVVJ6sX3FM+mMrXxBR
         IjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ke1Nk6rN9w+vzVhHvqubAjAEPlQYN8nHibugQnM0Ib4=;
        b=GIQEz4tK2SwAdw8siXpUQ/fqqo42dWu7hGVJcaf1tvFE9UP+5AZz9qRSxZeMANLgKj
         xneidEmsRxM/8hV5a0AFiMg7h+1gWMLbH87j2uaGSd8Lynu4uBK7Mc03nW+HaFcxtY/s
         fk5BNox2FNzarJZoT+3Nn44XeIX2/J2ezVTEQ99IGQKKa4GNcC/Enb3YGAknxgsTtSah
         CCIFqzXxfBcyG2Q5nedJ7qIQm6qf/crtos9PsuPL6fHZUWB0gElTTVjLvv78BtRhaaTP
         iOUsUnhPuV3qmktB8UE22lUpB48dXVVjYZwC1mzGdtvXuKILZIbxKPKhQQfekScAy+FY
         9DFg==
X-Gm-Message-State: AOAM533BNC2GAQ6SLHFqRcaeZ39Fhe85x5692f6fQmNRu8pYGtGsY8vZ
        z+EVvB+szk+N9AUZT7nbRJE=
X-Google-Smtp-Source: ABdhPJyQY9d/3iBO0r2PJwjKyp3gglJQ/42UJDdh5rA8aZeT1NvcyHbWknOIaaBwIRj4X7ESjaa6cw==
X-Received: by 2002:a2e:2e0b:: with SMTP id u11mr9167840lju.281.1591541117449;
        Sun, 07 Jun 2020 07:45:17 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 1/9] dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
Date:   Sun,  7 Jun 2020 17:41:05 +0300
Message-Id: <20200607144113.10202-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
This patch adds device-tree binding for Summit SMB345, SMB347 and SMB358
chargers.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../power/supply/summit,smb347-charger.yaml   | 165 ++++++++++++++++++
 .../dt-bindings/power/summit,smb347-charger.h |  19 ++
 2 files changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
new file mode 100644
index 000000000000..eea0a6398c95
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -0,0 +1,165 @@
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
+  - Dmitry Osipenko <digetx@gmail.com>
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
+  monitored-battery:
+    description: phandle to the battery node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  summit,enable-usb-charging:
+    type: boolean
+    description: Enable charging through USB.
+
+  summit,enable-otg-charging:
+    type: boolean
+    description: Provide power for USB OTG
+
+  summit,enable-mains-charging:
+    type: boolean
+    description: Enable charging through mains
+
+  summit,enable-charge-control:
+    description: Enable charging control
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum:
+          - 0 # SMB3XX_CHG_ENABLE_SW SW (I2C interface)
+          - 1 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW Pin control (Active Low)
+          - 2 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH Pin control (Active High)
+
+  summit,fast-voltage-threshold-microvolt:
+    description: Voltage threshold to transit to fast charge mode (in uV)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2400000
+    maximum: 3000000
+
+  summit,mains-current-limit-microamp:
+    description: Maximum input current from AC/DC input (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,usb-current-limit-microamp:
+    description: Maximum input current from USB input (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,charge-current-compensation-microamp:
+    description: Charge current compensation (in uA)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  summit,chip-temperature-threshold-celsius:
+    description: Chip temperature for thermal regulation in °C.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [100, 110, 120, 130]
+
+  summit,soft-compensation-method:
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
+        summit,mains-current-limit-microamp:
+          enum: [ 300000,  500000,  700000, 1000000,
+                 1500000, 1800000, 2000000]
+
+        summit,usb-current-limit-microamp:
+          enum: [ 300000,  500000,  700000, 1000000,
+                 1500000, 1800000, 2000000]
+
+        summit,charge-current-compensation-microamp:
+          enum: [200000, 450000, 600000, 900000]
+
+    else:
+      properties:
+        summit,mains-current-limit-microamp:
+          enum: [ 300000,  500000,  700000,  900000, 1200000,
+                 1500000, 1800000, 2000000, 2200000, 2500000]
+
+        summit,usb-current-limit-microamp:
+          enum: [ 300000,  500000,  700000,  900000, 1200000,
+                 1500000, 1800000, 2000000, 2200000, 2500000]
+
+        summit,charge-current-compensation-microamp:
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
+            summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
+            summit,chip-temperature-threshold-celsius = <110>;
+            summit,mains-current-limit-microamp = <2000000>;
+            summit,usb-current-limit-microamp = <500000>;
+            summit,enable-usb-charging;
+            summit,enable-mains-charging;
+
+            monitored-battery = <&battery>;
+        };
+    };
+
+    battery: battery-cell {
+        compatible = "simple-battery";
+        constant-charge-current-max-microamp = <1800000>;
+        temperature-min-alert-celsius = <5>;
+        temperature-max-alert-celsius = <40>;
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
2.26.0

