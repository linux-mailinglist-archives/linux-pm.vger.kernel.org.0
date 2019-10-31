Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7105EB9EA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 23:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJaWwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 18:52:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51514 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfJaWwV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 18:52:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DFEB2000BF;
        Thu, 31 Oct 2019 23:52:19 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EFDA2000BB;
        Thu, 31 Oct 2019 23:52:19 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 088D9205E9;
        Thu, 31 Oct 2019 23:52:18 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC v5 01/10] dt-bindings: devfreq: Add bindings for generic imx buses
Date:   Fri,  1 Nov 2019 00:52:00 +0200
Message-Id: <0e4118456f8eb67e1ba8a7c23127fc3def58547b.1572562150.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572562150.git.leonard.crestez@nxp.com>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1572562150.git.leonard.crestez@nxp.com>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial dt bindings for the interconnects inside i.MX chips.
Multiple external IPs are involved but SOC integration means the
software controllable interfaces are very similar.

Single node also acts as interconnect provider if #interconnect-cells is
present.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../devicetree/bindings/devfreq/imx.yaml      | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Documentation/devicetree/bindings/devfreq/imx.yaml
new file mode 100644
index 000000000000..bfc825407764
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/imx.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic i.MX bus frequency device
+
+maintainers:
+  - Leonard Crestez <leonard.crestez@nxp.com>
+
+description: |
+  The i.MX SoC family has multiple buses for which clock frequency (and
+  sometimes voltage) can be adjusted.
+
+  Some of those buses expose register areas mentioned in the memory maps as GPV
+  ("Global Programmers View") but not all. Access to this area might be denied
+  for normal (non-secure) world.
+
+  The buses are based on externally licensed IPs such as ARM NIC-301 and
+  Arteris FlexNOC but DT bindings are specific to the integration of these bus
+  interconnect IPs into imx SOCs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - fsl,imx8mn-nic
+          - fsl,imx8mm-nic
+          - fsl,imx8mq-nic
+        - const: fsl,imx8m-nic
+      - items:
+        - enum:
+          - fsl,imx8mn-noc
+          - fsl,imx8mm-noc
+          - fsl,imx8mq-noc
+        - const: fsl,imx8m-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  operating-points-v2: true
+
+  devfreq:
+    description: |
+      Phandle to another devfreq device to match OPPs with by using the
+      passive governor.
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+  '#interconnect-cells':
+    description: |
+      If specified then also act as an interconnect provider. Should only be
+      set once per soc on main noc.
+    const: 1
+
+  interconnect-node-id:
+    description: |
+      i.MX chips have multiple scalable buses based on the same IP, this is
+      used to distinguish between. Uses same identifier namespace as consumer
+      "interconnects" property, for example one of the values in
+      "include/dt-bindings/interconnect/imx8mm.h"
+
+    const: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    noc: noc@32700000 {
+            compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+            reg = <0x32700000 0x100000>;
+            clocks = <&clk IMX8MM_CLK_NOC>;
+            operating-points-v2 = <&noc_opp_table>;
+    };
-- 
2.17.1

