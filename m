Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC028321D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfHFNFO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 09:05:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38958 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFNFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 09:05:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so66035123wmc.4
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MU/41RFECDspWBa3sc+F8Zp39+RFWaJYY0sZSPREqvA=;
        b=dMgLNtg6IB/G4JAEZ3gnOVQg+IAWnmWkO+EUx8o+nfCf2wRwi/CyWA9dWmAEgKwgDf
         +zeDEHMZRJ1mlwUPCPKsiT3dNwwWqJa5d1YMs9mOxV8yRESy3FvWmwBTK7OnJuw5Qrz+
         tuo3Q86hyJMOSljkAjcn1r8DLep2abJXdysO5L6ymzWRhjDyXrjSzcajBI2rLVbS0psM
         Stmh5yfUBJE8/nXQMswyjU4uYeKk4TbUOWdFsRjI/WUb/ux6v/yHw0tgE4/jgW6cDtQU
         OGPrDhBsGbirU37wPrcDhnKn2x4n4EqNf8zgEirUsi6U53KF5Hh8qGO/mGOtOdrfqqMU
         xrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MU/41RFECDspWBa3sc+F8Zp39+RFWaJYY0sZSPREqvA=;
        b=lyg+ugf1oJ/HYzInwIu0tpqTGUQdc2NT7BRspwPHOUcHw6UzC2jIAYyl3/GGh3AkLB
         jsR6zg+DT9uBGYuIuqN0J6v98oqiI9Hr5Qf1M7ZNCfI9mcOyiQnFGOzLua+P8451RoiP
         g+PZc3RybnQsNWPjD4vQzxfh5PLkA4ybgSMrudZrX6MWLbJf3BDNzYNnXvGrpAmgRYB0
         FuV6nxQKovkrQXm/RVLukv+2ZuyCVzVeqIb1dsu5dqPwJI800o8MsuCMLWBU8//gAcIW
         bZ0z450wl0NGYHiiwaRkHW7IzX7zjKLrKlLEfSMfwCoVwjXpG6eaBzEfqABpLS96T07n
         1kdw==
X-Gm-Message-State: APjAAAWEvf0t4rGz3Lhac89QtD9W24tt7vN7FVGI2tw47L2PNh2gRJtj
        0EJjjKOwJLYXtH0Q6kJ7x6RW0w==
X-Google-Smtp-Source: APXvYqxMHvYaJ55mSpFSMmQD9n9qF8WkY+OoQWCPbiPLbkpx1d0Xyg+zVQoK8Ysivq0YgXQDiUeARw==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr5010397wma.41.1565096711633;
        Tue, 06 Aug 2019 06:05:11 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j33sm201888738wre.42.2019.08.06.06.05.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:05:10 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Tue,  6 Aug 2019 15:05:01 +0200
Message-Id: <20190806130506.8753-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806130506.8753-1-glaroque@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12 SoCs.
the G12A  and G12B SoCs are supported.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..d25e59113398
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
+description: Binding for Amlogic Thermal Driver
+
+properties:
+  compatible:
+      items:
+        - enum:
+            - amlogic,g12-cpu-thermal
+            - amlogic,g12-ddr-thermal
+        - const: amlogic,g12-thermal
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
+                compatible = "amlogic,g12-cpu-thermal",
+                             "amlogic,g12-thermal";
+                reg = <0xff634800 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                #thermal-sensor-cells = <0>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
-- 
2.17.1

