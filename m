Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC31C1C7D
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgEASCK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 14:02:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33616 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgEASCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 14:02:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041I28nJ043044;
        Fri, 1 May 2020 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588356128;
        bh=yGnuyaql2OihOk/f8RBTV56LnwcUhwGV6AH75gvHuDg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HtTbWt0e92Y1ufpp4093A6PI5IkwO1vKMYk8kgpvehaBsKNpKo3teF/rkEdS2aRA6
         N2osuE4gApT7cHjB02W8eBSdJWydyNhSQnqM2bFpEZx8rRImUY3KmhWke5anz5V3UG
         ADaCWcsCLn5MNBZ19CVKEP8MjnGQFB946OL767Rk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 041I289F065464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 May 2020 13:02:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 12:59:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 12:59:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041HxwxB122297;
        Fri, 1 May 2020 12:59:59 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] Add the bindings for the bq25150 and bq25155 500mA charging ICs from Texas Instruments.
Date:   Fri, 1 May 2020 12:51:17 -0500
Message-ID: <20200501175118.26226-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200501175118.26226-1-dmurphy@ti.com>
References: <20200501175118.26226-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ricardo Rivera-Matos <r-rivera-matos@ti.com>

Description:
The BQ2515X family of devices are highly integrated battery management
ICs that integrate the most common functions for wearbale devices
namely a charger, an output voltage rail, ADC for battery and system
monitoring, and a push-button controller.

Datasheets:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
---
 .../bindings/power/supply/bq2515x.yaml        | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
new file mode 100644
index 000000000000..673caf67a993
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
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
+  ac_detect-gpios:
+    description: |
+       GPIO used for connecting the bq2515x device PG (AC Detect)
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
+  precharge-current-max-microamp:
+    description: |
+       Maximum precharging current in micro Amps.
+    minimum: 1250
+    maximum: 77500
+
+  input-current-limit-microamp:
+    description: |
+       Maximum input current in micro Amps.
+    minimum: 50000
+    maximum: 500000
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
+          ac_detect-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+          reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+          low-power-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+          charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+          constant-charge-current-max-microamp = <300000>;
+          constant-charge-voltage-max-microvolt = <4200000>;
+	  precharge-current-max-microamp = <2500>;
+	  input-current-limit-microamp = <100000>;
+      };
+    };
-- 
2.25.1

