Return-Path: <linux-pm+bounces-21743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AFA2FBAE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775993A4D39
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FA2512EA;
	Mon, 10 Feb 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ex+mAjaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2522505DF;
	Mon, 10 Feb 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222057; cv=none; b=UMy6Eu2nbEuaaswrbpj9g8vHpYddSIyuRlU7gehbWKjCJsc8C9mf8o6yYY03Nfu0NwI2PYDQvcY6R7P8aiOrDvMKqasQ8//x3WPAr6FAdj47KuThQ53PisDVHEeMtnAhwlrwPeTq4VkrOLsbNZfzPjorioxPb6Cv9wI3l2DkoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222057; c=relaxed/simple;
	bh=tr+5ctybWd1qXbabAXHiNSfhGJo/z7RoiOi9HQGyK+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK4BoxdhYZtz0X6Z10hF9GMt21mzDEe8HRo1VYg70KTwpR7K7HZ+/x1WLXtYrqot1ZzrLMaaKfsD531GTSL3mHkXJHKy6ApOxh4qDxfd4UOGhf9YBj9LY5kSRo6NzedrM4Oh7bwgaU/cGEnsqRJBlTc7LEA5B1tTUKBusCUANZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ex+mAjaA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222056; x=1770758056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tr+5ctybWd1qXbabAXHiNSfhGJo/z7RoiOi9HQGyK+g=;
  b=Ex+mAjaALjWKR3lPikS2fgPxRsh3wjUKFqEAk+yEewrHmfsQfq78BV0c
   VQMActTDa9V0zAxRaGaIJmDpvf1EJDuQPUDNL8UHlSy3Qf6Yuo8zuBR/u
   6+3/J5nByTmNKiklfaF+nLcp6+vviARy7ObDHRsAC98fVdasoD03y0eQa
   XLOs2C3dFT+N2PUJSN1LH0IpWAKDuipdS1Ve7fPts9P8gwdfyVNyKAaBn
   dseflt4cpBlN+AWn5mc6mjIWUbjwSdunknVdNJXWD76obWMTTyTPb6WUS
   gzFwC2DeV2c0xvedBEbv2RdiSnoFHQNI3Kmp/9rj4zd1kdAPpL4Dd4aT5
   g==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: 3/XXqYBWQPeiFfEj3UQroQ==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027980"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:05 -0700
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
Subject: [PATCH v2 08/15] ARM: at91: Add PM support to sama7d65
Date: Mon, 10 Feb 2025 14:13:08 -0700
Message-ID: <2bb7550c7f7bd573abcbaf6060ea3a0b59117e4c.1739221064.git.Ryan.Wanner@microchip.com>
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

Add PM support to SAMA7D65 SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 04bd91c72521c..f3ff1220c0fb0 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -65,6 +65,7 @@ config SOC_SAMA7D65
 	select HAVE_AT91_SAM9X60_PLL
 	select HAVE_AT91_USB_CLK
 	select HAVE_AT91_UTMI
+	select PM_OPP
 	select SOC_SAMA7
 	help
 	  Select this if you are using one of Microchip's SAMA7D65 family SoC.
-- 
2.43.0


