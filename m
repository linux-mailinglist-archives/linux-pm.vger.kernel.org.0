Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35B1A3DA9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDJBSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 21:18:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47294 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDJBSu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 21:18:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88AF32006B9;
        Fri, 10 Apr 2020 03:18:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6F47200531;
        Fri, 10 Apr 2020 03:18:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B21B1402B6;
        Fri, 10 Apr 2020 09:18:28 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: thermal: Convert i.MX8MM to json-schema
Date:   Fri, 10 Apr 2020 09:10:44 +0800
Message-Id: <1586481044-19283-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the i.MX8MM thermal binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Add description to mention that i.MX8MM thermal driver supports
	  both i.MX8MM(1 sensor) and i.MX8MP(2 sensors).
	- Remove ./thermal.txt reference.
---
 .../devicetree/bindings/thermal/imx8mm-thermal.txt | 15 ------
 .../bindings/thermal/imx8mm-thermal.yaml           | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
deleted file mode 100644
index 3629d3c..0000000
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
-
-Required properties:
-- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
-- reg : Address range of TMU registers.
-- clocks : TMU's clock source.
-- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
-
-Example:
-tmu: tmu@30260000 {
-	compatible = "fsl,imx8mm-tmu";
-	reg = <0x30260000 0x10000>;
-	clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
-	#thermal-sensor-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
new file mode 100644
index 0000000..71807e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/imx8mm-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8M Mini Thermal Binding
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+description: |
+  i.MX8MM has TMU IP to allow temperature measurement, there are
+  currently two distinct major versions of the IP that is supported
+  by a single driver. The IP versions are named v1 and v2, v1 is
+  for i.MX8MM which has ONLY 1 sensor, v2 is for i.MX8MP which has
+  2 sensors.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8mm-tmu
+              - fsl,imx8mp-tmu
+  reg:
+    description: |
+      Address range of TMU registers.
+    maxItems: 1
+  clocks:
+    description: |
+      TMU's clock source.
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    description: |
+      Number of cells required to uniquely identify the thermal
+      sensors, 0 for ONLY one sensor and 1 for multiple sensors.
+    enum:
+      - 0
+      - 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+
+    tmu: tmu@30260000 {
+         compatible = "fsl,imx8mm-tmu";
+         reg = <0x30260000 0x10000>;
+         clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
+         #thermal-sensor-cells = <0>;
+    };
+
+...
-- 
2.7.4

