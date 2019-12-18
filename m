Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B588D123E68
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 05:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLREVb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 23:21:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42278 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfLREVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 23:21:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so517814pgb.9;
        Tue, 17 Dec 2019 20:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npMj8u0di2OyfuNH4N410BtqEfh3bSH+Sq8lHYLRu2k=;
        b=skg64jTGQE65DyJCxi2WOtP+F0BF5VHFh+63lrWjnx7Brr/Vc7ngnKiSOO+K4XzV38
         0yWoM9kV/DpWAkDz4n9JnjPlLI74pUM2hPIM5Lj/p4pk8m/kVq/I4vVgqwVSD21VYB8n
         MobspSYphaSUsfLjq5CPhZd4vU/Pz0keFwyC2lupfa4vRruX4gUeSKPYAywecGj21BBQ
         r9ytK0Zk7w/S0ixBlGeg1Cqy5HY2ieQ4zLp2VYx3V5YuHzmVjTSMNw+T+p6oYOdTz1gu
         QVpTHwgI2lYIY6qc2bbd0PdyYG3MdisTBiAIxL8VqE8lW9OnJEZABkJt1fRZONB/pfuf
         T6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npMj8u0di2OyfuNH4N410BtqEfh3bSH+Sq8lHYLRu2k=;
        b=e5IcM28dlR/W/bl6zeouzfjZgLb8/g97QkQ8j3n47PI2eDc3SeePqKrrzI/8XLv50K
         /fHS/C+JAO8uZRkJ2RSo0AI+1cBBdpIxFrjBgQPEo06Gfm6gZkZqIJrX/MV7zMksNhi5
         Ta19ueAIldfhYqsU9664iyC/79LxwfVim5qaOLxmpDupN16ABt1j/6CaZihrCxCUP265
         SQZcvTd1gS2FBZrK4A2hyDbP+wCn4hHE48xsAFSNjUzyYRjQdG5jBk49EsjaZtX7UCuB
         QVgRj8836WjOPx0UN9B94Z3sVJB4bTb67xERkP3M5UWZNx6eWLdylQ+H1ZXD8hnYJM/p
         psFA==
X-Gm-Message-State: APjAAAXb/7ive8mpLWeLvPbPxXNEQOdjoH9Q/QDMUJT0S9yTO14swYao
        0njFGfMPG+aP4IJT4rDakh4=
X-Google-Smtp-Source: APXvYqzjRDLlV/nbrbOH2SEKHrMXnWg6SzAeK6/M5hYnY3GEoJvrWwu0E3JCNUUPG5fx7QApjbt4og==
X-Received: by 2002:a63:5809:: with SMTP id m9mr631607pgb.26.1576642889749;
        Tue, 17 Dec 2019 20:21:29 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:29 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v7 2/7] dt-bindings: thermal: add YAML schema for sun8i-thermal driver bindings
Date:   Tue, 17 Dec 2019 20:21:16 -0800
Message-Id: <20191218042121.1471954-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218042121.1471954-1-anarsoul@gmail.com>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

sun8i-thermal driver supports thermal sensor in wide range of Allwinner
SoCs. Add YAML schema for its bindings.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
new file mode 100644
index 000000000000..8768c2450633
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SUN8I Thermal Controller Device Tree Bindings
+
+maintainers:
+  - Yangtao Li <tiny.windzz@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun8i-a83t-ths
+      - allwinner,sun8i-h3-ths
+      - allwinner,sun8i-r40-ths
+      - allwinner,sun50i-a64-ths
+      - allwinner,sun50i-h5-ths
+      - allwinner,sun50i-h6-ths
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 1
+    description: Calibration data for thermal sensors
+
+  nvmem-cell-names:
+    const: calibration
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-ths
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+
+        clock-names:
+          minItems: 1
+          maxItems: 1
+          items:
+            - const: bus
+
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+
+        clock-names:
+          minItems: 1
+          maxItems: 2
+          items:
+            - const: bus
+            - const: mod
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun8i-h3-ths
+
+    then:
+      properties:
+        "#thermal-sensor-cells":
+          const: 0
+
+    else:
+      properties:
+        "#thermal-sensor-cells":
+          const: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - const: allwinner,sun8i-h3-ths
+              - const: allwinner,sun8i-r40-ths
+              - const: allwinner,sun50i-a64-ths
+              - const: allwinner,sun50i-h5-ths
+              - const: allwinner,sun50i-h6-ths
+
+    then:
+      required:
+        - clocks
+        - clock-names
+        - resets
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+examples:
+  - |
+    thermal-sensor@1f04000 {
+         compatible = "allwinner,sun8i-a83t-ths";
+         reg = <0x01f04000 0x100>;
+         interrupts = <0 31 0>;
+         nvmem-cells = <&ths_calibration>;
+         nvmem-cell-names = "calibration";
+         #thermal-sensor-cells = <1>;
+    };
+
+  - |
+    thermal-sensor@1c25000 {
+         compatible = "allwinner,sun8i-h3-ths";
+         reg = <0x01c25000 0x400>;
+         clocks = <&ccu 0>, <&ccu 1>;
+         clock-names = "bus", "mod";
+         resets = <&ccu 2>;
+         interrupts = <0 31 0>;
+         nvmem-cells = <&ths_calibration>;
+         nvmem-cell-names = "calibration";
+         #thermal-sensor-cells = <0>;
+    };
+
+  - |
+    thermal-sensor@5070400 {
+         compatible = "allwinner,sun50i-h6-ths";
+         reg = <0x05070400 0x100>;
+         clocks = <&ccu 0>;
+         clock-names = "bus";
+         resets = <&ccu 2>;
+         interrupts = <0 15 0>;
+         nvmem-cells = <&ths_calibration>;
+         nvmem-cell-names = "calibration";
+         #thermal-sensor-cells = <1>;
+    };
+
+...
-- 
2.24.1

