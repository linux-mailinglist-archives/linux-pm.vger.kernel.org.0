Return-Path: <linux-pm+bounces-23104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7AA483D7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F048A1685FF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920226E636;
	Thu, 27 Feb 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r/WtbwDQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EA26B975;
	Thu, 27 Feb 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671591; cv=none; b=iaSOB0+o7YxdQizhY3fTXMgld/R8fvZdZXisYOBVOpndsqrwS0u7JyUcs0gDHjd1lDzUzcv8sVSr+2NjgqoDb+X67a0SYxz83YUmew7A3h50EucYLyNCVWk5+YNZ+kpD1I4OeJDIN3GJnPCWnk1xOKij+onYYtyTVVsgPPqg/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671591; c=relaxed/simple;
	bh=FqFmeojqTK+deQ4FOgVDuvvMDBOUq3qMFO0P9+tUytQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqPdUSlWJv2BsMTofUFa59KXmtuah3tHheCanghVkh5zrCuCOAnp9PXBkb2w7nQuzQf+/i56bah3QKYHxAE2/8eRJCFkCHRGiSaaxcZIif3/C+bKcBnP/GCS6UY7MsOxLHNkYc4HXrav78uT/R6vXRSqpNSttAlHwqh45PKAGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r/WtbwDQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671589; x=1772207589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqFmeojqTK+deQ4FOgVDuvvMDBOUq3qMFO0P9+tUytQ=;
  b=r/WtbwDQCqGzp2ABFCjVOpk5oT5IXOFFlVfwBBBqKZVImvP9qDcjhjt2
   JNNJUC/nbELuV33jX2f6G4upSHSJpGt9p3XH/sik0O6gdg56SjsLh1NEc
   XhQS1mc9ltWCb263+Bn/K4jCzn8VjJNLr07lo1CVnytAyauoW/O8Puf79
   Sssb/H66WeUBsKh7glZoes0AZMoaCBmW4CmHFBQQocv6/xLsReCrriWyw
   bYslhVxZ8Jl4JUX+jPMFa4Kiae4zf2rU5iyQJWn0BuDVJwVLmRNtVn/jS
   w0DynU2Fq9pl2QOd3/CmoSbeFju2OJ+a81hT3zOq+86QmenMN1OizFsMv
   w==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: b83FHUnIRLOi9QLdwLO/vQ==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638179"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:46 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:46 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 14/21] ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
Date: Thu, 27 Feb 2025 08:52:01 -0700
Message-ID: <ab4002faa1b672023ffc97bf91755720508c275e.1740671156.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SRAM, secumod, UDDRC, and DDR3phy to enable support for low power modes.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 92a5347e35b5..c10cc3558efd 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -47,12 +47,37 @@ slow_xtal: clock-slowxtal {
 		};
 	};
 
+	ns_sram: sram@100000 {
+		compatible = "mmio-sram";
+		reg = <0x100000 0x20000>;
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
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
+			ranges = <0 0xe0000800 0x4000>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
+			#address-cells = <1>;
+			#size-cells = <1>;
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
 		pioa: pinctrl@e0014000 {
 			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";
 			reg = <0xe0014000 0x800>;
@@ -190,6 +215,16 @@ i2c10: i2c@600 {
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


