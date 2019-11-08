Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF791F5B10
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 23:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfKHWkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 17:40:16 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57162 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfKHWkQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 17:40:16 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B6DFB2003F6;
        Fri,  8 Nov 2019 23:40:12 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A926520076F;
        Fri,  8 Nov 2019 23:40:12 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 99BEC205CD;
        Fri,  8 Nov 2019 23:40:11 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/6] dt-bindings: memory: Add bindings for imx8m ddr controller
Date:   Sat,  9 Nov 2019 00:39:53 +0200
Message-Id: <9c52a0415ede0d9fbf2b651b2185d2f28c70b467.1573252696.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573252696.git.leonard.crestez@nxp.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1573252696.git.leonard.crestez@nxp.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree bindings for the i.MX DDR Controller on imx8m series
chips. It supports dynamic frequency switching between multiple data
rates and this is exposed to Linux via the devfreq subsystem.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../memory-controllers/fsl/imx8m-ddrc.yaml    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
new file mode 100644
index 000000000000..ac06d7595143
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/fsl/imx8m-ddrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX8M DDR Controller
+
+maintainers:
+  - Leonard Crestez <leonard.crestez@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - fsl,imx8mn-ddrc
+        - fsl,imx8mm-ddrc
+        - fsl,imx8mq-ddrc
+      - const: fsl,imx8m-ddrc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: core
+      - const: pll
+      - const: alt
+      - const: apb
+
+  operating-points-v2: true
+  opp-table: true
+
+  devfreq-events:
+    description: Phandle of PMU node
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - reg
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    ddrc: dram-controller@3d400000 {
+        compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
+        reg = <0x3d400000 0x400000>;
+        clock-names = "core", "pll", "alt", "apb";
+        clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
+                 <&clk IMX8MM_DRAM_PLL>,
+                 <&clk IMX8MM_CLK_DRAM_ALT>,
+                 <&clk IMX8MM_CLK_DRAM_APB>;
+        operating-points-v2 = <&ddrc_opp_table>;
+    };
-- 
2.17.1

