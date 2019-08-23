Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9589B224
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395238AbfHWOhJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 10:37:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48504 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390787AbfHWOhI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 10:37:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B5D3200743;
        Fri, 23 Aug 2019 16:37:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D20920073F;
        Fri, 23 Aug 2019 16:37:06 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 47C3D205D9;
        Fri, 23 Aug 2019 16:37:05 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
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
        kernel@pengutronix.de, linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect properties
Date:   Fri, 23 Aug 2019 17:36:56 +0300
Message-Id: <3f27038292c09c8bf07a086eac759132c100aedb.1566570260.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566570260.git.leonard.crestez@nxp.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566570260.git.leonard.crestez@nxp.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnect-node-id property is parsed by the imx interconnect
driver to find nodes on which frequencies can be adjusted.

Add #interconnect-cells so that device drivers can request paths from
bus nodes instead of requiring a separate "virtual" node to represent
the interconnect itself.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml | 5 +++++
 Documentation/devicetree/bindings/devfreq/imx.yaml      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
index 31db204e6845..014449a9dd01 100644
--- a/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
@@ -31,10 +31,15 @@ properties:
       - const: dram_alt
       - const: dram_apb
 
   operating-points-v2: true
 
+  interconnect-node-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+  '#interconnect-cells':
+    const: 1
+
   devfreq-events:
     description: Phandle of PMU node
     $ref: "/schemas/types.yaml#/definitions/phandle"
 
 required:
diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Documentation/devicetree/bindings/devfreq/imx.yaml
index 634870496d5e..f2f9b76c752f 100644
--- a/Documentation/devicetree/bindings/devfreq/imx.yaml
+++ b/Documentation/devicetree/bindings/devfreq/imx.yaml
@@ -43,10 +43,15 @@ properties:
   clocks:
     maxItems: 1
 
   operating-points-v2: true
 
+  interconnect-node-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+  '#interconnect-cells':
+    const: 1
+
   devfreq:
     description: |
       Phandle to another devfreq device to match OPPs with by using the
       passive governor.
     $ref: "/schemas/types.yaml#/definitions/phandle"
-- 
2.17.1

