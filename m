Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2289F3DA890
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhG2QL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 12:11:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44718 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234019AbhG2QJw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 12:09:52 -0400
X-UUID: 42e6f1a8bda4468fbaa26d88e0366fb2-20210730
X-UUID: 42e6f1a8bda4468fbaa26d88e0366fb2-20210730
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 932944710; Fri, 30 Jul 2021 00:08:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 00:08:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 00:08:17 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v13 1/2] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Fri, 30 Jul 2021 00:08:10 +0800
Message-ID: <1627574891-26514-2-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
References: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Hector.Yuan" <hector.yuan@mediatek.com>

Add devicetree bindings for MediaTek HW driver.

Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
---
 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   70 ++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
new file mode 100644
index 0000000..6bb2c97
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek's CPUFREQ Bindings
+
+maintainers:
+  - Hector Yuan <hector.yuan@mediatek.com>
+
+description:
+  CPUFREQ HW is a hardware engine used by MediaTek
+  SoCs to manage frequency in hardware. It is capable of controlling frequency
+  for multiple clusters.
+
+properties:
+  compatible:
+    const: mediatek,cpufreq-hw
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    description: |
+      Addresses and sizes for the memory of the
+      HW bases in each frequency domain.
+
+  "#performance-domain-cells":
+    description:
+      Number of cells in a performance domain specifier. Typically 1 for nodes
+      providing multiple performance domains (e.g. performance controllers),
+      but can be any value as specified by device tree binding documentation
+      of particular provider.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#performance-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cpus {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            cpu0: cpu@0 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a55";
+                enable-method = "psci";
+                performance-domains = <&performance 0>;
+                reg = <0x000>;
+            };
+    };
+
+    /* ... */
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        performance: performance-controller@11bc00 {
+            compatible = "mediatek,cpufreq-hw";
+            reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+
+            #performance-domain-cells = <1>;
+        };
+    };
-- 
1.7.9.5

