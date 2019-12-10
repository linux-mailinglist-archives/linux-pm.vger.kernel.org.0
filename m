Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809951187A4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLJMIP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 07:08:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34812 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJMIP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 07:08:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so1980804pln.1;
        Tue, 10 Dec 2019 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l5uHiV+Yi1b/Weaw8ObG18hI7s+mQL2W7TckPvD0Lmw=;
        b=i4Vp1W98Nl1Bui3BDaWfwjqHavE+84yuA5Oq/NNngoDymHqy40lpX0wJWRF15laQ3H
         RK8TOdxrCq4G/QeARICf2XgwZof7eTk1qmGv7X9T40sSWaDdIYBFm60zecRsPFFbXCKT
         +hNlW/WYxHPKhZFf+N3HsnpbTlkrLmQ8DpTB9b2Aa+VGMvCvvr+B7kNBkx17bmB8nYtx
         7tmApRoh8ZzY8VIiDzw6wyJOfFVCYELv6VeMJwjrHPNe2hiMgUfoNRAV18a/Y86mIuUF
         xQust9GBGsSVyXNjUqu0yU0aB6E8D+XaNme3V++1hR5w2Ipz0qRLJZPF7fVnFZpqMWxp
         xU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l5uHiV+Yi1b/Weaw8ObG18hI7s+mQL2W7TckPvD0Lmw=;
        b=KYJygE0nYzym2qy9Z9jLEYLFwFZi1LVdApKq6bWNmp3xwsb8ALoeguEogc0qd7FHTq
         ZkNe+GPA0UkhRSIf9bsDK6zWc0kqw1W6R/oP5v/hKLUqxJq+yPGA5dwmpMOOQPadZiUh
         lROd9dxcAFRlwt8vmz+YkdVUiwGMVcl0YA8/2FD/CHTDEYNcxv25UjuTIqRw8gEE5PTw
         SiQc9eKFmPMGKc46iIT0smKZMnh+4Kmj2J5B0Gu6W+AnJhXFoNdh2bAaChzhXa74KKUU
         nuvvPmu7qh8rjG3UGGsXeRVbhXF1csvpoxDLAMe9/Gx3MeOpgm0lQG9ueG+odT4Nkd3d
         F7gA==
X-Gm-Message-State: APjAAAUPKNu6+Shm7Wmc3J8+ZLmF/lHUVJKU26fm7WLd2jG2IYJAX82+
        +mkLf2pHB9LqTkoga3G2brM=
X-Google-Smtp-Source: APXvYqzMbUr5xi4SJjUYbbZL+R0wEZ6fVbQcFoDtmRRcltk45AuEjKcpMO2nVrmYiwGmXZkR4VhLGg==
X-Received: by 2002:a17:90a:8903:: with SMTP id u3mr4968272pjn.137.1575979694925;
        Tue, 10 Dec 2019 04:08:14 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r193sm3440295pfr.100.2019.12.10.04.08.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 04:08:13 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, freeman.liu@unisoc.com,
        zhang.lyra@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum thermal documentation
Date:   Tue, 10 Dec 2019 20:07:17 +0800
Message-Id: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
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
Changes from v1:
 - Change to yaml format.
---
 .../devicetree/bindings/thermal/sprd-thermal.yaml  |   97 ++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
new file mode 100644
index 0000000..92d208a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
@@ -0,0 +1,97 @@
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
+  nvmem-cells-names:
+    maxItems: 2
+    items:
+      - const: thm_sign_cal
+      - const: thm_ratio_cal
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  child-node:
+    description: Represent one thermal sensor.
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
+      nvmem-cells-names:
+        maxItems: 1
+        items:
+          - const: sen_delta_cal
+
+    required:
+      - reg
+      - nvmem-cells
+      - nvmem-cells-names
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - nvmem-cells
+  - nvmem-cells-names
+  - "#thermal-sensor-cells"
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
+
+                prometheus0-sensor@0 {
+                        reg = <0>;
+                        nvmem-cells = <&thm0_sen0>;
+                        nvmem-cell-names = "sen_delta_cal";
+                };
+
+                ank1-sensor@1 {
+                        reg = <1>;
+                        nvmem-cells = <&thm0_sen1>;
+                        nvmem-cell-names = "sen_delta_cal";
+                };
+        };
+...
-- 
1.7.9.5

