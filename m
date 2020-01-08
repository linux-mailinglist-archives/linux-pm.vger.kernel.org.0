Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD58134D2D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 21:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgAHU0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 15:26:13 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50594 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgAHU0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 15:26:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ6pp068768;
        Wed, 8 Jan 2020 14:26:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578515166;
        bh=XLse9z0tDThLH9IDB2DDy99cgyodz7FGVKmtaloWMug=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zv0NTyJhW8C9izDart+4qx/2WuSxGjfS68N9un5VotZbmxzMdxUqz/RfrznF/44pG
         cAYU1pNtZFnSYRd9qA7y8MtvEOTOZ2177JrAX4jhQxtFlcay9Rpmu3Y3jsx95+YzjN
         vJDZ3wgX1h+K6eb1YjJq8NEOvQRxeIgvomCtfL60=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ6dN056692;
        Wed, 8 Jan 2020 14:26:06 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 14:26:05 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 14:26:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ5TM081954;
        Wed, 8 Jan 2020 14:26:05 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: power: Add the bq2515x family dt bindings
Date:   Wed, 8 Jan 2020 14:23:13 -0600
Message-ID: <20200108202314.11791-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200108202314.11791-1-dmurphy@ti.com>
References: <20200108202314.11791-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the bq25150 and bq25155 500mA
charging ICs from Texas Instruments.

Datasheet:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
v3 - Updated the constant-charge voltage binding to what is declared in
battery.txt

 .../bindings/power/supply/bq2515x.yaml        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
new file mode 100644
index 000000000000..670952021e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq2515x.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI bq2515x 500-mA Linear charger family
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The BQ2515x family is a highly integrated battery charge management IC that
+  integrates the most common functions for wearable devices, namely a charger,
+  an output voltage rail, ADC for battery and system monitoring, and
+  push-button controller.
+
+  Specifications about the charger can be found at:
+    http://www.ti.com/lit/ds/symlink/bq25150.pdf
+    http://www.ti.com/lit/ds/symlink/bq25155.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,bq25150
+      - ti,bq25155
+
+  reg:
+    maxItems: 1
+
+  pg-gpios:
+    description: |
+       GPIO used for connecting the bq2515x device PG (Power Good)
+       pin.  This pin should be used if possible as this is the
+       recommended way to obtain the charger's input PG state.
+       If this pin is not specified a software-based approach for PG
+       detection is used.
+
+  reset-gpios:
+    description: |
+       GPIO used for hardware reset.
+
+  low-power-gpios:
+    description: |
+       GPIO used for low power mode of IC.
+
+  charge-enable-gpios:
+    description: |
+       GPIO used to turn on and off charging.
+
+  constant-charge-current-max-microamp:
+    description: |
+       Maximum charging current in micro Amps.
+    minimum: 50000
+    maximum: 600000
+
+  constant-charge-voltage-max-microvolt:
+    description: |
+       Maximum charging voltage in micro volts.
+    minimum: 3600000
+    maximum: 4600000
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      charger@6b {
+          compatible = "ti,bq25150";
+          reg = <0x6b>;
+
+          pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+          reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+          low-power-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+          charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+          constant-charge-current-max-microamp = <300000>;
+          voltage-max-design-microvolt = <4200000>;
+      };
+    };
-- 
2.23.0

