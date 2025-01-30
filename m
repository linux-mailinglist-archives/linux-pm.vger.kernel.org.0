Return-Path: <linux-pm+bounces-21148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A30A23335
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EA31610FE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E51F3D26;
	Thu, 30 Jan 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ab3k73GA"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD351F2C3D;
	Thu, 30 Jan 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258589; cv=none; b=kdoA2r78UHKIl7GzaTDwq7m1lhU218yIkdQK9ScgKPBgvp8sGZRJqK5nE1PT5/3ZjdK8WWh9EemT2pxhmYGLIoN9ku7qhQ1HnUlvLmfxVpRbkSnKchn50X7Km6OgYJV2BQCNGj2hdNI0CIS/J7giI/kQv50PbC9G5lEVFWPQn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258589; c=relaxed/simple;
	bh=tr+5ctybWd1qXbabAXHiNSfhGJo/z7RoiOi9HQGyK+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRjTcOl8tUxuNkbshcVX3FG6D3EY3W+G1m9H6wXmU/Bh/NcNEOJQIl/ouZfBFlQpSgR/j3acB0zAY8J9taqtT6OBjTHdx5V5M6jmB8gtuRuSi32pD7nO1n9fgO13K5iD2Nwp3MgLGgpdwvvpTLeuoea4sMG1HQwwgR3Rrrd+mug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ab3k73GA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258587; x=1769794587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tr+5ctybWd1qXbabAXHiNSfhGJo/z7RoiOi9HQGyK+g=;
  b=Ab3k73GAQTThsKIIdQ1Hjmmtvu0j+KRSw2LNusR8VwaJF7RFeq80ne48
   XTzt1efMKLKOo3PPbLnCYCxg78zv78Gx7xavCsk8iFRGkiv+BVQWB/PBr
   bArLxvx8OTFagzyXlxYA67ZjJauiC88UoY4ttRCDLkbuFZEyPLLxVR2Xq
   NyhMhP/u2SmWU0d42BmzYrOs7kViZNBFNzDzP7c0ZRBez5qh8C3+Nq06n
   hZkO7uygFyi5EG7YEvK9CMO3QznEaibm6UgFxYQztgaNGVar24kfLenOr
   w+FvBwO8a9y9ASxX96Cdd4FRz28yFMHMcqyqjoo8CHAFEkil3hBFf7Wox
   g==;
X-CSE-ConnectionGUID: Qux6TnwtQkq+U6Cg6JCAlA==
X-CSE-MsgGUID: QG7KiDv0SXmpwDdFB//Xow==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204623018"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
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
Subject: [PATCH 09/16] ARM: at91: Add PM support to sama7d65
Date: Thu, 30 Jan 2025 10:33:49 -0700
Message-ID: <9a57da4b20f5fa7ec84af7353cfcdb43efbff29c.1738257860.git.Ryan.Wanner@microchip.com>
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


