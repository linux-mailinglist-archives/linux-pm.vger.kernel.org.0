Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF63046D2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 19:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbhAZRTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 12:19:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37579 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389678AbhAZIF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 03:05:27 -0500
X-UUID: 4b1a925bd7b74faf830dffe94b0833a1-20210126
X-UUID: 4b1a925bd7b74faf830dffe94b0833a1-20210126
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1032079677; Tue, 26 Jan 2021 16:03:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Jan 2021 16:03:55 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 16:03:55 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V8 01/12] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Tue, 26 Jan 2021 16:03:43 +0800
Message-ID: <1611648234-15043-2-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1611648234-15043-1-git-send-email-henryc.chen@mediatek.com>
References: <1611648234-15043-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the binding for enabling dvfsrc on MediaTek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 67 ++++++++++++++++++++++
 include/dt-bindings/interconnect/mtk,mt8183-emi.h  | 21 +++++++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
 create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
new file mode 100644
index 0000000..0b746a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/mediatek/dvfsrc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek dynamic voltage and frequency scaling resource collector (DVFSRC)
+
+description: |
+  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
+  HW module which is used to collect all the requests from both software and
+  hardware and turn into the decision of minimum operating voltage and minimum
+  DRAM frequency to fulfill those requests.
+
+maintainers:
+  - henryc.chen <henryc.chen@mediatek.com>
+
+properties:
+  reg:
+    description: DVFSRC common register address and length.
+
+  compatible:
+    enum:
+      - mediatek,mt6873-dvfsrc
+      - mediatek,mt8183-dvfsrc
+      - mediatek,mt8192-dvfsrc
+
+  '#interconnect-cells':
+    const: 1
+
+patternProperties:
+  dvfsrc-vcore:
+    type: object
+    description:
+      The DVFSRC regulator is modelled as a subdevice of the DVFSRC.
+      Because DVFSRC can request power directly via register read/write, likes
+      vcore which is a core power of mt8183. As such, the DVFSRC regulator
+      requires that DVFSRC nodes be present.
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#interconnect-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/mtk,mt8183-emi.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dvfsrc@10012000 {
+            compatible = "mediatek,mt8183-dvfsrc";
+            reg = <0 0x10012000 0 0x1000>;
+            #interconnect-cells = <1>;
+            dvfsrc_vcore: dvfsrc-vcore {
+                    regulator-name = "dvfsrc-vcore";
+                    regulator-min-microvolt = <725000>;
+                    regulator-max-microvolt = <800000>;
+                    regulator-always-on;
+            };
+        };
+    };
diff --git a/include/dt-bindings/interconnect/mtk,mt8183-emi.h b/include/dt-bindings/interconnect/mtk,mt8183-emi.h
new file mode 100644
index 0000000..dfd143f
--- /dev/null
+++ b/include/dt-bindings/interconnect/mtk,mt8183-emi.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MTK_MT8183_EMI_H
+#define __DT_BINDINGS_INTERCONNECT_MTK_MT8183_EMI_H
+
+#define MT8183_SLAVE_DDR_EMI			0
+#define MT8183_MASTER_MCUSYS			1
+#define MT8183_MASTER_GPU			2
+#define MT8183_MASTER_MMSYS			3
+#define MT8183_MASTER_MM_VPU			4
+#define MT8183_MASTER_MM_DISP			5
+#define MT8183_MASTER_MM_VDEC			6
+#define MT8183_MASTER_MM_VENC			7
+#define MT8183_MASTER_MM_CAM			8
+#define MT8183_MASTER_MM_IMG			9
+#define MT8183_MASTER_MM_MDP			10
+
+#endif
-- 
1.9.1

