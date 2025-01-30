Return-Path: <linux-pm+bounces-21135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE33A232FF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1914516192D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D01F03EA;
	Thu, 30 Jan 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U4NkV5kv"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0021EF0BE;
	Thu, 30 Jan 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258556; cv=none; b=PEGvxFMEjfG9DDtKiXS0BNpdsYvrl0MKGARSAC0NA3qKXR7yAML/EUm0xjsUYeHccv+E8h8aW7ZIzDYMSEPLSD/K0sYXlgiNeV3JV6a5GA2PPMlVJLpbaHZ0f99XxVDv9xhbYHqejOXjhdPFGM7qYa6MK74GPB9HZi37TQNd3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258556; c=relaxed/simple;
	bh=wan1Nd3Bl14Mogpslj9rCJupKOyLIC//emvKCJOzmww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEVrlOkmrXZZKmO4Vy4oNkZL+Su32818nC20U+v3KS9Xltjvr17ECGeI0H9t50lJRN+Gi/Ct2fmiTvUDlxgF/LVMU+4DWgUotjLJj1j0mvPvPV6sztwo5z0HtIZ/aZpDl8GTAoEZ0RMVVlk9tQ72id6KfdfJuCf5oFbRGKCFmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U4NkV5kv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258554; x=1769794554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wan1Nd3Bl14Mogpslj9rCJupKOyLIC//emvKCJOzmww=;
  b=U4NkV5kv9LSmq5WpBSTHcnvP6yIQg556UtbVyUloZNX+C7hNwtXJmr6i
   Db8H1meqN4FsoSrlnfdtJRGDaaYg5WY7vyQE9poarVN319i3J/yPWBUm0
   xLIxlPeahHHv/OSE/rmdnhNQfeLkp8O64UairTtEF/Hpo/xzulixjIi73
   Tg/zje3y0c5A4Qm/7T9m1nS+4nrSQYnsnHTLyQbZbTpNLJ5MdgCeMtlsa
   LEkUFzUEmZh6vNmycYqxCe88Gkc32f9VM9Vgd1vlzTD2QySu2S38A8sSr
   8kCIVtqDy8Ahoc+A3jGRuELdwniRh6lZcO42XvEjKVFtNG3D0F2KmlPyQ
   A==;
X-CSE-ConnectionGUID: X8noN3xrSZmPEckyVo5bzw==
X-CSE-MsgGUID: UJXhY5GLRvWt9YKMkDMqRA==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204622974"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:35:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:42 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:42 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 15/16] ARM: dts: microchip: sama7d65: Add Reset and Shutdown and PM support
Date: Thu, 30 Jan 2025 10:33:55 -0700
Message-ID: <4c7226eb6e70ebd8fcc3e1afd0dbdf3d5a16f2a6.1738257860.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738257860.git.Ryan.Wanner@microchip.com>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add support for reset controller, wake up alarm timers, and shutdown
controller.

Add SRAM, SFR, secumod, UDDRC, and DDR3phy to enable support for low power modes.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 77 +++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 854b30d15dcd4..8e117586e5902 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -46,12 +46,42 @@ slow_xtal: clock-slowxtal {
 		};
 	};
 
+	ns_sram: sram@100000 {
+		compatible = "mmio-sram";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x100000 0x20000>;
+		ranges;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		securam: sram@e0000800 {
+			compatible = "microchip,sama7d65-securam", "atmel,sama5d2-securam", "mmio-sram";
+			reg = <0xe0000800 0x4000>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000800 0x4000>;
+			no-memory-wc;
+		};
+
+		secumod: secumod@e0004000 {
+			compatible = "microchip,sama7d65-secumod", "atmel,sama5d2-secumod", "syscon";
+			reg = <0xe0004000 0x4000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		sfrbu: sfr@e0008000 {
+			compatible ="microchip,sama7d65-sfrbu", "atmel,sama5d2-sfrbu", "syscon";
+			reg = <0xe0008000 0x20>;
+		};
+
 		pioa: pinctrl@e0014000 {
 			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";
 			reg = <0xe0014000 0x800>;
@@ -76,6 +106,31 @@ pmc: clock-controller@e0018000 {
 			clock-names = "td_slck", "md_slck", "main_xtal";
 		};
 
+		reset_controller: reset-controller@e001d100 {
+			compatible = "microchip,sama7d65-rstc", "microchip,sama7g5-rstc";
+			reg = <0xe001d100 0xc>, <0xe001d1e4 0x4>;
+			#reset-cells = <1>;
+			clocks = <&clk32k 0>;
+		};
+
+		shdwc: poweroff@e001d200 {
+			compatible = "microchip,sama7d65-shdwc", "microchip,sama7g5-shdwc", "syscon";
+			reg = <0xe001d200 0x20>;
+			clocks = <&clk32k 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			atmel,wakeup-rtc-timer;
+			atmel,wakeup-rtt-timer;
+			status = "disabled";
+		};
+
+		rtt: rtc@e001d300 {
+			compatible = "microchip,sama7d65-rtt", "microchip,sama7g5-rtt", "atmel,at91sam9260-rtt";
+			reg = <0xe001d300 0x30>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 0>;
+		};
+
 		clk32k: clock-controller@e001d500 {
 			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
 			reg = <0xe001d500 0x4>;
@@ -83,6 +138,18 @@ clk32k: clock-controller@e001d500 {
 			#clock-cells = <1>;
 		};
 
+		gpbr: gpbr@e001d700 {
+			compatible = "microchip,sama7d65-gpbr", "syscon";
+			reg = <0xe001d700 0x48>;
+		};
+
+		rtc: rtc@e001d800 {
+			compatible = "microchip,sama7d65-rtc", "microchip,sam9x60-rtc";
+			reg = <0xe001d800 0x30>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 1>;
+		};
+
 		sdmmc1: mmc@e1208000 {
 			compatible = "microchip,sama7d65-sdhci", "microchip,sam9x60-sdhci";
 			reg = <0xe1208000 0x400>;
@@ -132,6 +199,16 @@ uart6: serial@200 {
 			};
 		};
 
+		uddrc: uddrc@e3800000 {
+			compatible = "microchip,sama7d65-uddrc", "microchip,sama7g5-uddrc";
+			reg = <0xe3800000 0x4000>;
+		};
+
+		ddr3phy: ddr3phy@e3804000 {
+			compatible = "microchip,sama7d65-ddr3phy", "microchip,sama7g5-ddr3phy";
+			reg = <0xe3804000 0x1000>;
+		};
+
 		gic: interrupt-controller@e8c11000 {
 			compatible = "arm,cortex-a7-gic";
 			reg = <0xe8c11000 0x1000>,
-- 
2.43.0


