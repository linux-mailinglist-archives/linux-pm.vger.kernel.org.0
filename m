Return-Path: <linux-pm+bounces-21745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62BCA2FBB9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BDD164122
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20C253F1E;
	Mon, 10 Feb 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NdGnMysp"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D212512DF;
	Mon, 10 Feb 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222060; cv=none; b=aBKlhSRxExsdct9+j8G0RABIOvk/6VIxhIGMjal0jZTtIzw3QHsW1sTMXRPosp3GsFYIcWRbJrkfryjB/AumobTw0axSnzadNCuQCws6L0aeWn5XkHxf6T+BlQlCcwhUgsrcGRVMWfJh3ZpSnJqcJtTd5xoMP/NCTU+WNp3WabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222060; c=relaxed/simple;
	bh=ra5cczy2T9srGqcmVgZ34zeo0dV1uQabrc8LGOPcaQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/unDLuDU3yqkpqvsrX6MMuFw8h/yeVLU6JjYsAeH/ZVolzHWxDdsEBqpojE8bwZN0/3H/ydq5aWSnX4XFtvBf/vWP0seua3uyf14wt6q+dPZee2sbLj3qlPj4ZbA+pbV31sES4ruAzmYLaBERebekyQk5CP5T+ayoy8nCC2xLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NdGnMysp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222058; x=1770758058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ra5cczy2T9srGqcmVgZ34zeo0dV1uQabrc8LGOPcaQM=;
  b=NdGnMysp/RFqv670haKxyW2FlsxlYe/jQkFEpKWjXAyeayia/Pu0bQbI
   w4QssGeQnzwVMt9sUzhLK8rO8Xy22nyqsh0nuC378t/qd+LX5VHODhhsO
   m5239lvSymZroD1InRwAvDL5z89WvDCYVnoldbDvtIVu1TEFoE0n/tXFC
   a0Zr2bdJTD3u/HpdcVUw1f9yXiBg47Z0Zc4eb8N8su9whU6uqRCLzSFi/
   faT3UEPE1aNqlajnzxqfEJbQs0Obfvv3FPwvDhUajucA3UPxcwqjHb571
   s7JodN8jGRmAqts2dTt97+UrXdcVdf0zmIp3TbfRNrDdGpbn1dzDrNN9j
   Q==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: 5qUHIY5QQx+D9awYMGeWFw==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027985"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:46 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:46 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 10/15] ARM: at91: pm: add DT compatible support for sama7d65
Date: Mon, 10 Feb 2025 14:13:10 -0700
Message-ID: <a35bf7aece5f43f2517f2a4082160f47ef2acb32.1739221064.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739221064.git.Ryan.Wanner@microchip.com>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add support for SAMA7D65 new compatible strings in pm.c file for wakeup source
IDs and PMC.
This is the first bits of PM for this new SoC. PM depends on other patches.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
[nicolas.ferre@microchip.com: split patch and address only the pm.c changes]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 6c3e6aa22606f..1eec68e92f8d8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -222,13 +222,16 @@ static const struct of_device_id sam9x60_ws_ids[] = {
 	{ /* sentinel */ }
 };
 
-static const struct of_device_id sama7g5_ws_ids[] = {
-	{ .compatible = "microchip,sama7g5-rtc",	.data = &ws_info[1] },
+static const struct of_device_id sama7_ws_ids[] = {
+	{ .compatible = "microchip,sama7d65-rtc",	.data = &ws_info[1] },
+	{ .compatible = "microchip,sama7g5-rtc",        .data = &ws_info[1] },
 	{ .compatible = "microchip,sama7g5-ohci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
 	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
+	{ .compatible = "microchip,sama7d65-sdhci",	.data = &ws_info[3] },
 	{ .compatible = "microchip,sama7g5-sdhci",	.data = &ws_info[3] },
+	{ .compatible = "microchip,sama7d65-rtt",       .data = &ws_info[4] },
 	{ .compatible = "microchip,sama7g5-rtt",	.data = &ws_info[4] },
 	{ /* sentinel */ }
 };
@@ -1379,6 +1382,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
+	{ .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
 	{ /* sentinel */ },
 };
@@ -1672,7 +1676,7 @@ void __init sama7_pm_init(void)
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	at91_pm_init(NULL);
 
-	soc_pm.ws_ids = sama7g5_ws_ids;
+	soc_pm.ws_ids = sama7_ws_ids;
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
 
 	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);
-- 
2.43.0


