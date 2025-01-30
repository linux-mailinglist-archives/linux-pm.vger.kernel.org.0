Return-Path: <linux-pm+bounces-21149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B9A23336
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00267A043A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455401F0E51;
	Thu, 30 Jan 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J7fq2C8Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C91F0E4B;
	Thu, 30 Jan 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258604; cv=none; b=iZOct9GkjScCuCNZljpxJbRcftiWsTzPn7C7Ly5PRKH2ODST1Xscea3q82sjxOWRaNZP2FUtL1btFlr2J1BqZYP6x+3PJFvxL5MaKPOrXYmqLN9Q2X+6LMYJkA8rSWhPcFwb5G/xkA2Z7t5Ih6yZOAxwwcbAXzWfZG4JKYxzjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258604; c=relaxed/simple;
	bh=p3Cyb/cPLZ7SgIXfTGUhQyszzRIzj7nYuKwg8Xj4+eM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiH0BfzYaZ8YdmQEnDBRNfClZu6PzJShfQz09ifyHVHXgyPZN4zZmlYav1l6Ef7sE6Vv9RySatnXzTDwXJZF0gxz/hCTc9n1GuO++8fPIo8th4TxKIZbrpX1ja82qPglTbAwUdzQ5BUhrSO6IL4Yf+29ASnXvbvOJc8+ypuy+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J7fq2C8Z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258602; x=1769794602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p3Cyb/cPLZ7SgIXfTGUhQyszzRIzj7nYuKwg8Xj4+eM=;
  b=J7fq2C8ZJaMwe2U7Vu94xAbBr9xmz1c+CF3y0OXGz2eE2vT9FeRXft9X
   NOuUnnhQU9mYWj9TjAd4uuBykc1/LKYhtAU3rID0gxSFISswmEY0eZSVr
   0lms3LHt4hsBsrpkIkdf1605Ooehsr+SuN6My/iIzVirolYCj97oLr75a
   Oddt2zT7dCPP2U7+olblECDaAO2+loOIC6R2vs7S1oTRZplnxImh7Z8mI
   zNi82mxV1UvJponukFb5UtK0VqzrSGiNykqQ8BSOBn7+s8WVqqLMJD1Zh
   jw7lApsYNo5VFVFJVn8zVLpXMA8SMdtstmh1qm3Pbc7jzKlzxj00wfisr
   A==;
X-CSE-ConnectionGUID: GO3KDPJbR/uA3pTmQtIuSA==
X-CSE-MsgGUID: E/30LreORoCEnjpkpG7qjg==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="41090068"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:41 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:41 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 11/16] ARM: at91: pm: add DT compatible support for sama7d65
Date: Thu, 30 Jan 2025 10:33:51 -0700
Message-ID: <fb9f89b8c1a050d3600a073c31b34601e0e4a87e.1738257860.git.Ryan.Wanner@microchip.com>
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

Add support for SAMA7D65 new compatible strings in pm.c file for wakeup source
IDs and PMC.
This is the first bits of PM for this new SoC. PM depends on other patches.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
[nicolas.ferre@microchip.com: split patch and address only the pm.c changes]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/pm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 32b8354738752..a8cd1300a8f33 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -222,12 +222,14 @@ static const struct of_device_id sam9x60_ws_ids[] = {
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
 	{ .compatible = "microchip,sama7g5-rtt",	.data = &ws_info[4] },
 	{ /* sentinel */ }
@@ -1379,6 +1381,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
+	{ .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
 	{ /* sentinel */ },
 };
@@ -1672,7 +1675,7 @@ void __init sama7_pm_init(void)
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	at91_pm_init(NULL);
 
-	soc_pm.ws_ids = sama7g5_ws_ids;
+	soc_pm.ws_ids = sama7_ws_ids;
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
 
 	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);
-- 
2.43.0


