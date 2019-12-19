Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16821267FC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSR2h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:28:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42986 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSR2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so3637388pfz.9;
        Thu, 19 Dec 2019 09:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3InGdrhpW/KFEKCJevkSkCg0s1j2OL38jx4frb9szs=;
        b=Wsf3R1uMAUach3XE6iWhG1D9/GXB8M5kwET7ibyp1tCrm4L2T1qCT1UPf734SZ8DDU
         10YDrdEqsyY1+tGrGdaKNbz08QM6DUCA1mZCje9ybR70fP9gsK22ESwZlN7pRVm7j4Bk
         L1AnQ7RJBXCX0wxTynFTSpz5eJUAfo/MySgs52o3gmmjaM45btwVVOsN0ngQ1DWn1Hrq
         DaamtOSR6QO5RAaY1mtYALbdAn4HCtZkcHMIzTnc1Gb67JWf50DMjsZIrtYl0Bu3UOAw
         7U3XYtedIpXqAdl1q2vU9O0q08ZEknQ/3FV67pfuUVFVdNRg1X9Nn+rUQT24zNi1dyV9
         Tj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3InGdrhpW/KFEKCJevkSkCg0s1j2OL38jx4frb9szs=;
        b=Nq1TWghvzj1S4JRv8Y8KmIQAz1SuPnP5rUq+HaertUIa65iEFufeCWqJ96+uml96pc
         TpOMqKkI69bx1gtJoJRJVbjnZlvpEZ53IjkouHmuTo62UL56WBEioI9YsX4M6FJ9K0h3
         /Atf3ocTA62y7QGM1DunAadSTfFilC65DByHxOYKVJzgfazuWRQ2wr5kHDIhCuQL0nMW
         W/OdgIf5EmBPRZeCD8fZFACwIvKII0/4As2VqHeYC9BfOw+gXMIatDIH4FxuOnq+YCmN
         PlmKm0na8ZF2mcjUKB2UnLM3kCsDZpoBeZGE1IqvxE1qwPZhbDwLaSiJPvyGMlxFFCzn
         ohwQ==
X-Gm-Message-State: APjAAAWFWTaWjzrSHoDMipiZ4prcgxbcY1rKR2emG61Zbks53+Etb7ZY
        kqGc/SxFqm5rXE48/koz6M8=
X-Google-Smtp-Source: APXvYqzwDCblQ9076CWYrCAih5FSrXhjVCXbFNvklN6EzJLQsKc5svJnBA87rZmDJlPqP80g6g/zSw==
X-Received: by 2002:a62:446:: with SMTP id 67mr10455562pfe.109.1576776515822;
        Thu, 19 Dec 2019 09:28:35 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:34 -0800 (PST)
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
Subject: [PATCH v8 2/7] dt-bindings: thermal: add YAML schema for sun8i-thermal driver bindings
Date:   Thu, 19 Dec 2019 09:28:18 -0800
Message-Id: <20191219172823.1652600-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
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
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
new file mode 100644
index 000000000000..87369264feb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SUN8I Thermal Controller Device Tree Bindings
+
+maintainers:
+  - Vasily Khoruzhick <anarsoul@gmail.com>
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
+  clocks:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: bus
+      - const: mod
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
+  # See ./thermal.txt for details
+  "#thermal-sensor-cells":
+    enum:
+      - 0
+      - 1
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
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+    else:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          minItems: 2
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
+additionalProperties: false
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

