Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC42542B20
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jun 2022 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiFHJP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jun 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiFHJOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2022 05:14:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3A14AF4A;
        Wed,  8 Jun 2022 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654677459; x=1686213459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMsHNDuqgbTjLY5vpgErKx2ek8Ub6InXA9L4SIsEHGc=;
  b=Dgt9PzEA1yW40ok7+0WBWtFVPpnYQl0dYdi/ApZ/0SARyrz4gLoXyTPm
   b8SFcH3L5tX4NUmrbPfsPBtsjF0FXdmEBl4pwYszvkpERyo5EHfeaFCd4
   XWzbJeDRGtZ9/hMISQrK+OeH8rnhPIwgeDYmX5tJavdx47OdRZFniBEC+
   pS+l5dfFd6KdpjSjXNK7iirTUhw7ZEIfFHsqlu+LhwIa8fXWG//mmrcol
   +QEWrUh8OGdIuDjxXFgtW08MXKA/AiOK9ZWBB8rsw8rcqDevOmgC/yzQd
   aX4LlhixfvTKrqAiX2sV2qz485U7aqpS71BZBXiXychz3poz+rxgL3GlF
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="167235489"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:37:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:37:37 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:37:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 1/9] ARM: dts: at91: use generic name for reset controller
Date:   Wed, 8 Jun 2022 11:39:34 +0300
Message-ID: <20220608083942.1584087-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
References: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use generic name for reset controller of AT91 devices to comply with
DT specifications.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7368347c9357..9d9820db9482 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -123,7 +123,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_xtal", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7adc36ca8a46..259aca565305 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -603,7 +603,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_xtal", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index fe45d96239c9..c080df8c2312 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -151,7 +151,7 @@ tcb0: timer@fff7c000 {
 				clock-names = "t0_clk", "slow_clk";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2ab730fd6472..09794561c7ce 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -137,7 +137,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 0785389f5507..556f35ce49e3 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -126,7 +126,7 @@ pmc: pmc@fffffc00 {
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
-			rstc@fffffe00 {
+			reset-controller@fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 730d1182c73e..12c634811820 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -766,7 +766,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			rstc@fffffd00 {
+			reset-controller@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 395e883644cd..ea3b11336c79 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -134,7 +134,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			reset_controller: rstc@fffffe00 {
+			reset_controller: reset-controller@fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index c328b67bea0c..6b1d4492444a 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -667,7 +667,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "td_slck", "md_slck", "main_xtal";
 			};
 
-			reset_controller: rstc@fffffe00 {
+			reset_controller: reset-controller@fffffe00 {
 				compatible = "microchip,sam9x60-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k 0>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 89c71d419f82..60977bfd8563 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -660,7 +660,7 @@ securam: sram@f8044000 {
 				ranges = <0 0xf8044000 0x1420>;
 			};
 
-			reset_controller: rstc@f8048000 {
+			reset_controller: reset-controller@f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 8fa423c52592..2d0935ad2225 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1003,7 +1003,7 @@ pmc: pmc@fffffc00 {
 				clock-names = "slow_clk", "main_xtal";
 			};
 
-			reset_controller: rstc@fffffe00 {
+			reset_controller: reset-controller@fffffe00 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 7b9242664875..1e5c01898ccf 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -726,7 +726,7 @@ pmecc: ecc-engine@ffffc070 {
 				};
 			};
 
-			reset_controller: rstc@fc068600 {
+			reset_controller: reset-controller@fc068600 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
 				clocks = <&clk32k>;
-- 
2.33.0

