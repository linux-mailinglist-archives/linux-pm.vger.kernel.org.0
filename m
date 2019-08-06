Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED09983022
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfHFK4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 06:56:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58206 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbfHFK4C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 06:56:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 872FE1A05E6;
        Tue,  6 Aug 2019 12:55:59 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7045E1A05CE;
        Tue,  6 Aug 2019 12:55:59 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D3F4205DD;
        Tue,  6 Aug 2019 12:55:58 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv3 1/3] dt-bindings: interconnect: Add bindings for imx
Date:   Tue,  6 Aug 2019 13:55:52 +0300
Message-Id: <90561b14af66655ca859d387b3808a84641eea4e.1565088423.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565088423.git.leonard.crestez@nxp.com>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1565088423.git.leonard.crestez@nxp.com>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../devicetree/bindings/interconnect/imx.yaml | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/imx.yaml b/Documentation/devicetree/bindings/interconnect/imx.yaml
new file mode 100644
index 000000000000..c6f173b38f4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/imx.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic i.MX interconnect device
+
+maintainers:
+  - Leonard Crestez <leonard.crestez@nxp.com>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - fsl,imx8mm-interconnect
+  "#interconnect-cells":
+    const: 1
+  devfreq-names:
+    description: Names of devfreq instances for adjustable nodes
+  devfreq:
+    description: List of phandle pointing to devfreq instances
+
+required:
+  - compatible
+  - "#interconnect-cells"
+  - "devfreq-names"
+  - "devfreq"
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/imx8mm.h>
+    icc: interconnect {
+        compatible = "fsl,imx8mm-interconnect";
+        #interconnect-cells = <1>;
+        devfreq-names = "dram", "noc", "axi";
+        devfreq = <&ddrc>, <&noc>, <&pl301_main>;
+    };
-- 
2.17.1

