Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F8C0577
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfI0Mrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 08:47:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0Mry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 08:47:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so2555840wrm.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aeDGNakdvDCwTy0gCOMkwdHE4LANquitP3dscaSQqkM=;
        b=OQhpBfcpOsi75i7MK05zao1qNF+c6CA+789h6xIiZbaDZTePZbFMkmg4+S/AkzcybG
         s7LtOeJQEcM8Tg2mrsr7mcQ4Dz62a0iXZ6Oxx/OF81hRye25+jReaG5Kd/0cpcNN7W4B
         LBjxld9HzH5mJGAlsqhwA/oYdIoeaOr8755YGFEYlAcq7rFMNnWX1Gwe5SrotyjC7AXp
         e3+i+owHxRsDsYcl7v04KzuyKUF9PCsW9Y34C8h0773Dqxmz0/024Vm4w2GUccQHeLYE
         NSOCUXSU3w63EbbIWalilUPUGw52KumrautjQxf3Pbdb3kBLBObppu2UKRHr53CCaut9
         1evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aeDGNakdvDCwTy0gCOMkwdHE4LANquitP3dscaSQqkM=;
        b=Xnr3mN36tD1xfLQVDi1C3TA5CrnKynYJEOpqLgRe8ALkUTPI3ArS5YlvpAfQkjwUU3
         oy42t+Pb81nC5fZzV/kXyJ5WkwyAZztTP6nfUEhGN9TtxqiKHZKPBCMb/O3MuWZqFakQ
         VJPMfo30g2fUex2Y9OnuVHvCGLjqZfMsQFN85XwU63/cSeVOfADX4UxRJGfjCi/NDMnr
         XeMJ3NLtmv4Eb2uFOpIgpRzIyWcrATsZkUICIOMWY/KDTaxy666kugdYKOxP48lCZJ+b
         qjd2KpYCeNkVKSbKqyp1/lNWSKcdpquuPDq3pHbhS+/7+5b4xFCAQDQ3NCEutKkyr6zR
         t0Wg==
X-Gm-Message-State: APjAAAXn5zUx42WrberXd8SIZQIBlrfN6ZkrnanQE4v/3lVDODfMWOWj
        CPhIRpUsweGC9QRMC0wWZwzsRA==
X-Google-Smtp-Source: APXvYqypZkDa1uq/ObhGW89r/AheycuvvS28MTywJ+8XL10HzmA4LvD0u/6iYpeX3B26TIElBWdLww==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr2717814wru.86.1569588473023;
        Fri, 27 Sep 2019 05:47:53 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:47:52 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 1/7] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Fri, 27 Sep 2019 14:47:42 +0200
Message-Id: <20190927124750.12467-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12A and G12B SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
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

