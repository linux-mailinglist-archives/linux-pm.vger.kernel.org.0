Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8118970F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 09:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCRI2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 04:28:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44636 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgCRI2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 04:28:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02I8Ruud001647;
        Wed, 18 Mar 2020 03:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584520076;
        bh=4NTvECDLj3H/EkvQN+MYDjjMN4IlOZQZ8avrk52PPfM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KlOgKLjekVQdfvt77E2g1kOE7AZ/hrSJzoUxSqudAaDB+wGow8sSFMOvgHf5gNB85
         7eyWfR9bGK+RmQZKrAXXOFiFIzZP8/bRzCnd3IYpOkskLr4EHYpU4WQL3tKQciYcnJ
         SVbO5cGvM8C/gx7NBhmYv6QKpnOPOO6AGbIAeVS0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02I8Ru5g029091
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Mar 2020 03:27:56 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 03:27:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 03:27:55 -0500
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02I8Rmom073942;
        Wed, 18 Mar 2020 03:27:52 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH v4 1/4] dt-bindings: thermal: k3: Add VTM bindings documentation
Date:   Wed, 18 Mar 2020 13:57:36 +0530
Message-ID: <20200318082739.9833-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318082739.9833-1-j-keerthy@ti.com>
References: <20200318082739.9833-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add VTM bindings documentation. In the Voltage Thermal
Management Module(VTM), K3 AM654 supplies a voltage
reference and a temperature sensor feature that are gathered in the band
gap voltage and temperature sensor (VBGAPTS) module. The band
gap provides current and voltage reference for its internal
circuits and other analog IP blocks. The analog-to-digital
converter (ADC) produces an output value that is proportional
to the silicon temperature.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../bindings/thermal/ti,am654-thermal.yaml    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
new file mode 100644
index 000000000000..d241b65d6072
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments AM654 VTM (DTS) binding
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    const: ti,am654-vtm
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - "#thermal-sensor-cells"
+  - compatible
+  - reg
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    vtm: thermal@42050000 {
+        compatible = "ti,am654-vtm";
+        reg = <0x0 0x42050000 0x0 0x25c>;
+        power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+        #thermal-sensor-cells = <1>;
+    };
+
+    mpu0_thermal: mpu0_thermal {
+        polling-delay-passive = <250>; /* milliseconds */
+        polling-delay = <500>; /* milliseconds */
+        thermal-sensors = <&vtm0 0>;
+
+        trips {
+                mpu0_crit: mpu0_crit {
+                        temperature = <125000>; /* milliCelsius */
+                        hysteresis = <2000>; /* milliCelsius */
+                        type = "critical";
+                };
+        };
+    };
+...
-- 
2.17.1

