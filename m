Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53234608B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhCWN5X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:57:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40627 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231869AbhCWN5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 09:57:07 -0400
X-UUID: a46be53699e04b158e4d6ece66d52eff-20210323
X-UUID: a46be53699e04b158e4d6ece66d52eff-20210323
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1078030621; Tue, 23 Mar 2021 21:56:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 21:56:58 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 21:56:58 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v13 1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
Date:   Tue, 23 Mar 2021 21:56:51 +0800
Message-ID: <20210323135657.2701-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210323135657.2701-1-roger.lu@mediatek.com>
References: <20210323135657.2701-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the binding for enabling mtk svs on MediaTek SoC.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 .../bindings/soc/mediatek/mtk-svs.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
new file mode 100644
index 000000000000..0d8d12f927de
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mtk-svs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Smart Voltage Scaling (SVS) Device Tree Bindings
+
+maintainers:
+  - Roger Lu <roger.lu@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Kevin Hilman <khilman@kernel.org>
+  - Nishanth Menon <nm@ti.com>
+
+description: |+
+  The SVS engine is a piece of hardware which has several
+  controllers(banks) for calculating suitable voltage to
+  different power domains(CPU/GPU/CCI) according to
+  chip process corner, temperatures and other factors. Then DVFS
+  driver could apply SVS bank voltage to PMIC/Buck.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8183-svs
+
+  reg:
+    maxItems: 1
+    description: Address range of the MTK SVS controller.
+
+  clocks:
+    maxItems: 1
+    description: Main clock for MTK SVS controller to work.
+
+  clock-names:
+    const: main
+
+  nvmem-cells:
+    maxItems: 2
+    description: |
+      Phandle to the calibration data provided by a nvmem device.
+    items:
+      - description: SVS efuse for SVS controller
+      - description: Thermal efuse for SVS controller
+
+  nvmem-cell-names:
+    items:
+      - const: svs-calibration-data
+      - const: t-calibration-data
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        svs@1100b000 {
+            compatible = "mediatek,mt8183-svs";
+            reg = <0 0x1100b000 0 0x1000>;
+            interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&infracfg CLK_INFRA_THERM>;
+            clock-names = "main";
+            nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
+            nvmem-cell-names = "svs-calibration-data", "t-calibration-data";
+        };
+    };
-- 
2.18.0

