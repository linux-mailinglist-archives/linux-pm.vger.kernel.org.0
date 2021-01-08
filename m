Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC192EEE23
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbhAHHt4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 02:49:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45669 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727416AbhAHHt4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 02:49:56 -0500
X-UUID: b7c86f10e2b2425fa592af5c2827d27b-20210108
X-UUID: b7c86f10e2b2425fa592af5c2827d27b-20210108
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 921979528; Fri, 08 Jan 2021 15:48:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Jan 2021 15:48:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 15:48:19 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
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
Subject: [PATCH V7 01/13] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Fri, 8 Jan 2021 15:48:03 +0800
Message-ID: <1610092095-5113-2-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
References: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F1ECC0EEE3CA26308E40AD586395996065F407322B65FC1FD3987900641B45122000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the binding for enabling dvfsrc on MediaTek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml

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
-- 
1.9.1

