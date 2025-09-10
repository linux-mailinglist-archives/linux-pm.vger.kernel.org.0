Return-Path: <linux-pm+bounces-34385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78533B51D73
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17031B2737F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA07265296;
	Wed, 10 Sep 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nETLaO+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B420E030;
	Wed, 10 Sep 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521354; cv=none; b=uauihxhhW36QvcIbEtAnlc0jYDpnk5ivexI0zI/ttP7h5HOzXrijfLj4QftF+npgIcMm8oahJ2KLf1VQLrDnMEVppyjhN8WPKhYy4Qa5kSCov6OZ1AEAuvedL7IXlCejG/mytxH62509PcBYa5YR4e96MVvulxeBOPdvAxZG4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521354; c=relaxed/simple;
	bh=OA697MSbwYFaga1yasvj23HlhhxErDH/zxQeYPOWGmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+x8VbauVob4ll4+LtbX87Hout0QN8/PCu32rXaiU39CdH6Ed1+BEjeB4yzSSg4+fQ4HDqkAgAKBs0mfW/BMVvEUUJtDJkxX9wcArPYz7jAvcnXvielSiwJHtcnjGfU+e/OsBBHVzJvHW+AF9H/mPi8I+/7T8IHNtalh+3UsOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nETLaO+O; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757521352; x=1789057352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OA697MSbwYFaga1yasvj23HlhhxErDH/zxQeYPOWGmE=;
  b=nETLaO+Of0l/+cWjZWUDkqcViJLV2y09vFw4cF/4xKmaLqdXkosVviOq
   I6gOVKkrE8hcZf9C0IDKpvyFg7VaN81gj2JuhREo+szgtXJV3tY3nXVCu
   Hcf1dEIqg/o38i8GWGjSr3URLUQvc61gL3VK6oRRRmb3Lr5GGSAN9bfMU
   aIDAFkukDGrtfvzuEccjm8LYvMsetJDW9n3c92VtYdy4+dM4PAuRJMB3W
   oAhqNtsi3HP5HslRCo4ISBU3NMGZK+ITOBwY2v0edinAaqkTdkzPGFW5G
   /BKEAoNDFV0qkI1VWo8fgA3cmgX5MTkD7wq1dzbpa8S0c5XfSFtqGmaJ0
   g==;
X-CSE-ConnectionGUID: tPE+SbpaSyCyxVMbhLqdoA==
X-CSE-MsgGUID: +YSUaQIrRSOq/S/Erz+hxg==
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="213715732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2025 09:22:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 10 Sep 2025 09:22:11 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 10 Sep 2025 09:22:11 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH 3/4] ARM: at91: pm: Remove 2.5V regulator
Date: Wed, 10 Sep 2025 09:20:38 -0700
Message-ID: <a6785a40648b315a07152bca261a42bbf0f356af.1757519351.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519351.git.Ryan.Wanner@microchip.com>
References: <cover.1757519351.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Remove 2.5V regulator since enabling and disabling this regulator is no
longer supported.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 29 -----------------------------
 include/soc/at91/sama7-sfrbu.h  |  7 -------
 2 files changed, 36 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 198236bdbbb3..36cae7b1a490 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -87,29 +87,6 @@ tmp3	.req	r6
 
 	.endm
 
-/**
- * Set state for 2.5V low power regulator
- * @ena: 0 - disable regulator
- *	 1 - enable regulator
- *
- * Side effects: overwrites r7, r8, r9, r10
- */
-	.macro at91_2_5V_reg_set_low_power ena
-#ifdef CONFIG_SOC_SAMA7
-	ldr	r7, .sfrbu
-	mov	r8, #\ena
-	ldr	r9, [r7, #AT91_SFRBU_25LDOCR]
-	orr	r9, r9, #AT91_SFRBU_25LDOCR_LP
-	cmp	r8, #1
-	beq	lp_done_\ena
-	bic	r9, r9, #AT91_SFRBU_25LDOCR_LP
-lp_done_\ena:
-	ldr	r10, =AT91_SFRBU_25LDOCR_LDOANAKEY
-	orr	r9, r9, r10
-	str	r9, [r7, #AT91_SFRBU_25LDOCR]
-#endif
-	.endm
-
 /*
  * Set LPM
  * @ena: 0 - disable LPM
@@ -1055,9 +1032,6 @@ save_mck:
 
 	at91_plla_disable
 
-	/* Enable low power mode for 2.5V regulator. */
-	at91_2_5V_reg_set_low_power 1
-
 	ldr	tmp3, .pm_mode
 	cmp	tmp3, #AT91_PM_ULP1
 	beq	ulp1_mode
@@ -1070,9 +1044,6 @@ ulp1_mode:
 	b	ulp_exit
 
 ulp_exit:
-	/* Disable low power mode for 2.5V regulator. */
-	at91_2_5V_reg_set_low_power 0
-
 	ldr	pmc, .pmc_base
 
 	at91_plla_enable
diff --git a/include/soc/at91/sama7-sfrbu.h b/include/soc/at91/sama7-sfrbu.h
index 76b740810d34..8cee48d1ae2c 100644
--- a/include/soc/at91/sama7-sfrbu.h
+++ b/include/soc/at91/sama7-sfrbu.h
@@ -18,13 +18,6 @@
 #define		AT91_SFRBU_PSWBU_SOFTSWITCH	(1 << 1)	/* Power switch BU source selection */
 #define		AT91_SFRBU_PSWBU_CTRL		(1 << 0)	/* Power switch BU control */
 
-#define AT91_SFRBU_25LDOCR			(0x0C)		/* SFRBU 2.5V LDO Control Register */
-#define		AT91_SFRBU_25LDOCR_LDOANAKEY	(0x3B6E18 << 8)	/* Specific value mandatory to allow writing of other register bits. */
-#define		AT91_SFRBU_25LDOCR_STATE	(1 << 3)	/* LDOANA Switch On/Off Control */
-#define		AT91_SFRBU_25LDOCR_LP		(1 << 2)	/* LDOANA Low-Power Mode Control */
-#define		AT91_SFRBU_PD_VALUE_MSK		(0x3)
-#define		AT91_SFRBU_25LDOCR_PD_VALUE(v)	((v) & AT91_SFRBU_PD_VALUE_MSK)	/* LDOANA Pull-down value */
-
 #define AT91_FRBU_DDRPWR			(0x10)		/* SFRBU DDR Power Control Register */
 #define		AT91_FRBU_DDRPWR_STATE		(1 << 0)	/* DDR Power Mode State */
 
-- 
2.43.0


