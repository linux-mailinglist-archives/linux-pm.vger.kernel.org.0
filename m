Return-Path: <linux-pm+bounces-23100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4460A483CE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930BB188A57A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514626B96C;
	Thu, 27 Feb 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QFRY+Fi3"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBE1A5B99;
	Thu, 27 Feb 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671588; cv=none; b=lmovuGDNXEPgBto1Ub8BuYoyCuiO0r+okOW6QsFSDoFB0DBeNMAK2L1gauGk7PjCfsQVfUarBIhGJK9tP+Ek+6MZWDOdztbYwWKaCcZuTJKe9eNOfB/CxhB3MEuDcKwMH5Cb5MHamoGWl/lhkZAKqSuwXLwNPIuFI3o3WDMcYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671588; c=relaxed/simple;
	bh=gcjRK2iA7G5Y9xRymwaWG/RlPc2FbREDTowEmIyMkRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No+ZztPWBh3TUEYWk/pR1sG9U6PHu4iHLsW4BuUqLQ7iA1CqpOO2cMcTf5q4+TOPOhuX686gmtf1mED1iza5GcdTDbLgIq3cMYb+/OEyKeYDt6OpaOntnhqWsXnnojeo5UIAxP4KDdupYWgKSngVu2xUD8fYt+rApjT1cdczck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QFRY+Fi3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671587; x=1772207587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcjRK2iA7G5Y9xRymwaWG/RlPc2FbREDTowEmIyMkRk=;
  b=QFRY+Fi3ymFD9YSPGzlC9pxNmtUhMR+voGaXScEx3tYIxruZwncKh1Rz
   VPu5ghqpZaPiW5RG0oEjSxxuLwEXskkmAOnsn6WXNIyEXOfGUOHxjtMDh
   wVCHOVmEWpRWWROp/mRmuCR9CnZgLSZ7j2Kv40uySnj9tqyuSd7jAk73Z
   eoGaySTmwGfLggTn49yq/3quW+5luoyO4vF8GRRDvy0ZunBHK+IJL5tjh
   Mc30NOV3KJdeaM/hTsch3JFOQhAkV7dWlqQAHYfw/vvMRIjfUSL5huLNb
   9AL1H5AkcJpkIPnCNPoBhlTc1ZCvOGayCl81mz3505MrlLIACGEOg4At3
   w==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: 3DE/RfGkTuK0eY13l8gwXQ==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638174"
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
Subject: [PATCH v3 11/21] ARM: at91: PM: Add Backup mode for SAMA7D65
Date: Thu, 27 Feb 2025 08:51:58 -0700
Message-ID: <3a1f59af1ac9322b0203694b535d5d13120a31eb.1740671156.git.Ryan.Wanner@microchip.com>
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

Add config check that enables Backup mode for SAMA7D65 SoC.

Add SHDWC_SR read to clear the status bits once finished exiting backup
mode. This is only for SAMA7D65 SoCs. The SHDWC status register
needs to be cleared after exiting backup mode to clear the wake up pin
status.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 39644703244d..d82a507bc8da 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -647,6 +647,11 @@ static void at91_pm_suspend(suspend_state_t state)
 		at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
 					     &at91_pm_suspend_in_sram,
 					     at91_pm_suspend_in_sram_sz);
+
+		if (IS_ENABLED(CONFIG_SOC_SAMA7D65))
+			/* SHDWC.SR */
+			readl(soc_pm.data.shdwc + 0x08);
+
 	} else {
 		at91_suspend_finish(0);
 	}
@@ -707,6 +712,7 @@ static int at91_pm_enter(suspend_state_t state)
 static void at91_pm_end(void)
 {
 	at91_pm_config_ws(soc_pm.data.mode, false);
+
 }
 
 
@@ -1065,7 +1071,8 @@ static int __init at91_pm_backup_init(void)
 	int ret = -ENODEV, located = 0;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2) &&
-	    !IS_ENABLED(CONFIG_SOC_SAMA7G5))
+	    !IS_ENABLED(CONFIG_SOC_SAMA7G5) &&
+	    !IS_ENABLED(CONFIG_SOC_SAMA7D65))
 		return -EPERM;
 
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
-- 
2.43.0


