Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7C2334D8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgG3O6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 10:58:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45166 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3O6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 10:58:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UEwexe055492;
        Thu, 30 Jul 2020 09:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596121120;
        bh=sBlylftWCXxQKT/KZPRF3PfU/JvWz7JLIy5pu6TfDUo=;
        h=From:To:CC:Subject:Date;
        b=uNHGqGNKFUsOmxCg/WxzcqdLiKUYVPNa1J6y9zS8IE+YWiTkJoAm1bXoXjC/5Ska0
         uy1FumaMN4CsKydS2mIar/TTwmDgxJuQ/MbRjadEI8UIABeDsjO5XZAfry1Xqb8jD4
         5/PgD62MTSnCo0GB1C4+VoJlKE88z1EC5RdPZPsU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UEweFF130039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 09:58:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 09:58:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 09:58:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UEweTp103620;
        Thu, 30 Jul 2020 09:58:40 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <r-rivera-matos@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: power: Add the bq25790 dt bindings
Date:   Thu, 30 Jul 2020 09:58:33 -0500
Message-ID: <20200730145834.29227-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the bq25790.

Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/bq25790.yaml        | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25790.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq25790.yaml b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
new file mode 100644
index 000000000000..97dd539c1625
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq25790.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI BQ25790 Switch Mode Buck-Boost Charger
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  BQ25790 is a highly integrated switch-mode buck-boost charger for 1-4 cell
+  Li-ion batteries and Li-polymer batteries. The device charges a battery from a
+  wide range of input sources including legacy USB adapters to high voltage USB
+  PD adapters and traditional barrel adapters.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,bq25790
+      - ti,bq25792
+
+  reg:
+    maxItems: 1
+
+  ti,watchdog-timer:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Watchdog timer in milli seconds. 0 (default) disables the watchdog.
+    minimum: 0
+    maximum: 160000
+    enum: [ 0, 500, 1000, 2000, 20000, 40000, 80000, 160000]
+
+  input-voltage-limit-microvolt:
+    description: |
+      Minimum input voltage limit in micro volts with a 100000 micro volt step.
+    minimum: 3600000
+    maximum: 22000000
+
+  input-current-limit-microamp:
+    description: |
+      Maximum input current limit in micro amps with a 100000 micro amp step.
+    minimum: 100000
+    maximum: 3300000
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the battery node being monitored
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+
+examples:
+  - |
+    bat: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <2000000>;
+      constant-charge-voltage-max-microvolt = <4200000>;
+      precharge-current-microamp = <160000>;
+      charge-term-current-microamp = <160000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bq25790: charger@6b {
+          compatible = "ti,bq25790";
+          reg = <0x6b>;
+          interrupt-parent = <&gpio1>;
+          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+          ti,watchdog-timer = <2000>;
+          input-current-limit = <3000000>;
+          input-voltage-limit = <4500000>;
+          monitored-battery = <&bat>;
+      };
+    };
+
+...
-- 
2.28.0

