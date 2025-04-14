Return-Path: <linux-pm+bounces-25414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43149A88E1C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7893B6347
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE2207DEE;
	Mon, 14 Apr 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XEV9D1Pm"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FD1F3BBB;
	Mon, 14 Apr 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666932; cv=none; b=TDeSQ8+Rbw/jQJUnAmNWLPBBmoKh3uHaH9acMFGUOgUq/AQWxgbNBBPvs+TYE22TtyNwGF47Yl3sM2Aya1QiyQ1E4hoKvVqS8syuYIaFiujQ+rdl6KAhH22ZQixf/okdsXnqNpgBQi5NaMaDC7k+Lgo3vZ5lW0bjIRFxRd57GK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666932; c=relaxed/simple;
	bh=Lw4rXsYC+bu7ZWiwiV6VoaI+H0Ns4VGc7RhKmXhNrBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsDxW3XcT40MFLyqRIst0nhk5UPSPhPaKfw4lmYC0buXBmvNAWvlhNBfJLn+wUVADZW0Tuzwuecsxm/m8/IFtGAIFC1XT4lRoAbOoPbW5YGzbgRkvHvu6eqJWCnqSq24QQzwbt8alUB825PccGqNaa+VwBRzUND0tDZH7L0Snyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XEV9D1Pm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666930; x=1776202930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lw4rXsYC+bu7ZWiwiV6VoaI+H0Ns4VGc7RhKmXhNrBk=;
  b=XEV9D1Pm9G3ZNwCncO0ZBZ4LIuPniHJsunOi10qhelqh1wQ3JCzm57KC
   lgWezYfFZj++UeGjVdmiSsoYyTpdgc6mIxcyOMUwzs5G5KwkIHN9cyVBl
   KEDkYyGvD5dFYwS5NRV92/zkgwmGPogBIj9NSVuvnHqsdpQ0xxOnXAiY3
   XqSVsNNw9nphlmeQcgcUeYkczUmHECc2S5pzlUA0ICzkseiVKfZPA/9Im
   zmOxGmas/molWPA/qQEXh0gae7/EkmO12aFWkanzMq1M3hbZFkcsJ8khH
   cO1vq0AnM1Cm4vjcNFhTq9x6YSH5ilYSooqk2chTNAi7zj8PaEqbRzjtb
   A==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: hNKqRSUARQqRIMPx+wlHXw==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 14:41:06 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 14:41:06 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v5 10/11] ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65 SoC
Date: Mon, 14 Apr 2025 14:41:27 -0700
Message-ID: <e8868ef06102241b47883ba10edaed751831be6d.1744666011.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add RTT support for SAMA7D65 SoC. The GPBR is added so the SoC is able
to store the RTT time data.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 8439c6a9e9f2..bec70164a75c 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -132,6 +132,13 @@ shdwc: poweroff@e001d200 {
 			status = "disabled";
 		};
 
+		rtt: rtc@e001d300 {
+			compatible = "microchip,sama7d65-rtt", "atmel,at91sam9260-rtt";
+			reg = <0xe001d300 0x30>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 0>;
+		};
+
 		clk32k: clock-controller@e001d500 {
 			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
 			reg = <0xe001d500 0x4>;
@@ -146,6 +153,11 @@ rtc: rtc@e001d800 {
 			clocks = <&clk32k 1>;
 		};
 
+		gpbr: syscon@e001d700 {
+			compatible = "microchip,sama7d65-gpbr", "syscon";
+			reg = <0xe001d700 0x48>;
+		};
+
 		chipid@e0020000 {
 			compatible = "microchip,sama7d65-chipid";
 			reg = <0xe0020000 0x8>;
-- 
2.43.0


