Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23633F18C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhCQNtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhCQNtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDE4C06174A;
        Wed, 17 Mar 2021 06:49:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AD5C61F44E62
Received: by jupiter.universe (Postfix, from userid 1000)
        id D18054800E1; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 09/38] dt-bindings: power: supply: isp1704: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:35 +0100
Message-Id: <20210317134904.80737-10-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/isp1704.txt         | 17 --------
 .../bindings/power/supply/isp1704.yaml        | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/isp1704.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/isp1704.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/isp1704.txt b/Documentation/devicetree/bindings/power/supply/isp1704.txt
deleted file mode 100644
index fa3596907967..000000000000
--- a/Documentation/devicetree/bindings/power/supply/isp1704.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Binding for NXP ISP1704 USB Charger Detection
-
-Required properties:
-- compatible: Should contain one of the following:
- * "nxp,isp1704"
-- nxp,enable-gpio: Should contain a phandle + gpio-specifier
-  to the GPIO pin connected to the chip's enable pin.
-- usb-phy: Should contain a phandle to the USB PHY
-  the ISP1704 is connected to.
-
-Example:
-
-isp1704 {
-	compatible = "nxp,isp1704";
-	nxp,enable-gpio = <&gpio3 3 GPIO_ACTIVE_LOW>;
-	usb-phy = <&usb2_phy>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/isp1704.yaml b/Documentation/devicetree/bindings/power/supply/isp1704.yaml
new file mode 100644
index 000000000000..4c91da70011d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/isp1704.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/isp1704.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for NXP ISP1704 USB Charger Detection
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: nxp,isp1704
+
+  nxp,enable-gpio:
+    maxItems: 1
+    description: GPIO connected to the chip's enable pin
+
+  usb-phy:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: USB PHY the ISP1704 is connected to
+
+required:
+  - compatible
+  - nxp,enable-gpio
+  - usb-phy
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    charger-detect {
+      compatible = "nxp,isp1704";
+      nxp,enable-gpio = <&gpio3 3 GPIO_ACTIVE_LOW>;
+      usb-phy = <&usb2_phy>;
+    };
-- 
2.30.2

