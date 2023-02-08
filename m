Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF668EBA7
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 10:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBHJiu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBHJit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 04:38:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B181BE4
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 01:38:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pPguU-00039R-Hw; Wed, 08 Feb 2023 10:38:38 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pPguS-003UAX-AJ; Wed, 08 Feb 2023 10:38:37 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pPguQ-000s9i-V4; Wed, 08 Feb 2023 10:38:34 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 18/19] dt-bindings: devfreq: event: convert Rockchip DFI binding to yaml
Date:   Wed,  8 Feb 2023 10:38:29 +0100
Message-Id: <20230208093830.143284-19-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208093830.143284-1-s.hauer@pengutronix.de>
References: <20230208093830.143284-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the Rockchip DFI binding to yaml.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml  | 61 +++++++++++++++++++
 .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ------
 2 files changed, 61 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
 delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
new file mode 100644
index 0000000000000..7a82f6ae0701e
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/event/rockchip,dfi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip DFI
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3399-dfi
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk_ddr_mon
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  rockchip,pmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "PMU general register files".
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3308-cru.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      dfi: dfi@ff630000 {
+        compatible = "rockchip,rk3399-dfi";
+        reg = <0x00 0xff630000 0x00 0x4000>;
+        interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+        rockchip,pmu = <&pmugrf>;
+        clocks = <&cru PCLK_DDR_MON>;
+        clock-names = "pclk_ddr_mon";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
deleted file mode 100644
index 148191b0fc158..0000000000000
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-
-* Rockchip rk3399 DFI device
-
-Required properties:
-- compatible: Must be "rockchip,rk3399-dfi".
-- reg: physical base address of each DFI and length of memory mapped region
-- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
-- clocks: phandles for clock specified in "clock-names" property
-- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
-
-Example:
-	dfi: dfi@ff630000 {
-		compatible = "rockchip,rk3399-dfi";
-		reg = <0x00 0xff630000 0x00 0x4000>;
-		rockchip,pmu = <&pmugrf>;
-		clocks = <&cru PCLK_DDR_MON>;
-		clock-names = "pclk_ddr_mon";
-	};
-- 
2.30.2

