Return-Path: <linux-pm+bounces-23108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25AA483ED
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4BE1895CA4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CC26FA6F;
	Thu, 27 Feb 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P3sgPtO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13D26E966;
	Thu, 27 Feb 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671594; cv=none; b=D4Cbk/+0+a97yhyhOmbOqQpkWCjCUj6OLzjfnbyRUKZFmc5AEN58KyH1/vxCRWDLCEC4fx1amH6nvd487QpUXDaivCDkWbJ2/TTozHnCWIc6i6hu1R/d0s6IcQNhexXA0G/n6oYIfw01FzoO9ecFlV4HUCk0cXqIC+4OeiUzfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671594; c=relaxed/simple;
	bh=fGIF9yqZoL5+kzzD63s1CFCY6nJfHyqhfQ1cti4gw0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+p+QOQosar/IWjHVuR+TXqIYHxBqbCQAYqAP7zNd7+8uEnl2Q/xLeI7ubMfM9Aws12WmJDLdOvP/FxxjoZDnfRJDCxAUtJ4Yj82krXruMDqbeqjzCJCp53VkkleevRMzG4NO3FJ+oWwVyTnzjNHtWgTaQ4GxTY1NyyLy2YU15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P3sgPtO5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671592; x=1772207592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGIF9yqZoL5+kzzD63s1CFCY6nJfHyqhfQ1cti4gw0c=;
  b=P3sgPtO5IDr94EoZ0I7/SmZiz1bjU5m09O9r7RE/I20BGjpev0mfv0ki
   yGIiejC3OJG1oQ07Mj0ghUDb7fzD6H+ZNYuD+gB6r1O6AWoVnWPZTVp52
   o5aiXwAplA3vAPQXYdXgWPAkGurat3Y4y9qGxlt9yceYF3E+DifVs4/iY
   uPgJKabHf0bzuEFTBtupc0oLq2xsfJl+UuDWr64sds8Y8nKI8+fecq/cs
   zFyd65CZl7sG6araBouZBcsO3o8SEaYAzn80fmNXxtFRWkdqgne6JPLFu
   ADupn/tOW7r9Cgie6ncc57Ogy43vxdC92CSG/AvfrNfvJj2inyLJQcziK
   g==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: tQydNibLQ7q4BPYtWVKj1w==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638183"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:47 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:47 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 18/21] ARM: dts: microchip: sama7d65: Add RTC support for sama7d65
Date: Thu, 27 Feb 2025 08:52:05 -0700
Message-ID: <fa1587ffef21a8198317062c15d8eb5c3ca6187c.1740671156.git.Ryan.Wanner@microchip.com>
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

Add RTC support for the SAMA7D65 SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index aadeea132289..e623f9d22f36 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -144,6 +144,13 @@ gpbr: gpbr@e001d700 {
 			reg = <0xe001d700 0x48>;
 		};
 
+		rtc: rtc@e001d800 {
+			compatible = "microchip,sama7d65-rtc", "microchip,sam9x60-rtc";
+			reg = <0xe001d800 0x30>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 1>;
+		};
+
 		dma2: dma-controller@e1200000 {
 			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
 			reg = <0xe1200000 0x1000>;
-- 
2.43.0


