Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81F420A0F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhJDL2B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 07:28:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhJDL2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 07:28:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 194BQA3f014215;
        Mon, 4 Oct 2021 06:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633346770;
        bh=+wmqoUYc5BcF3LKTzfsWSLC7Y4cyYXN3qU287WhrCz0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Pfsnmu2891lj3YHcVpHhf5OxF6sNIVWQESAo683SdjFdQrG+RqtgbwR+CLG8FRWNc
         whwGcnKWiznk5QhbsuZMjyUSI0fi+EgnW7dMbyUiwId/2rX7iOTtJOKog/LAb35T4S
         1kXhc55S6xK6v77yqotL7tqt6xyRuilsA3qVMwp0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 194BQAo4023229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Oct 2021 06:26:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 4
 Oct 2021 06:26:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 4 Oct 2021 06:26:09 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 194BQ382065426;
        Mon, 4 Oct 2021 06:26:07 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
Date:   Mon, 4 Oct 2021 16:55:47 +0530
Message-ID: <20211004112550.27546-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004112550.27546-1-j-keerthy@ti.com>
References: <20211004112550.27546-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add VTM bindings documentation. In the Voltage Thermal
Management Module(VTM), K3 J72XX supplies a voltage
reference and a temperature sensor feature that are gathered in the band
gap voltage and temperature sensor (VBGAPTS) module. The band
gap provides current and voltage reference for its internal
circuits and other analog IP blocks. The analog-to-digital
converter (ADC) produces an output value that is proportional
to the silicon temperature.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
new file mode 100644
index 000000000000..ccf1bd3640ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments J72XX VTM (DTS) binding
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    const: ti,j721e-vtm
+
+  reg:
+    maxItems: 3
+
+  power-domains:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    wkup_vtm0: wkup_vtm0@42040000 {
+        compatible = "ti,j721e-vtm", "ti,j7200-vtm";
+        reg = <0x0 0x42040000 0x0 0x350>,
+            <0x0 0x42050000 0x0 0x350>,
+            <0x0 0x43000300 0x0 0x10>;
+        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+        #thermal-sensor-cells = <1>;
+    };
+
+    mpu_thermal: mpu_thermal {
+        polling-delay-passive = <250>; /* milliseconds */
+        polling-delay = <500>; /* milliseconds */
+        thermal-sensors = <&wkup_vtm0 0>;
+
+        trips {
+                mpu_crit: mpu_crit {
+                        temperature = <125000>; /* milliCelsius */
+                        hysteresis = <2000>; /* milliCelsius */
+                        type = "critical";
+                };
+        };
+    };
+...
-- 
2.17.1

