Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7168FCB6E5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfJDJBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:01:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36729 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbfJDJBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:01:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so5003568wmc.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qa7DsO3ACeYY6r1oXxNziZNrJiVR8gru+lXValqW5yo=;
        b=iqiZDv6x4j5j7J4/i345eIHtj37AQf+5xW7hlIXOH4S/3064hPddqNd3O0p0FSN39v
         E1IZ/wcxnjvKYl7egSdMnEFegm+tshD7vZf7BF5bG+9WJ8M/HsreAdGCcbwUo6mWQaWD
         j19+wOFVmiEs0E2TDwQ9QjTgiILjeJD4wm/eqRKj4FxR6i4Sd+Rwz+WT516McZn+5Aak
         NpobKJQQLQXgF2w8nPfrsCPUSsbWsAfPthBU4T9rPLART/mjxAeMQnvmaddg7dzzW8Yo
         KhYbY0cHJN/86MEVbIn6VBySuFt8UGK7uo2BYdfd4KFufko+dcMMmUrXCX52Eq+Z/u9U
         f3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qa7DsO3ACeYY6r1oXxNziZNrJiVR8gru+lXValqW5yo=;
        b=UsbIMKpg1kSOLOTX2sKFsbYpOX/qSfQxz+ldiiiJZmZTVyKXNYgtp7bVU6c2lWL5pf
         1PfBivzUJl3V/isrYjH4E5l9hXSJCIaZmHFDB8hkPeV/iQQpIntVMfzd9tlvgTMs4Y9O
         SEhAlMcLytGk75Y5R4AoHhWwxK7fZwRnwm3bZ6AwC5CuOYN6T08Q7tj0lX2y221H1SeK
         QDomlF7c017iuCsjZTTS+eyPBCeebRkLhuWKyyogY3MpAumm62bRmNh4Quay+hd4XvJR
         urnkXIm85PZMsiv6zH6uzEytby8omZq9jlS21j8BUG/oz8/wQwaxysQLuZ+3TRSZw/IE
         4j5w==
X-Gm-Message-State: APjAAAUWQ8iGOt3NMfztzRrw7sU/c38vy9LqRMDmLUqtizazGO6hzeJZ
        Fji5awp6gSNCq1AwP/vV0bIMPw==
X-Google-Smtp-Source: APXvYqz6Wrjp0Gh/DAqC/UBRAVNNd14/cnfE4WZ/qx3dCtQWucaJsnEwIFqwRzAEV2sRVie5vL2wCw==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr9887223wme.103.1570179677139;
        Fri, 04 Oct 2019 02:01:17 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:16 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 1/7] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Fri,  4 Oct 2019 11:01:08 +0200
Message-Id: <20191004090114.30694-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12A and G12B SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..f761681e4c0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Thermal
+
+maintainers:
+  - Guillaume La Roque <glaroque@baylibre.com>
+
+description: Binding for Amlogic Thermal
+
+properties:
+  compatible:
+      items:
+        - enum:
+            - amlogic,g12a-cpu-thermal
+            - amlogic,g12a-ddr-thermal
+        - const: amlogic,g12a-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  amlogic,ao-secure:
+    description: phandle to the ao-secure syscon
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - amlogic,ao-secure
+
+examples:
+  - |
+        cpu_temp: temperature-sensor@ff634800 {
+                compatible = "amlogic,g12a-cpu-thermal",
+                             "amlogic,g12a-thermal";
+                reg = <0xff634800 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                #thermal-sensor-cells = <0>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
-- 
2.17.1

