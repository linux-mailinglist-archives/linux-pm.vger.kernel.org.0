Return-Path: <linux-pm+bounces-21139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA382A2330F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6323D188746D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556E1F0E25;
	Thu, 30 Jan 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0d3j2uYB"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7771F03FF;
	Thu, 30 Jan 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258582; cv=none; b=sLF1fLwfBDpg82hPYiIZ6V52KhyLbC5hcP3jsWxJ4cK6M7kR6jrjlB66zYtjoaRBL9XWju4wIOHmwfUcV8ccTVClH7jfFGBKSuOGASQwDyB+aCCywjpWc6H3RruFBUfD90lNHN2Gj89bCW5tFSQ8Zt+Ki8iTVSZvdSklodLZbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258582; c=relaxed/simple;
	bh=yxEQ9VGHDfq2nWGMnw03UM1R+QlVtJhdj130QDeiT9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WBsCaCZ20Kshqt0WyGGZqHbzew4TfoqnnX1/vX5xZUNzqpGH0jpGUvTjvAyboZl9iZzgWYVeDOpD4/+wYJEruWDDkvM8Ij9lvfE+xnmDHNa4kXR6xLfGy62jDZm3QRwU5ip/ZaXFIsUgf99W7hU2WY8VBBvt89avKfgQga0ighY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0d3j2uYB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258581; x=1769794581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yxEQ9VGHDfq2nWGMnw03UM1R+QlVtJhdj130QDeiT9s=;
  b=0d3j2uYBtu3bL2lDk/kLZO1fj8ZCQpCQznEuxlYICrKqxt+zQ7+aYpF9
   nUVn32qLxKNZB+2NuYHNBgI4R6/sVn8unPSwYFOtwJpaFR3dJX6W1XySY
   6HPidrk1/8cNhyDHCWcHfqqDmXnx0whRT/wZlLgv3ckB+eiCri+eXHCZf
   Zhwyf6+q0HqBcwFekThUuuw6IdLI35mTH0CpFmTL+HCkoDMCHWAws7QhA
   Ppj+nECCHlr0nda5CWjWdDU9TlpRhfDN3SBYqYR2O0ZfxSK6HCcWVI/0l
   0CMOuswdQJfb4OTeNigHDDOMWITveb6y+j3udwl22gYGJSqMUctEXNu7C
   w==;
X-CSE-ConnectionGUID: Qux6TnwtQkq+U6Cg6JCAlA==
X-CSE-MsgGUID: mge+dKGoQCeO7z84WNBudA==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204623002"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:39 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:39 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 00/16] Enable Power Modes Support for SAMA7D65 SoC
Date: Thu, 30 Jan 2025 10:33:40 -0700
Message-ID: <cover.1738257860.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set adds support for low power modes for the SAMA7D65 SoC and
the required components and changes for low power modes.

The series includes changes in the asm code to account for the addtional
clocks that are in this SoC.

The Device tree additions are to enable all the components needed to
keep the SoC in low power mode.

There are some DTB check warnings but that is due to the dt-binding not
in the correct .yaml file format.


Li Bin (1):
  ARM: at91: pm: fix at91_suspend_finish for ZQ calibration

Ryan Wanner (15):
  dt-bindings: mfd: syscon: add microchip,sama7d65-ddr3phy
  dt-bindings: mfd: syscon: add microchip,sama7d65-sfrbu
  dt-bindings: sram: Add microchip,sama7d65-sram
  dt-bindings: power: reset: atmel,sama5d2-shdwc: Add
    microchip,sama7d65-shdwc
  dt-bindings: reset: atmel,at91sam9260-reset: add
    microchip,sama7d65-rstc
  dt-bindings: rtc: at91rm9200: Reorganize compatible items
  dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
  dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
  ARM: at91: Add PM support to sama7d65
  ARM: at91: pm: add DT compatible support for sama7d65
  ARM: at91: PM: Add Backup mode for SAMA7D65
  ARM: at91: pm: Enable ULP0 for SAMA7D65
  power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
  ARM: dts: microchip: sama7d65: Add Reset and Shutdown and PM support
  ARM: dts: microchip: add shutdown controller and rtt timer

 .../devicetree/bindings/mfd/syscon.yaml       |  3 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |  5 +
 .../reset/atmel,at91sam9260-reset.yaml        |  5 +
 .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |  6 +-
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |  5 +
 .../devicetree/bindings/sram/sram.yaml        |  1 +
 .../dts/microchip/at91-sama7d65_curiosity.dts | 14 +++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 77 +++++++++++++++
 arch/arm/mach-at91/Kconfig                    |  1 +
 arch/arm/mach-at91/pm.c                       | 53 +++++++---
 arch/arm/mach-at91/pm.h                       |  1 +
 arch/arm/mach-at91/pm_data-offsets.c          |  2 +
 arch/arm/mach-at91/pm_suspend.S               | 97 +++++++++++++++++--
 drivers/power/reset/at91-sama5d2_shdwc.c      |  1 +
 14 files changed, 247 insertions(+), 24 deletions(-)

-- 
2.43.0


