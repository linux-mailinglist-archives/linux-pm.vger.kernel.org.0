Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001031AE3CC
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgDQR21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 13:28:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgDQR21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 13:28:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HHSPtU124434;
        Fri, 17 Apr 2020 12:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587144505;
        bh=XcktGMm86LrXuFXN4E3o1fTOY1S7SluLSzDZzcvaRfU=;
        h=From:To:CC:Subject:Date;
        b=xro3vdZ60hwDNJ2pPIpedzJgEsmZlvi1+XWwEEF0tKRoNQSsPdJzaS1w2MMwmNKEd
         Ivk1gNuVi9DaSpPnloPHOvXFNvgZcvrsFIe5f993bNzhlR1lGYcj/sVtlxziF9qXHM
         xYe/KfaVumSTQEIKwZbqV61krYbRL5r7qrZUB5lo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HHSPLq040818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 12:28:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 12:28:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 12:28:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HHSOVV048276;
        Fri, 17 Apr 2020 12:28:24 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: power: Add the BQ27561 fuel gauge bindings
Date:   Fri, 17 Apr 2020 12:22:26 -0500
Message-ID: <20200417172227.28075-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the Texas Instrument BQ27561 and BQ27750 fuel gauge device
tree bindings.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/bq27561.yaml        | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27561.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq27561.yaml b/Documentation/devicetree/bindings/power/supply/bq27561.yaml
new file mode 100644
index 000000000000..abc9acdbc704
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq27561.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq27561.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI BQ27561 and BQ27750 Fuel Gauges
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The bq27z561 device provides a feature-rich gas gauging solution for
+  single-cell battery pack applications.
+
+  Specifications about the charger can be found at:
+    https://www.ti.com/lit/gpn/bq27z561
+    https://www.ti.com/lit/gpn/bq27750
+
+properties:
+  compatible:
+    enum:
+      - ti,bq27561
+      - ti,bq27750
+
+  reg:
+    maxItems: 1
+    description: |
+      I2C address of the device which is 0x55
+
+required:
+  - compatible
+  - reg
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      fuel_gauge@55 {
+        compatible = "ti,bq27561";
+        reg = <0x55>;
+      };
+    };
-- 
2.25.1

