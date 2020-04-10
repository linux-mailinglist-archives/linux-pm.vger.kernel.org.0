Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8831A3DA4
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 03:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJBQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 21:16:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35662 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDJBQe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 21:16:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 52B6B1A19C8;
        Fri, 10 Apr 2020 03:16:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1BE61A1A19;
        Fri, 10 Apr 2020 03:15:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A4894402D5;
        Fri, 10 Apr 2020 09:15:08 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
Date:   Fri, 10 Apr 2020 09:07:24 +0800
Message-Id: <1586480844-19227-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the i.MX thermal binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- make clock property optional.
---
 .../devicetree/bindings/thermal/imx-thermal.txt    | 61 --------------
 .../devicetree/bindings/thermal/imx-thermal.yaml   | 96 ++++++++++++++++++++++
 2 files changed, 96 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
deleted file mode 100644
index 823e417..0000000
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
-
-Required properties:
-- compatible : must be one of following:
-  - "fsl,imx6q-tempmon" for i.MX6Q,
-  - "fsl,imx6sx-tempmon" for i.MX6SX,
-  - "fsl,imx7d-tempmon" for i.MX7S/D.
-- interrupts : the interrupt output of the controller:
-  i.MX6Q has one IRQ which will be triggered when temperature is higher than high threshold,
-  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
-  when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
-  is higher than panic threshold, system will auto reboot by SRC module.
-- fsl,tempmon : phandle pointer to system controller that contains TEMPMON
-  control registers, e.g. ANATOP on imx6q.
-- nvmem-cells: A phandle to the calibration cells provided by ocotp.
-- nvmem-cell-names: Should be "calib", "temp_grade".
-
-Deprecated properties:
-- fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
-  calibration data, e.g. OCOTP on imx6q.  The details about calibration data
-  can be found in SoC Reference Manual.
-
-Direct access to OCOTP via fsl,tempmon-data is incorrect on some newer chips
-because it does not handle OCOTP clock requirements.
-
-Optional properties:
-- clocks : thermal sensor's clock source.
-
-Example:
-ocotp: ocotp@21bc000 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "fsl,imx6sx-ocotp", "syscon";
-	reg = <0x021bc000 0x4000>;
-	clocks = <&clks IMX6SX_CLK_OCOTP>;
-
-	tempmon_calib: calib@38 {
-		reg = <0x38 4>;
-	};
-
-	tempmon_temp_grade: temp-grade@20 {
-		reg = <0x20 4>;
-	};
-};
-
-tempmon: tempmon {
-	compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
-	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-	fsl,tempmon = <&anatop>;
-	nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-	nvmem-cell-names = "calib", "temp_grade";
-	clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
-};
-
-Legacy method (Deprecated):
-tempmon {
-	compatible = "fsl,imx6q-tempmon";
-	fsl,tempmon = <&anatop>;
-	fsl,tempmon-data = <&ocotp>;
-	clocks = <&clks 172>;
-};
diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
new file mode 100644
index 0000000..193c7e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/imx-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Thermal Binding
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6q-tempmon
+              - fsl,imx6sx-tempmon
+              - fsl,imx7d-tempmon
+
+  interrupts:
+    description: |
+      The interrupt output of the controller, the IRQ will be triggered
+      when temperature is higher than high threshold.
+    maxItems: 1
+
+  nvmem-cells:
+    description: |
+      Phandle to the calibration cells provided by ocotp for calibration
+      data and temperature grade.
+    maxItems: 2
+
+  nvmem-cell-names:
+    maxItems: 2
+    items:
+      - const: calib
+      - const: temp_grade
+
+  fsl,tempmon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Phandle pointer to system controller that contains TEMPMON control
+      registers, e.g. ANATOP on imx6q.
+
+  fsl,tempmon-data:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Deprecated property, phandle pointer to fuse controller that contains
+      TEMPMON calibration data, e.g. OCOTP on imx6q. The details about
+      calibration data can be found in SoC Reference Manual.
+
+  clocks:
+    description: |
+      Thermal sensor's clock source, it is optional.
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - fsl,tempmon
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ocotp: ocotp@21bc000 {
+         #address-cells = <1>;
+         #size-cells = <1>;
+         compatible = "fsl,imx6sx-ocotp", "syscon";
+         reg = <0x021bc000 0x4000>;
+         clocks = <&clks IMX6SX_CLK_OCOTP>;
+
+         tempmon_calib: calib@38 {
+             reg = <0x38 4>;
+         };
+
+         tempmon_temp_grade: temp-grade@20 {
+             reg = <0x20 4>;
+         };
+    };
+
+    tempmon: tempmon {
+         compatible = "fsl,imx6sx-tempmon";
+         interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+         fsl,tempmon = <&anatop>;
+         nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+         nvmem-cell-names = "calib", "temp_grade";
+         clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+    };
+
+...
-- 
2.7.4

