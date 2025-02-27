Return-Path: <linux-pm+bounces-23098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1EEA483C8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB45218904E8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0741E51E5;
	Thu, 27 Feb 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tzyaJo+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0B1D5AD8;
	Thu, 27 Feb 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671588; cv=none; b=NhD0jA0EY6uDgw4HoFSJZpbLGv/CUl1qiFKs54rBz5skfqooik+HzBkt9hrtr8FxfpquTlMt/Rw3KlHQP2gvX80Eut6dWE5BPaALLM3M51rerleqSlP2nI8QO8ieKJ7HFwDca0FDMEIpOsEEsM2NCPpCw1oudbcQPdRQktfC5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671588; c=relaxed/simple;
	bh=cs/3UhGF4fHyP6gFY/pk9+aT8HWZ7VhIPV6i5KbAQ7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPctlMyWUOGdT/mXO6ml56i0X6yDM2T/67N8nCukRShdjIzJ9AtOzxWl35NmVPtzNubmqL6eOR9IuP4ShiK3dDRK0jGYy1pRU+Yhjwk4k6hieETRE7rKhP62KHBKwvmWd0dr/ozumK4HB5fGIqeABXXXusYX3rOPFb3nJW2sedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tzyaJo+K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671586; x=1772207586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cs/3UhGF4fHyP6gFY/pk9+aT8HWZ7VhIPV6i5KbAQ7U=;
  b=tzyaJo+KaXvf6nnP6gWY5jU4LmEjY7DQeuMYjv89SkT+YquB+bUs64Bd
   SUKzXpIBJ0zfvAQvb7wNfMoubRd3jgspAao+2ZMDeblHN/ggh7o1Yrqub
   xq13E5HJSLjz3LbjGWLpR48vdKJbq/sdvrF024z24EXa9So0r3dM3/wRs
   J9ap6S66fnZGButlFTJnW65S0TLo27deVORYvMDe50sHQXF4cSCjSvh1i
   wQEc2QvmnlFk5PwP52neJqwB8gcs+f2ZNgojunv1E0liPkZayIbVtE+MD
   zhuILzo38xnPgAFN4wld8q50bAp7vaJJUnSZNM7wjAgmWYwrdBxN9Q7zD
   g==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: n0AU5v85Rkye32TACpG/aA==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638170"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:56 -0700
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
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, Li Bin
	<bin.li@microchip.com>, Ryan Wanner <Ryan.Wanner@microchip.com>, "Durai
 Manickam KR" <durai.manickamkr@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH v3 09/21] ARM: at91: pm: fix at91_suspend_finish for ZQ calibration
Date: Thu, 27 Feb 2025 08:51:56 -0700
Message-ID: <28b33f9bcd0ca60ceba032969fe054d38f2b9577.1740671156.git.Ryan.Wanner@microchip.com>
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

From: Li Bin <bin.li@microchip.com>

For sama7g5 and sama7d65 backup mode, we encountered a "ZQ calibrate error"
during recalibrating the impedance in BootStrap.
We found that the impedance value saved in at91_suspend_finish() before
the DDR entered self-refresh mode did not match the resistor values. The
ZDATA field in the DDR3PHY_ZQ0CR0 register uses a modified gray code to
select the different impedance setting.
But these gray code are incorrect, a workaournd from design team fixed the
bug in the calibration logic. The ZDATA contains four independent impedance
elements, but the algorithm combined the four elements into one. The elements
were fixed using properly shifted offsets.

Signed-off-by: Li Bin <bin.li@microchip.com>
[nicolas.ferre@microchip.com: fix indentation and combine 2 patches]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Tested-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Tested-by: Andrei Simion <andrei.simion@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/pm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 05a1547642b6..6c3e6aa22606 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -545,11 +545,12 @@ extern u32 at91_pm_suspend_in_sram_sz;
 
 static int at91_suspend_finish(unsigned long val)
 {
-	unsigned char modified_gray_code[] = {
-		0x00, 0x01, 0x02, 0x03, 0x06, 0x07, 0x04, 0x05, 0x0c, 0x0d,
-		0x0e, 0x0f, 0x0a, 0x0b, 0x08, 0x09, 0x18, 0x19, 0x1a, 0x1b,
-		0x1e, 0x1f, 0x1c, 0x1d, 0x14, 0x15, 0x16, 0x17, 0x12, 0x13,
-		0x10, 0x11,
+	/* SYNOPSYS workaround to fix a bug in the calibration logic */
+	unsigned char modified_fix_code[] = {
+		0x00, 0x01, 0x01, 0x06, 0x07, 0x0c, 0x06, 0x07, 0x0b, 0x18,
+		0x0a, 0x0b, 0x0c, 0x0d, 0x0d, 0x0a, 0x13, 0x13, 0x12, 0x13,
+		0x14, 0x15, 0x15, 0x12, 0x18, 0x19, 0x19, 0x1e, 0x1f, 0x14,
+		0x1e, 0x1f,
 	};
 	unsigned int tmp, index;
 	int i;
@@ -560,25 +561,25 @@ static int at91_suspend_finish(unsigned long val)
 		 * restore the ZQ0SR0 with the value saved here. But the
 		 * calibration is buggy and restoring some values from ZQ0SR0
 		 * is forbidden and risky thus we need to provide processed
-		 * values for these (modified gray code values).
+		 * values for these.
 		 */
 		tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
 
 		/* Store pull-down output impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] = modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] = modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDO_OFF;
 
 		/* Store pull-up output impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PUO_OFF;
 
 		/* Store pull-down on-die termination impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDODT_OFF;
 
 		/* Store pull-up on-die termination impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SRO_PUODT_OFF;
 
 		/*
 		 * The 1st 8 words of memory might get corrupted in the process
-- 
2.43.0


