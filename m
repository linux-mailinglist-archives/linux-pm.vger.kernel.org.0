Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1D6C4284
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 06:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCVF7P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 01:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCVF7M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 01:59:12 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6B591FB;
        Tue, 21 Mar 2023 22:58:42 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0sI72006655;
        Wed, 22 Mar 2023 01:58:39 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pekwxv67b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 01:58:38 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 32M5wba6012730
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 01:58:37 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:58:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:58:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 Mar 2023 01:58:36 -0400
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32M5ueXM016875;
        Wed, 22 Mar 2023 01:58:25 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 7/8] dt-bindings: mfd: max77658: Add ADI MAX77658
Date:   Wed, 22 Mar 2023 08:56:27 +0300
Message-ID: <20230322055628.4441-8-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oDjbOH3isxeyvX-dJxV-GAdWCO6o-VFo
X-Proofpoint-GUID: oDjbOH3isxeyvX-dJxV-GAdWCO6o-VFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220042
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add ADI MAX77658 devicetree document.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 .../devicetree/bindings/mfd/adi,max77658.yaml | 199 ++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml

diff --git a/Documentation/devicetree/bindings/mfd/adi,max77658.yaml b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
new file mode 100644
index 000000000000..6edb59e8f446
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
@@ -0,0 +1,199 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/adi,max77658.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77643/MAX77654/MAX77658/MAX77659 PMIC from ADI
+
+maintainers:
+  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
+  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+
+description: |
+  MAX77643, MAX77654, MAX77658 and MAX77659 devices are a family of ADI PMICs
+  providing battery charging and power supply solutions for
+  low-power applications.
+
+  MAX77643 is a Power Management IC with 1 LDO regulator.
+
+  MAX77654 is a Power Management IC with 2 LDO regulators and 1 charger.
+
+  MAX77658 is a Power Management IC with 2 LDO regulators, 1 charger
+  and 1 fuel gauge.
+
+  MAX77659 is a Power Management IC with 1 LDO regulator and 1 charger.
+
+properties:
+  compatible:
+    enum:
+      - adi,max77643
+      - adi,max77654
+      - adi,max77658
+      - adi,max77659
+
+  reg:
+    description: I2C address of the PMIC
+    items:
+      - enum: [0x40, 0x48]
+
+  interrupts:
+    maxItems: 1
+
+  charger:
+    $ref: /schemas/power/supply/adi,max77658-charger.yaml
+
+  fuel-gauge:
+    $ref: /schemas/power/supply/adi,max77658-battery.yaml
+
+  regulators:
+    $ref: /schemas/regulator/adi,max77658-regulator.yaml
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max77643
+              - adi,max77654
+              - adi,max77658
+
+    then:
+      properties:
+        reg:
+          items:
+            - const: 0x48
+
+    else:
+      properties:
+        reg:
+          items:
+            - const: 0x40
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    battery: battery-cell {
+      compatible = "simple-battery";
+      alert-celsius = <0 100>;
+      constant-charge-current-max-microamp = <15000>;
+    };
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@48 {
+        compatible = "adi,max77643";
+        reg = <0x48>;
+        interrupt-parent = <&gpio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        regulators {
+          LDO0 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@48 {
+        compatible = "adi,max77654";
+        reg = <0x48>;
+        interrupt-parent = <&gpio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        charger {
+          compatible = "adi,max77654-charger";
+          monitored-battery = <&battery>;
+          adi,fast-charge-timer = <5>;
+          adi,topoff-timer = <30>;
+          adi,input-current-limit-microamp = <475000>;
+        };
+        regulators {
+          LDO0 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+          LDO1 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@48 {
+        compatible = "adi,max77658";
+        reg = <0x48>;
+        interrupt-parent = <&gpio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        charger {
+          compatible = "adi,max77658-charger";
+          monitored-battery = <&battery>;
+          adi,fast-charge-timer = <5>;
+          adi,topoff-timer = <30>;
+          adi,input-current-limit-microamp = <475000>;
+        };
+        regulators {
+          LDO0 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+          LDO1 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+        fuel-gauge {
+          compatible = "adi,max77658-battery";
+          monitored-battery = <&battery>;
+          adi,valrt-min-microvolt = <0>;
+          adi,valrt-max-microvolt = <5100000>;
+          adi,salrt-min-percent = <1>;
+          adi,salrt-max-percent = <99>;
+          adi,ialrt-min-microamp = <(-5000)>;
+          adi,ialrt-max-microamp = <5000>;
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@40 {
+        compatible = "adi,max77659";
+        reg = <0x40>;
+        interrupt-parent = <&gpio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        charger {
+          compatible = "adi,max77659-charger";
+          monitored-battery = <&battery>;
+          adi,fast-charge-timer = <5>;
+          adi,topoff-timer = <30>;
+        };
+        regulators {
+          LDO0 {
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+      };
+    };
-- 
2.25.1

