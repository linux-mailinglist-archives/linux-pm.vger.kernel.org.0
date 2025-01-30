Return-Path: <linux-pm+bounces-21133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514EA232F5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2931B3A531D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F071EF0A3;
	Thu, 30 Jan 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oBoSQjtt"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37421EEA3D;
	Thu, 30 Jan 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258553; cv=none; b=hkuufYAw3OiHqSAxzLcoReKtqRUTklSbnDIhfr+l1sDr1rzYg8OghYfFAk6SFd52RrU0rOV3ZvOawYpUIE1j8gS1ixJMKka6LYIcgZ/PZu0x9FHk2OrnoL5NWtYcU/IEQ+WCDNq/7SQroJn+N+ULdO3HsifzAI+EHZ8Kj+G+qLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258553; c=relaxed/simple;
	bh=nZid29reqDR3++ddySt2KOHWm8tGT444s+OSw8Gjkok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjxlWHQ7GgMvcWycAoDU98mnRlW5L2T9kbFcc5pB0Ht3zgFbsHKgDIjjJm/P1l+AEFF4bZnzPmaprjxzkXKt4nq7EvJr2HIUmG4IRljEXflRZFOBf4+/Y+3aZ3HUNlyq7KAIk7J/GPJGOmP+A9lljaX0N8AJfy+DoUY0Tn44UzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oBoSQjtt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258551; x=1769794551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZid29reqDR3++ddySt2KOHWm8tGT444s+OSw8Gjkok=;
  b=oBoSQjttMXFoeoZJnmZbhAkkN+G7D5jBQi4UxRnXqBhhVcTCXD5gjFZW
   uazlzcg2h/8sTB1MeTyqdW+x7QU1DWsw99avgUsS2DJ/A8/CYKe74tcAY
   a7m4qMwtn0Jc7g6LsZYz2hS5ejwCoJQjQznIDPQjRBARQkQt9cF7zSuHW
   B/fdPAqsZisZjN1Lmigt/lVnz117hqO7QgJj8hnGXFhIPb38eDB1GeWYk
   hGs0dLJfgeiot6Qhil+P1zv4SFmMrp3Wp/o615FcSbLX9zxepslaaP0d4
   l3sL23LXJ6EG4pWk4j3jLUvUc/7Q/Rd4OOiQNomNrV0Dale9Q+m3XcgWQ
   g==;
X-CSE-ConnectionGUID: X8noN3xrSZmPEckyVo5bzw==
X-CSE-MsgGUID: exe2a/zgRGuLm6QIj8jwtA==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204622972"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:35:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
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
Subject: [PATCH 13/16] ARM: at91: pm: Enable ULP0 for SAMA7D65
Date: Thu, 30 Jan 2025 10:33:53 -0700
Message-ID: <24544d75175c47e23eb0a89ab4c1783e191747cc.1738257860.git.Ryan.Wanner@microchip.com>
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

New clocks are saved to enable ULP0 for SAMA7D65 because this SoC has a
total of 10 main clocks that need to be saved for ULP0 mode.

Add mck_count member to at91_pm_data, this will be used to determine
how many mcks need to be saved. In the mck_count member will also make
sure that no unnecessary clock settings are written during
mck_ps_restore.

Add SHDWC to ULP0 mapping to clear the SHDWC status after exiting low
power modes.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/pm.c              | 19 +++++-
 arch/arm/mach-at91/pm.h              |  1 +
 arch/arm/mach-at91/pm_data-offsets.c |  2 +
 arch/arm/mach-at91/pm_suspend.S      | 97 ++++++++++++++++++++++++++--
 4 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5e458254e1f1c..e29c44924ac22 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -1336,6 +1336,7 @@ struct pmc_info {
 	unsigned long uhp_udp_mask;
 	unsigned long mckr;
 	unsigned long version;
+	unsigned long mck_count;
 };
 
 static const struct pmc_info pmc_infos[] __initconst = {
@@ -1343,30 +1344,42 @@ static const struct pmc_info pmc_infos[] __initconst = {
 		.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP,
 		.mckr = 0x30,
 		.version = AT91_PMC_V1,
+		.mck_count = 1,
 	},
 
 	{
 		.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
 		.mckr = 0x30,
 		.version = AT91_PMC_V1,
+		.mck_count = 1,
 	},
 	{
 		.uhp_udp_mask = AT91SAM926x_PMC_UHP,
 		.mckr = 0x30,
 		.version = AT91_PMC_V1,
+		.mck_count = 1,
 	},
 	{	.uhp_udp_mask = 0,
 		.mckr = 0x30,
 		.version = AT91_PMC_V1,
+		.mck_count = 1,
 	},
 	{
 		.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
 		.mckr = 0x28,
 		.version = AT91_PMC_V2,
+		.mck_count = 1,
 	},
 	{
 		.mckr = 0x28,
 		.version = AT91_PMC_V2,
+		.mck_count = 5,
+	},
+	{
+		.uhp_udp_mask = AT91SAM926x_PMC_UHP,
+		.mckr = 0x28,
+		.version = AT91_PMC_V2,
+		.mck_count = 10,
 	},
 
 };
@@ -1385,7 +1398,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
-	{ .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[4] },
+	{ .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[6] },
 	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
 	{ /* sentinel */ },
 };
@@ -1456,6 +1469,7 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 	soc_pm.data.uhp_udp_mask = pmc->uhp_udp_mask;
 	soc_pm.data.pmc_mckr_offset = pmc->mckr;
 	soc_pm.data.pmc_version = pmc->version;
+	soc_pm.data.pmc_mck_count = pmc->mck_count;
 
 	if (pm_idle)
 		arm_pm_idle = pm_idle;
@@ -1658,7 +1672,8 @@ void __init sama7_pm_init(void)
 		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP1, AT91_PM_BACKUP,
 	};
 	static const u32 iomaps[] __initconst = {
-		[AT91_PM_ULP0]		= AT91_PM_IOMAP(SFRBU),
+		[AT91_PM_ULP0]		= AT91_PM_IOMAP(SFRBU) |
+					  AT91_PM_IOMAP(SHDWC),
 		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SFRBU) |
 					  AT91_PM_IOMAP(SHDWC) |
 					  AT91_PM_IOMAP(ETHC),
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 53bdc9000e447..ccde9c8728c27 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -39,6 +39,7 @@ struct at91_pm_data {
 	unsigned int suspend_mode;
 	unsigned int pmc_mckr_offset;
 	unsigned int pmc_version;
+	unsigned int pmc_mck_count;
 };
 #endif
 
diff --git a/arch/arm/mach-at91/pm_data-offsets.c b/arch/arm/mach-at91/pm_data-offsets.c
index 40bd4e8fe40a5..59a4838038381 100644
--- a/arch/arm/mach-at91/pm_data-offsets.c
+++ b/arch/arm/mach-at91/pm_data-offsets.c
@@ -18,6 +18,8 @@ int main(void)
 						 pmc_mckr_offset));
 	DEFINE(PM_DATA_PMC_VERSION,	offsetof(struct at91_pm_data,
 						 pmc_version));
+	DEFINE(PM_DATA_PMC_MCK_COUNT,	offsetof(struct at91_pm_data,
+						 pmc_mck_count));
 
 	return 0;
 }
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index e5869cca5e791..2bbcbb26adb28 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -814,17 +814,19 @@ sr_dis_exit:
 .endm
 
 /**
- * at91_mckx_ps_enable:	save MCK1..4 settings and switch it to main clock
+ * at91_mckx_ps_enable:	save MCK settings and switch it to main clock
  *
- * Side effects: overwrites tmp1, tmp2
+ * Side effects: overwrites tmp1, tmp2, tmp3
  */
 .macro at91_mckx_ps_enable
 #ifdef CONFIG_SOC_SAMA7
 	ldr	pmc, .pmc_base
+	ldr	tmp3, .mck_count
 
-	/* There are 4 MCKs we need to handle: MCK1..4 */
+	/* Start at MCK1 and go until MCK_count */
 	mov	tmp1, #1
-e_loop:	cmp	tmp1, #5
+e_loop:
+	cmp	tmp1, tmp3
 	beq	e_done
 
 	/* Write MCK ID to retrieve the settings. */
@@ -850,7 +852,37 @@ e_save_mck3:
 	b	e_ps
 
 e_save_mck4:
+	cmp	tmp1, #4
+	bne	e_save_mck5
 	str	tmp2, .saved_mck4
+	b	e_ps
+
+e_save_mck5:
+	cmp	tmp1, #5
+	bne	e_save_mck6
+	str	tmp2, .saved_mck5
+	b	e_ps
+
+e_save_mck6:
+	cmp	tmp1, #6
+	bne	e_save_mck7
+	str	tmp2, .saved_mck6
+	b	e_ps
+
+e_save_mck7:
+	cmp	tmp1, #7
+	bne	e_save_mck8
+	str	tmp2, .saved_mck7
+	b	e_ps
+
+e_save_mck8:
+	cmp	tmp1, #8
+	bne	e_save_mck9
+	str	tmp2, .saved_mck8
+	b	e_ps
+
+e_save_mck9:
+	str	tmp2, .saved_mck9
 
 e_ps:
 	/* Use CSS=MAINCK and DIV=1. */
@@ -870,17 +902,19 @@ e_done:
 .endm
 
 /**
- * at91_mckx_ps_restore: restore MCK1..4 settings
+ * at91_mckx_ps_restore: restore MCKx settings
  *
  * Side effects: overwrites tmp1, tmp2
  */
 .macro at91_mckx_ps_restore
 #ifdef CONFIG_SOC_SAMA7
 	ldr	pmc, .pmc_base
+	ldr	tmp2, .mck_count
 
-	/* There are 4 MCKs we need to handle: MCK1..4 */
+	/* Start from MCK1 and go up to MCK_count */
 	mov	tmp1, #1
-r_loop:	cmp	tmp1, #5
+r_loop:
+	cmp	tmp1, tmp2
 	beq	r_done
 
 r_save_mck1:
@@ -902,7 +936,37 @@ r_save_mck3:
 	b	r_ps
 
 r_save_mck4:
+	cmp	tmp1, #4
+	bne	r_save_mck5
 	ldr	tmp2, .saved_mck4
+	b	r_ps
+
+r_save_mck5:
+	cmp	tmp1, #5
+	bne	r_save_mck6
+	ldr	tmp2, .saved_mck5
+	b	r_ps
+
+r_save_mck6:
+	cmp	tmp1, #6
+	bne	r_save_mck7
+	ldr	tmp2, .saved_mck6
+	b	r_ps
+
+r_save_mck7:
+	cmp	tmp1, #7
+	bne	r_save_mck8
+	ldr	tmp2, .saved_mck7
+	b	r_ps
+
+r_save_mck8:
+	cmp	tmp1, #8
+	bne	r_save_mck9
+	ldr	tmp2, .saved_mck8
+	b	r_ps
+
+r_save_mck9:
+	ldr	tmp2, .saved_mck9
 
 r_ps:
 	/* Write MCK ID to retrieve the settings. */
@@ -921,6 +985,7 @@ r_ps:
 	wait_mckrdy tmp1
 
 	add	tmp1, tmp1, #1
+	ldr	tmp2, .mck_count
 	b	r_loop
 r_done:
 #endif
@@ -1045,6 +1110,10 @@ ENTRY(at91_pm_suspend_in_sram)
 	str	tmp1, .memtype
 	ldr	tmp1, [r0, #PM_DATA_MODE]
 	str	tmp1, .pm_mode
+#ifdef CONFIG_SOC_SAMA7
+	ldr	tmp1, [r0, #PM_DATA_PMC_MCK_COUNT]
+	str	tmp1, .mck_count
+#endif
 
 	/*
 	 * ldrne below are here to preload their address in the TLB as access
@@ -1132,6 +1201,10 @@ ENDPROC(at91_pm_suspend_in_sram)
 	.word 0
 .pmc_version:
 	.word 0
+#ifdef CONFIG_SOC_SAMA7
+.mck_count:
+	.word 0
+#endif
 .saved_mckr:
 	.word 0
 .saved_pllar:
@@ -1155,6 +1228,16 @@ ENDPROC(at91_pm_suspend_in_sram)
 	.word 0
 .saved_mck4:
 	.word 0
+.saved_mck5:
+	.word 0
+.saved_mck6:
+	.word 0
+.saved_mck7:
+	.word 0
+.saved_mck8:
+	.word 0
+.saved_mck9:
+	.word 0
 #endif
 
 ENTRY(at91_pm_suspend_in_sram_sz)
-- 
2.43.0


