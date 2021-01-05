Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907492EA88D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbhAEKXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 05:23:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3502 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbhAEKXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609842232; x=1641378232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xNZPMYNMCKt4ZYCgdVXKuL67MerNUBb6qbvlt+irMUw=;
  b=NFaR3eDxhXN/NLFR3QZY8NOkTzZkayDNGqaSNJZLvB1bKNPnwAELJ2iq
   bdSpNgX/85vZRY67qkIAdDrE3+W8zlOoc100POPM9+KPtSSfZiNDKQrj9
   qfbqp5DymK1lUMAqwWoe2O5lgoiXu5MUHd5wwelE65UXqH9gFeg9bbExT
   BjE47WCXJ5k2+Exp1OP8wsGV37rqeFlr3xg0IyvSQLXXiaapMGT7DXYaB
   mlLFihfzHVZ0jmvpmSWCz6SWLr0KcoLlBsxdleygA31qH0RhTMDx7Kdlo
   m+M32/2Iyt6sOF7oFZ8btnvXBxO9nceI/G5/gGp2tGpHKhy3Ag5GeiDDc
   w==;
IronPort-SDR: r5kypfzC1TQFsKRhgONpXq22XBR8kgPdPtgS3lZzZhdPU1/UyV7/tqIAfeKsL1DYTJ08ezImY4
 4G11rrqRKjEmsSXdg+ZvK0FBm83NNwYx/S3wAwnxuAPjy6sLJHuvPDIIt/Syq1x9btuC3OQfqS
 x1ptsqrc5Ais3bk1vXLzJ+71CoN/7KvlwYpOZApScNp5lkbKkWVu/2UWCAYKx8YwE3TpxiF4gi
 XB6uT6KIO5io1zAW6vOXhVDuzZSfLrgOZffAjFE/rHVCOdcTUlJf7kmVZNIuf0MrqOzHd8OmQ/
 fXM=
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="104287954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2021 03:22:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 03:22:35 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 5 Jan 2021 03:22:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] dt-bindings: cpufreq: sama7g5-cpufreq: add dt bindings documentation
Date:   Tue, 5 Jan 2021 12:22:25 +0200
Message-ID: <1609842147-8161-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
References: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add DT bindings documentation for SAMA7G5 CPUFreq driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/cpufreq/cpufreq-sama7g5.yaml          | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml
new file mode 100644
index 000000000000..e8185a614035
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-sama7g5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SAMA7G5's CPUFreq device tree bindings
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+properties:
+  clocks:
+    items:
+      - description: The clock feeding the CPU
+      - description: The clock sharing the PLL and prescaller with CPU clock
+
+  clock-names:
+    items:
+      - const: cpu
+      - const: mck
+
+  operating-points-v2:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to OPP table
+
+  cpu-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to CPU's voltage regulator
+
+required:
+  - clocks
+  - clock-names
+  - operating-points-v2
+  - cpu-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    cpu_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-600000000 {
+                    opp-hz = /bits/ 64 <600000000>;
+                    opp-microvolt = <1125000 1050000 1225000>;
+                    clock-latency-ns = <50000>;
+            };
+
+            opp-800000000 {
+                    opp-hz = /bits/ 64 <800000000>;
+                    opp-microvolt = <1175000 1125000 1225000>;
+                    clock-latency-ns = <50000>;
+            };
+
+            opp-1000000000 {
+                    opp-hz = /bits/ 64 <1000000000>;
+                    opp-microvolt = <1275000 1225000 1300000>;
+                    clock-latency-ns = <50000>;
+            };
+    };
+
+  - |
+    cpus {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            cpu0: cpu@0 {
+                    device_type = "cpu";
+                    compatible = "arm,cortex-a7";
+                    reg = <0x0>;
+                    clocks = <&pmc PMC_TYPE_CORE PMC_CPU>, <&pmc PMC_TYPE_CORE PMC_MCK>;
+                    clock-names = "cpu", "mck";
+                    operating-points-v2 = <&cpu_opp_table>;
+                    cpu-supply = <&vddcpu>;
+            };
+    };
-- 
2.7.4

