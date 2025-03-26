Return-Path: <linux-pm+bounces-24523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D062A71AD0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ACE3B9A5B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997E1F9ED2;
	Wed, 26 Mar 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xxi7jqLP"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83181F78F2;
	Wed, 26 Mar 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003404; cv=none; b=fcbFXuRidgnp5XJoeaGjY96GrHBzVpvs47T9JQ44wpEtaOKppqm6FkZ9GmPZSA2hcBIcQIOTFJovS699V8xgnh+MwZv7/OPqy+uVri8QZfxwyYGxGdoYUSCw9+APTwBxkJprbagY4hHLeuF5Ja8/A9MGHg2hWby1ybZDtW8WDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003404; c=relaxed/simple;
	bh=BNmi5f64ZyoDoOV4MWGFQZk1PJoI5qBvg1EBNPuzEmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBipY/Osbb09104d2YXs+DEfn3iT3xQ5BBj0/C74W3Tt8LVem4PN7EmVumPB7bcvayuwy02IKa/OQnj4ifwE1OfQAVshH+vmOkr/ZtMVGfkHli6hpyYCtOPuosNUYSn1j5AszPLZ2RVJPyLS48JOW0aFSZUDqg4QkHFCC0FDX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xxi7jqLP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003402; x=1774539402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNmi5f64ZyoDoOV4MWGFQZk1PJoI5qBvg1EBNPuzEmg=;
  b=Xxi7jqLP2Kq/t4L2G+VAGxs9ak6ml7NbxCiJEeh1eF7C+YUgrVD2b7fh
   aw7ZShEani4tJ2TDwCCFywr63muvebLFW7b5Or/6PY/2mizlpiLDslPDr
   Plf1lXLgh4uVLYw91fYnAsNl65IM3nK13yphu+NM55TKa6whMzLT5god0
   cF7uEQmYKjWxaHugFXt1e30YkRiPEeaHoZ5sW+aARLuWJGVl+F81MxBmM
   HuFvrs8ZueR3wqq2K6s46hB1ZGB2qFE51thFqJE+QG4XXEanRb0UPBabU
   nyhaJxUGTUgguYrM5rqKQzKfVXe884X2pBm+XGxoeyvoXLWBDTkV6bjfr
   g==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: f9DUSKXSTSaAuvdcfD2xCQ==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096112"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:52 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:52 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 09/11] ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
Date: Wed, 26 Mar 2025 08:35:42 -0700
Message-ID: <96c1240e8d77d7a4dad6291220e65b4b708db616.1742936082.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
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
index b6710ccd4c36..7d71e7326e3a 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -47,6 +47,14 @@ slow_xtal: clock-slowxtal {
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
@@ -58,6 +66,23 @@ sfrbu: sfr@e0008000 {
 			reg = <0xe0008000 0x20>;
 		};
 
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
@@ -227,6 +252,16 @@ i2c10: i2c@600 {
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


