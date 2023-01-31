Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6946682EC1
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 15:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjAaOE5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 09:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjAaOEo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 09:04:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA965A2
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 06:04:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so14277727wrz.12
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 06:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22OuGl1Rl5k/omloIRKBcTeCPAl/PTnUyUtJ/lKNdiM=;
        b=if/PCWHwByy4LBuPHrr9Kzs1K4sedSNOpWUedCcfI3eoKRddTZm7EWjEuc5LqcmjBn
         lvCsVQvpr6idngYZ0gqKrzcWPPrv/DzbYKkUqgDpWR8cSXCYTA34CfZInXIoGI3TaV9s
         ShwAOkL30yfCyIUp/LcSq0yK7r/mSlsX/4wotibK9TgekBfqEHcQY6VHb9V6wTC9btbl
         AU4Q13gbVmsj4NIYBjxVDFWXQ+TqJu1q6Eaj2CuBgj1GNyHfIyiHqvzR0f1jLm53RzCU
         BSmvRxdOOPBnRX2N60lq8g46hvLR7qzkNZmxuZgXERjDMiIfxM7+4owadOWJWHoeBFfV
         7WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22OuGl1Rl5k/omloIRKBcTeCPAl/PTnUyUtJ/lKNdiM=;
        b=6k5OsiBWuFu8WLd4Ul5p0H5rSHZWwTxq3H+IjwRgHqONJt6bfrPow4o7gqNFb73DEA
         ow3BaHAPVjA/SYf6HvMPM4mgUtoe2/aJETg54sUWLdjkLMFPcPNTEuDJBM3eZcJN3jf4
         jPsKb+/e6BzixCH+nOD2QEy6L1qtj9xsR4vXyd8GZUoQsyrhkL0qk8AzZFgU62v+FU+l
         auZtJq8aEtFhweb0URKZ1KHN+ltXbUwjg/UHPtyjYguGVJjUUFJc1F+cKD5Ah8KIIWkh
         1/nYi5vEGhM0PbXYO3B4agaWTXjHhVYBhhQNq9qEb8FGrdOJosmYGajpBjWNvkNddGuf
         DTqg==
X-Gm-Message-State: AO0yUKWCkalhnpA76qV3ao3wXP0mwPGIhqeXt+Z5n1gBkBTDvYAR2Tc2
        SISiysTQZ4VcniyouKA6g13uSw==
X-Google-Smtp-Source: AK7set+5o21SMWNGyITnSJ6WfocSug+a1HYqAQ+171bk74m6Z8XUUaom0+C7HcRgU/XweK6pBB9Hyw==
X-Received: by 2002:a5d:658d:0:b0:2bf:ae43:108d with SMTP id q13-20020a5d658d000000b002bfae43108dmr25647204wru.28.1675173881683;
        Tue, 31 Jan 2023 06:04:41 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d6d8f000000b002bfb37497a8sm15760650wrs.31.2023.01.31.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:04:41 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v3] dt-bindings: thermal: mediatek: Add LVTS thermal controllers
Date:   Tue, 31 Jan 2023 15:04:39 +0100
Message-Id: <20230131140439.600164-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126161048.94089-1-bchihi@baylibre.com>
References: <20230126161048.94089-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS thermal controllers dt-binding definition for mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
Changelog:
  v3:
     - Fixed subject prefix
     - Fixed licenses GPL-2.0-only OR BSD-2-Clause
       to GPL-2.0 OR MIT (to match DT)
     - Fixed matching dt-binding file names
  v2:
     - Fixed subject prefix
     - Fixed licenses GPL-2.0+ to GPL-2.0
     - Added dual licenses
---
---
 .../thermal/mediatek,lvts-thermal.yaml        | 107 ++++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           |  19 ++++
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
new file mode 100644
index 000000000000..5fa5c7a1a417
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
+
+maintainers:
+  - Balsam CHIHI <bchihi@baylibre.com>
+
+description: |
+  LVTS is a thermal management architecture composed of three subsystems,
+  a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
+  a Converter - Low Voltage Thermal Sensor converter (LVTS), and
+  a Digital controller (LVTS_CTRL).
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-lvts-ap
+      - mediatek,mt8195-lvts-mcu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+    description: LVTS reset for clearing temporary data on AP/MCU.
+
+  nvmem-cells:
+    minItems: 1
+    items:
+      - description: Calibration eFuse data 1 for LVTS
+      - description: Calibration eFuse data 2 for LVTS
+
+  nvmem-cell-names:
+    minItems: 1
+    items:
+      - const: lvts-calib-data-1
+      - const: lvts-calib-data-2
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - nvmem-cells
+  - nvmem-cell-names
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/reset/mt8195-resets.h>
+    #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      lvts_mcu: thermal-sensor@11278000 {
+        compatible = "mediatek,mt8195-lvts-mcu";
+        reg = <0 0x11278000 0 0x1000>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+        resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+        nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+        #thermal-sensor-cells = <1>;
+      };
+    };
+
+    thermal_zones: thermal-zones {
+      cpu0-thermal {
+        polling-delay = <1000>;
+        polling-delay-passive = <250>;
+        thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+
+        trips {
+          cpu0_alert: trip-alert {
+            temperature = <85000>;
+            hysteresis = <2000>;
+            type = "passive";
+          };
+
+          cpu0_crit: trip-crit {
+            temperature = <100000>;
+            hysteresis = <2000>;
+            type = "critical";
+          };
+        };
+      };
+    };
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
new file mode 100644
index 000000000000..ca1ef29a8fee
--- /dev/null
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Balsam CHIHI <bchihi@baylibre.com>
+ */
+
+#ifndef __MEDIATEK_LVTS_DT_H
+#define __MEDIATEK_LVTS_DT_H
+
+#define MT8195_MCU_BIG_CPU0		0
+#define MT8195_MCU_BIG_CPU1		1
+#define MT8195_MCU_BIG_CPU2		2
+#define MT8195_MCU_BIG_CPU3		3
+#define MT8195_MCU_LITTLE_CPU0	4
+#define MT8195_MCU_LITTLE_CPU1	5
+#define MT8195_MCU_LITTLE_CPU2	6
+#define MT8195_MCU_LITTLE_CPU3	7
+
+#endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.34.1

