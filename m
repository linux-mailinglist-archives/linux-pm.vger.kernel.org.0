Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928861EB308
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFBBdL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 21:33:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52934 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgFBBdJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 21:33:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9001F2008B2;
        Tue,  2 Jun 2020 03:33:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA2652008A7;
        Tue,  2 Jun 2020 03:33:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D4AD40280;
        Tue,  2 Jun 2020 09:32:58 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4] dt-bindings: thermal: Convert qoriq to json-schema
Date:   Tue,  2 Jun 2020 09:22:43 +0800
Message-Id: <1591060963-14904-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the qoriq thermal binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- Update maintainer since previous maintainer's email is NOT longer available.
---
 .../devicetree/bindings/thermal/qoriq-thermal.txt  |  71 -------------
 .../devicetree/bindings/thermal/qoriq-thermal.yaml | 112 +++++++++++++++++++++
 2 files changed, 112 insertions(+), 71 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
deleted file mode 100644
index 28f2cba..0000000
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
-
-Required properties:
-- compatible : Must include "fsl,qoriq-tmu" or "fsl,imx8mq-tmu". The
-	version of the device is determined by the TMU IP Block Revision
-	Register (IPBRR0) at offset 0x0BF8.
-	Table of correspondences between IPBRR0 values and example  chips:
-		Value           Device
-		----------      -----
-		0x01900102      T1040
-- reg : Address range of TMU registers.
-- interrupts : Contains the interrupt for TMU.
-- fsl,tmu-range : The values to be programmed into TTRnCR, as specified by
-	the SoC reference manual. The first cell is TTR0CR, the second is
-	TTR1CR, etc.
-- fsl,tmu-calibration : A list of cell pairs containing temperature
-	calibration data, as specified by the SoC reference manual.
-	The first cell of each pair is the value to be written to TTCFGR,
-	and the second is the value to be written to TSCFGR.
-- #thermal-sensor-cells : Must be 1. The sensor specifier is the monitoring
-	site ID, and represents the "n" in TRITSRn and TRATSRn.
-
-Optional property:
-- little-endian : If present, the TMU registers are little endian. If absent,
-	the default is big endian.
-- clocks : the clock for clocking the TMU silicon.
-
-Example:
-
-tmu@f0000 {
-	compatible = "fsl,qoriq-tmu";
-	reg = <0xf0000 0x1000>;
-	interrupts = <18 2 0 0>;
-	fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
-	fsl,tmu-calibration = <0x00000000 0x00000025
-			       0x00000001 0x00000028
-			       0x00000002 0x0000002d
-			       0x00000003 0x00000031
-			       0x00000004 0x00000036
-			       0x00000005 0x0000003a
-			       0x00000006 0x00000040
-			       0x00000007 0x00000044
-			       0x00000008 0x0000004a
-			       0x00000009 0x0000004f
-			       0x0000000a 0x00000054
-
-			       0x00010000 0x0000000d
-			       0x00010001 0x00000013
-			       0x00010002 0x00000019
-			       0x00010003 0x0000001f
-			       0x00010004 0x00000025
-			       0x00010005 0x0000002d
-			       0x00010006 0x00000033
-			       0x00010007 0x00000043
-			       0x00010008 0x0000004b
-			       0x00010009 0x00000053
-
-			       0x00020000 0x00000010
-			       0x00020001 0x00000017
-			       0x00020002 0x0000001f
-			       0x00020003 0x00000029
-			       0x00020004 0x00000031
-			       0x00020005 0x0000003c
-			       0x00020006 0x00000042
-			       0x00020007 0x0000004d
-			       0x00020008 0x00000056
-
-			       0x00030000 0x00000012
-			       0x00030001 0x0000001d>;
-	#thermal-sensor-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
new file mode 100644
index 0000000..ae76208
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    description: |
+      The version of the device is determined by the TMU IP Block Revision
+      Register (IPBRR0) at offset 0x0BF8.
+      Table of correspondences between IPBRR0 values and example chips:
+            Value           Device
+            ----------      -----
+            0x01900102      T1040
+    enum:
+      - fsl,qoriq-tmu
+      - fsl,imx8mq-tmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  fsl,tmu-range:
+    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    description: |
+      The values to be programmed into TTRnCR, as specified by the SoC
+      reference manual. The first cell is TTR0CR, the second is TTR1CR, etc.
+    maxItems: 4
+
+  fsl,tmu-calibration:
+    $ref: '/schemas/types.yaml#/definitions/uint32-matrix'
+    description: |
+      A list of cell pairs containing temperature calibration data, as
+      specified by the SoC reference manual. The first cell of each pair
+      is the value to be written to TTCFGR, and the second is the value
+      to be written to TSCFGR.
+    items:
+      items:
+        - description: value for TTCFGR
+        - description: value for TSCFGR
+    minItems: 1
+    maxItems: 64
+
+  little-endian:
+    description: |
+      boolean, if present, the TMU registers are little endian. If absent,
+      the default is big endian.
+    type: boolean
+
+  clocks:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - fsl,tmu-range
+  - fsl,tmu-calibration
+  - '#thermal-sensor-cells'
+
+examples:
+  - |
+    tmu@f0000 {
+        compatible = "fsl,qoriq-tmu";
+        reg = <0xf0000 0x1000>;
+        interrupts = <18 2 0 0>;
+        fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
+        fsl,tmu-calibration = <0x00000000 0x00000025>,
+                              <0x00000001 0x00000028>,
+                              <0x00000002 0x0000002d>,
+                              <0x00000003 0x00000031>,
+                              <0x00000004 0x00000036>,
+                              <0x00000005 0x0000003a>,
+                              <0x00000006 0x00000040>,
+                              <0x00000007 0x00000044>,
+                              <0x00000008 0x0000004a>,
+                              <0x00000009 0x0000004f>,
+                              <0x0000000a 0x00000054>,
+                              <0x00010000 0x0000000d>,
+                              <0x00010001 0x00000013>,
+                              <0x00010002 0x00000019>,
+                              <0x00010003 0x0000001f>,
+                              <0x00010004 0x00000025>,
+                              <0x00010005 0x0000002d>,
+                              <0x00010006 0x00000033>,
+                              <0x00010007 0x00000043>,
+                              <0x00010008 0x0000004b>,
+                              <0x00010009 0x00000053>,
+                              <0x00020000 0x00000010>,
+                              <0x00020001 0x00000017>,
+                              <0x00020002 0x0000001f>,
+                              <0x00020003 0x00000029>,
+                              <0x00020004 0x00000031>,
+                              <0x00020005 0x0000003c>,
+                              <0x00020006 0x00000042>,
+                              <0x00020007 0x0000004d>,
+                              <0x00020008 0x00000056>,
+                              <0x00030000 0x00000012>,
+                              <0x00030001 0x0000001d>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.7.4

