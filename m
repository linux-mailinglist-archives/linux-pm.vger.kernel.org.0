Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE912162218
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 09:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRILe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 03:11:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42693 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgBRILe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 03:11:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so7761065plt.9;
        Tue, 18 Feb 2020 00:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QUPlxwKLP9HDsSXAYmsXVJM5TniLPju/R6y5R75AffU=;
        b=mtwB5luAFOm5K7gzOCix+RXz1ZERgI7b1W1WEWuYrq6mbh15n2JrrS4LFvK3xJER91
         BOZ0jFtv6kfg8fuIFHhvbjdG8G4bj8Se/XQPjSXtsOtUMOHyCW3rTb+Xvwh4uzYyVWIZ
         NwuWwPTDDjre/6kpTtMMDln0D02xnLEX8Zfs+d5d85KHgQAqCt1pkjLGVADXLT07V9Qw
         FUP4lS6vtT3VEGGda7R2nCJFr8x6DPkpl+a6bnrZ6tvJ2MkCUfnSwI/Y62K+C/vaeI1w
         mz9S0gIqDJCZRdedJS/ifw3g4r5LlOxzWWkDjNFdRfkGs0fNLB5Pxd3n52ODSiuRhmyO
         KF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QUPlxwKLP9HDsSXAYmsXVJM5TniLPju/R6y5R75AffU=;
        b=LjG5NPXcwztz/AudPo7+/W6sZiucA2upysBF4N3Rlibvyit7XLWIfSy5ZBI2kVDkol
         Cqk2Fc5l3tx+RDob0GwGTogW+gfulCc9pWgEWprpbt1Ef0RHQDWxYpjbnk7Y1GLm/rEM
         Vw7sfiXpvDEAxsIUk1oAcy1d25xyOZ8KTMO740LqOXbh/h8rB9LGKKjSQHH5R5Vzeib8
         14zJTaee0+U+zyQuZrjJ+OPHtxEWZkR2Sa9QbjyHxM2VhWOLPrDz0TD65gYsB3BxdWlw
         5N6DUaFWdW3yjMSno945sP61WhxMwHQD3lM+Xu+DrNO/J/+TkSu+dVoQVcp1iIpRojFk
         g6TQ==
X-Gm-Message-State: APjAAAV2Feie+d8053dsOtS3tyP6W7rEF/eMLVdRmZ6LTTwP+f63C5iP
        utXQwDqefeJhLczZboPDvXA=
X-Google-Smtp-Source: APXvYqz08UVvt9qDdWZuY7F9gk+8Up46fj2HHouxwZvVQcLav7iIEXePwSxmGfND/ZUTir9U1ie6Nw==
X-Received: by 2002:a17:902:348:: with SMTP id 66mr19695770pld.137.1582013492909;
        Tue, 18 Feb 2020 00:11:32 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z27sm3083411pfj.107.2020.02.18.00.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 00:11:32 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com,
        freeman.liu@unisoc.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum thermal documentation
Date:   Tue, 18 Feb 2020 16:10:27 +0800
Message-Id: <444e45ce0a9b390b2502dfcefd1ddb36948fa8e1.1582013101.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Baolin Wang <baolin.wang@unisoc.com>

Add the Spreadtrum thermal documentation.

Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v2:
 - Add missing #address-cells and #size-cells properties.
 - Change the child node name with patternProperties.
 - Simplify the nvmem-cells-names property.

Changes from v1:
 - Change to yaml format.
---
 .../devicetree/bindings/thermal/sprd-thermal.yaml  |  108 ++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
new file mode 100644
index 0000000..3bfe055
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sprd-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum thermal sensor controller bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,ums512-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: enable
+
+  nvmem-cells:
+    maxItems: 2
+    description:
+      Reference to nvmem nodes for the calibration data.
+
+  nvmem-cell-names:
+    maxItems: 2
+    items:
+      - const: thm_sign_cal
+      - const: thm_ratio_cal
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        description: Specify the sensor id.
+        maxItems: 1
+
+      nvmem-cells:
+        maxItems: 1
+        description:
+          Reference to an nvmem node for the calibration data.
+
+      nvmem-cell-names:
+        const: sen_delta_cal
+
+    required:
+      - reg
+      - nvmem-cells
+      - nvmem-cell-names
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - nvmem-cells
+  - nvmem-cell-names
+  - "#thermal-sensor-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+        ap_thm0: thermal@32200000 {
+                compatible = "sprd,ums512-thermal";
+                reg = <0 0x32200000 0 0x10000>;
+                clock-names = "enable";
+                clocks = <&aonapb_gate 32>;
+                #thermal-sensor-cells = <1>;
+                nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
+                nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                prometheus-sensor@0 {
+                        reg = <0>;
+                        nvmem-cells = <&thm0_sen0>;
+                        nvmem-cell-names = "sen_delta_cal";
+                };
+
+                ank-sensor@1 {
+                        reg = <1>;
+                        nvmem-cells = <&thm0_sen1>;
+                        nvmem-cell-names = "sen_delta_cal";
+                };
+        };
+...
-- 
1.7.9.5

