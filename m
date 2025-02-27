Return-Path: <linux-pm+bounces-23099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D5A483C2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE05C170DE0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E171E5206;
	Thu, 27 Feb 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oqnwrT+5"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E851D9595;
	Thu, 27 Feb 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671588; cv=none; b=C76ZLxrGuzrKJ0z6AGm/rBJ8Ly7Y0yGXTNoX8XiI2E4jvNppR7ABRvNSE4aJ9RMHybQTeTdkJlkiXNBRfhlknFOp98RtwEOL2vmcqHgf1odBWnLp3YtE382HRZ31FP7WdeYGmnKLziVe1aOK12HGuMK86cUiqOFpJFGB/eYW/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671588; c=relaxed/simple;
	bh=wQQFq0ge4xpSL3D4Ui5ubnr+T8i2ghkzGszHh+ETJUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJheMka45xAIsBHakv0PXdyM/b56XbNjzoAQp1hp7BSWz3RptP7+nbpyI9rlrRXv+cnRL8YktoK8ThFmpWQM4E5/BPlk+13dahQNSpHOhv5DQNK2cZDEpy/vjMDswfxPyuPJBfsvYkFOjOP3FQL0C8UwjlSxLZZ9JowD6QpdFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oqnwrT+5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671586; x=1772207586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQQFq0ge4xpSL3D4Ui5ubnr+T8i2ghkzGszHh+ETJUs=;
  b=oqnwrT+5LVu0RqU40Wdsj4mxDCLLWKgrZ8Qpvke4fOXQsFbloYQ+AiEv
   U0+ng/ANxZmkFYmOcKZolCr7kHQYKw5SxPdn+FCTcjHcNygytnHbRgvmx
   5lhKVtUbXfJdBBnOhV5N6fWuSo92fTo3SwiM0vvEvYWYlQv7zZzzAB7Wh
   aocGW29w7Dd5JK1Bb4WioTDA8PTkCWh+p9voA+3Hi9UH44RkVcKS4WAWZ
   hgGxkdPEhO1n7Zkra5Hdizy21lhlkt99OtcVTlkjwNkzQtiWemWZou6gH
   fiOuEjt+bHOG7I4MYAF+8/qFTPjAe2/reqYfo2sTCRT+P0GtpvnO0Rq8+
   Q==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: xx/wk7Z+S9OdJFDe6j0ySA==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638172"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:45 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:45 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 10/21] ARM: at91: pm: add DT compatible support for sama7d65
Date: Thu, 27 Feb 2025 08:51:57 -0700
Message-ID: <06b64869f2de4b499835d153411ba30512409168.1740671156.git.Ryan.Wanner@microchip.com>
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

Add support for SAMA7D65 new compatible strings in pm.c file for wakeup source
IDs and PMC.
This is the first bits of PM for this new SoC. PM depends on other patches.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
[nicolas.ferre@microchip.com: split patch and address only the pm.c changes]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 6c3e6aa22606..39644703244d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -222,13 +222,16 @@ static const struct of_device_id sam9x60_ws_ids[] = {
 	{ /* sentinel */ }
 };
 
-static const struct of_device_id sama7g5_ws_ids[] = {
+static const struct of_device_id sama7_ws_ids[] = {
+	{ .compatible = "microchip,sama7d65-rtc",	.data = &ws_info[1] },
 	{ .compatible = "microchip,sama7g5-rtc",	.data = &ws_info[1] },
 	{ .compatible = "microchip,sama7g5-ohci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
 	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
+	{ .compatible = "microchip,sama7d65-sdhci",	.data = &ws_info[3] },
 	{ .compatible = "microchip,sama7g5-sdhci",	.data = &ws_info[3] },
+	{ .compatible = "microchip,sama7d65-rtt",	.data = &ws_info[4] },
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


