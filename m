Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5172581492
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGZNzY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiGZNzV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 09:55:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6C7666
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 06:55:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h9so20306026wrm.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UyB6UT6ks0HkEwyd3qTKWT7a722IA4Qy0x6ECfS6JA=;
        b=fnElU9WVkp/hVhjv7YThd5aslfssg97RW5Tc1Htc8AR/9ztHH0xlHj+E1ANhlATIin
         NpCigtCYkQPtAt4+998IITLVdULV+9ilkjQuyB4FpACY69+gQUDL+lk1KY0Hz5J08+/i
         EGLxVbqfCUgGEZPemzqKYJrQnXKYjSqzX/IaA+l5DSyONvBo9iMEgdrUP0hv7aEMNuDp
         gNkUWDOt0MNHSQhzapmSD0z5p3VdS+nnLAnMW3FEz8Qz/DmsCYXtwjCYZHOSKeYn2RXg
         G7rHqkqafxEz0fBrB5x8+lUwJTD54xUirg6le322OaUZyQoPvPGiucsZPUp1b2luQ2DN
         +MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UyB6UT6ks0HkEwyd3qTKWT7a722IA4Qy0x6ECfS6JA=;
        b=bsGXYUibMKa+z9RXk7f7nUiRVIVA13R/SkwXfZcbHdLfN14Gu0prQi7CRoIn2UlxkK
         h4gdxkkSUcanqeGuInKrkFHDYXEczOah9V2TG1RtykkdkzGaxZ77hJ52x3YNxj4ESmSM
         C0ul5oNhEq0u4cI+mFoWzg5kzMXpHi5B/v9XCzwvcqj6IcC9JVLZRenN3v6Wnf8NdicG
         X7LP+dZTguq1PApravHr45xEMIvv9RwcPEjEbAjeF5sC2bje0FuxLP16l4RSaKXzB8cK
         0vbYfa36py7rG2gGlRTQr8rwycGXrkV5Up88ckJ7wEeytBM8cUK1qJriTssxtuKsMNpv
         NLbA==
X-Gm-Message-State: AJIora9Kp/Bbx/pIsB02cQYq9o2+FnKQpjH7iwxTfw+Eyt5O1C7LtrcY
        vvQiPLIswZpaZFuhszl37uYOMw==
X-Google-Smtp-Source: AGRyM1tNOSDyHTzrF4a7MTg/xELPN/dHSfVWdPLkjj7I/TNbUJeJJG9NgzCR6U44gB8fwRp4KDsO2A==
X-Received: by 2002:adf:f492:0:b0:21d:89d5:9443 with SMTP id l18-20020adff492000000b0021d89d59443mr10608607wro.201.1658843718871;
        Tue, 26 Jul 2022 06:55:18 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020adf9c8d000000b0021e4c3b2967sm15244670wre.65.2022.07.26.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:55:18 -0700 (PDT)
From:   Balsam CHIHI <bchihi@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for LVTS thermal controllers
Date:   Tue, 26 Jul 2022 15:55:02 +0200
Message-Id: <20220726135506.485108-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726135506.485108-1-bchihi@baylibre.com>
References: <20220726135506.485108-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
 .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
new file mode 100644
index 000000000000..8c5a02eb97c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,mt8192-lvts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC LVTS thermal controller
+
+maintainers:
+  - Yu-Chia Chang <ethan.chang@mediatek.com>
+  - Ben Tseng <ben.tseng@mediatek.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8192-lvts-ap
+      - mediatek,mt8192-lvts-mcu
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: SW reset HW AP/MCU domain for clean temporary data when HW initialization and resume.
+
+  nvmem-cells:
+    items:
+      - description: LVTS calibration data for thermal sensors
+
+  nvmem-cell-names:
+    items:
+      - const: lvts_calib_data
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
+    #include <dt-bindings/reset/mt8192-resets.h>
+
+      lvtsmcu: thermal-sensor@11278000 {
+        compatible = "mediatek,mt8192-lvts-mcu";
+        #thermal-sensor-cells = <1>;
+        reg = <0 0x11278000 0 0x400>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg_ao CLK_INFRA_THERM>;
+        resets = <&infracfg_ao MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_efuse_data>;
+        nvmem-cell-names = "lvts_calib_data";
+      };
+
+...
diff --git a/Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
new file mode 100644
index 000000000000..6b0b53a33272
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,mt8195-lvts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC LVTS thermal controller
+
+maintainers:
+  - Yu-Chia Chang <ethan.chang@mediatek.com>
+  - Ben Tseng <ben.tseng@mediatek.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-lvts-ap
+      - mediatek,mt8195-lvts-mcu
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: SW reset HW AP/MCU domain for clean temporary data when HW initialization and resume.
+
+  nvmem-cells:
+    items:
+      - description: LVTS calibration data 1 for thermal sensors
+      - description: LVTS calibration data 2 for thermal sensors
+
+  nvmem-cell-names:
+    items:
+      - const: lvts_calib_data1
+      - const: lvts_calib_data2
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/reset/mt8195-resets.h>
+
+      lvtsmcu: thermal-sensor@11278000 {
+        compatible = "mediatek,mt8195-lvts-mcu";
+        #thermal-sensor-cells = <1>;
+        reg = <0 0x11278000 0 0x400>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+        resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+        nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
+      };
+
+...
-- 
2.34.1

