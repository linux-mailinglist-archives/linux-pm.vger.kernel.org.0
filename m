Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABF2E6E71
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2GSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 01:18:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33816 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbgL2GSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 01:18:08 -0500
X-UUID: 41a8b44ef2ea45fca9cfccf68da20dca-20201229
X-UUID: 41a8b44ef2ea45fca9cfccf68da20dca-20201229
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1171348968; Tue, 29 Dec 2020 14:17:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Dec 2020 14:17:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 14:17:19 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, <hector.yuan@mediatek.com>
Subject: [PATCH v10 2/2] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Tue, 29 Dec 2020 14:17:09 +0800
Message-ID: <1609222629-2979-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
References: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
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
 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  116 ++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
new file mode 100644
index 0000000..53e0eb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
@@ -0,0 +1,116 @@
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
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
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
+
+            cpu1: cpu@100 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a55";
+                enable-method = "psci";
+                performance-domains = <&performance 0>;
+                reg = <0x100>;
+            };
+
+            cpu2: cpu@200 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a55";
+                enable-method = "psci";
+                performance-domains = <&performance 0>;
+                reg = <0x200>;
+            };
+
+            cpu3: cpu@300 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a55";
+                enable-method = "psci";
+                performance-domains = <&performance 0>;
+                reg = <0x300>;
+            };
+
+            cpu4: cpu@400 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a55";
+                enable-method = "psci";
+                performance-domains = <&performance 1>;
+                reg = <0x400>;
+            };
+
+            cpu5: cpu@500 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a55";
+                enable-method = "psci";
+                performance-domains = <&performance 1>;
+                reg = <0x500>;
+            };
+
+            cpu6: cpu@600 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a75";
+                enable-method = "psci";
+                performance-domains = <&performance 1>;
+                reg = <0x600>;
+            };
+
+            cpu7: cpu@700 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a75";
+                enable-method = "psci";
+                performance-domains = <&performance 1>;
+                reg = <0x700>;
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
+            #performance-domain-cells = <1>;
+        };
+    };
-- 
1.7.9.5

