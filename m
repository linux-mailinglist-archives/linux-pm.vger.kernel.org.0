Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4350B1935A5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 03:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCZCQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 22:16:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52626 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgCZCQ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 22:16:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C2FD1200776;
        Thu, 26 Mar 2020 03:16:26 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B3654200775;
        Thu, 26 Mar 2020 03:16:26 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A31CB203CD;
        Thu, 26 Mar 2020 03:16:25 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Martin Kepplinger <martink@posteo.de>
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/8] dt-bindings: interconnect: Add bindings for imx8m noc
Date:   Thu, 26 Mar 2020 04:16:13 +0200
Message-Id: <b7a93b75a3ea57aadeeda766a0b729a4bc97ccc9.1585188174.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial dt bindings for the interconnects inside i.MX chips.
Multiple external IPs are involved but SOC integration means the
software controllable interfaces are very similar.

Main NOC node acts as interconnect provider if #interconnect-cells is
present. Currently there is a single imx interconnect provider for the
whole SOC.

Other pieces of scalable interconnects can be present, each with their
own OPP table.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../bindings/interconnect/fsl,imx8m-noc.yaml  | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
new file mode 100644
index 000000000000..6c192f1c0edd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/fsl,imx8m-noc.yaml#
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
+      - const: fsl, imx8m-nic
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table: true
+
+  fsl,ddrc:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description:
+      Phandle to DDR Controller.
+
+  '#interconnect-cells':
+    description:
+      If specified then also act as an interconnect provider. Should only be
+      set once per soc on the main noc.
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
+#include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/interconnect/imx8mm.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+noc: interconnect@32700000 {
+        compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+        reg = <0x32700000 0x100000>;
+        clocks = <&clk IMX8MM_CLK_NOC>;
+        #interconnect-cells = <1>;
+
+        /* Used to make requests for DEV_PM_QOS_MIN_FREQUENCY: */
+        fsl,scalable-node-ids = <IMX8MM_ICN_NOC>,
+                                <IMX8MM_ICN_MIPI>,
+                                <IMX8MM_ICS_DRAM>;
+        fsl,scalable-nodes = <&noc>,
+                             <&pl301_mipi>,
+                             <&ddrc>;
+
+        /* For passive governor: */
+        devfreq = <&ddrc>;
+
+        operating-points-v2 = <&noc_opp_table>;
+        noc_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-133M {
+                        opp-hz = /bits/ 64 <133333333>;
+                };
+                opp-800M {
+                        opp-hz = /bits/ 64 <800000000>;
+                };
+        };
+};
+
+pl301_mipi: interconnect@32500000 {
+        compatible = "fsl,imx8m-nic";
+        reg = <0x32500000 0x100000>;
+        clocks = <&clk IMX8MM_CLK_DISP_AXI>;
+        operating-points-v2 = <&pl301_mipi_opp_table>;
+
+        pl301_mipi_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-200M {
+                        opp-hz = /bits/ 64 <200000000>;
+                };
+                opp-500M {
+                        opp-hz = /bits/ 64 <500000000>;
+                };
+        };
+};
+
+ddrc: memory-controller@3d400000 {
+        compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
+        reg = <0x3d400000 0x400000>;
+        glock-names = "core", "pll", "alt", "apb";
+        clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
+                 <&clk IMX8MM_DRAM_PLL>,
+                 <&clk IMX8MM_CLK_DRAM_ALT>,
+                 <&clk IMX8MM_CLK_DRAM_APB>;
+        /* For ondemand governor: */
+        devfreq-events = <&ddr_pmu>;
+};
+
+ddr_pmu: ddr-pmu@3d800000 {
+        compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
+        reg = <0x3d800000 0x400000>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1

