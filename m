Return-Path: <linux-pm+bounces-23114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6ABA483F6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AD63A3CEF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA7527128E;
	Thu, 27 Feb 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iQUIWICY"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6C1ADFE0;
	Thu, 27 Feb 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671609; cv=none; b=KhwhXKIpM6p44pQDv+0Qxs2Bh0vAiF5x+vSJ1iff4rrXEJA6kvpLoHIBdSD5Uap43GjcyUB0lSHmoUdGjE+R5jXTOo8ju+036HHVZpC/EfqJ0Ma+Z7t2TWtBQNYHmqBbfeGCqk+RKdEdqg9jDcF3IDDhoXkaBGze4i9K9jUyYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671609; c=relaxed/simple;
	bh=XiAlfy2hIb0teFrPDSk5k50YHK4Av/9RD2s1zu1v4Yw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M2pTYl5GVwda34MIIN11h/AD9dR/d8lYmgCkoPyQb9XUjbHHYNuCgY5Ir63rRfTWS7fVCQjF4Abr0t6ezD/YO8KJPEKvEMwfFI8/4Eu9qFg4gXDX10nUPpv4s6npL25YvDU5mfUf6/abwlRG3DgQhSXS9z6l0l6PYW7r5KlTBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iQUIWICY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671607; x=1772207607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XiAlfy2hIb0teFrPDSk5k50YHK4Av/9RD2s1zu1v4Yw=;
  b=iQUIWICYg6/H51DsojS5FIleoWmCEGd7MZcdC4h9/GXoZR8kZ7qtr8lD
   wpt1k9A2VdxPHPLf/ogH2U8uE6S8ZBayT28issKXufyzsyOQoumZFr94I
   YgSo3bzYqrRBjpJA3PZulVa7jTpOuXZPNwCF0Sva6RfXpshNeTE19M5Kh
   1cSuHpOdD5Q90b5Ec4z4ytJoGUwf5uQSYt9PCzJM7NFtzkIQ8HBaZevhH
   Z3W0P15wy/9TCb/p/PnHCV3eFu5CBkPjCDdWXHAuHwjQXWT6Je3FB2VNc
   xtRM6feOSpy6WpBw8EatQN3zzZmb8ORpuEblYvI9dcqLROPY2zQv0s9GS
   Q==;
X-CSE-ConnectionGUID: uJ81GKH9TgaiFMahOXtqRw==
X-CSE-MsgGUID: HqLtVomjSKCcqL7dRAzydg==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="42360406"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:53:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:44 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 00/21] Enable Power Modes Support for SAMA7D65 SoC
Date: Thu, 27 Feb 2025 08:51:47 -0700
Message-ID: <cover.1740671156.git.Ryan.Wanner@microchip.com>
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

Changes v1 -> v2:
- Add missing compatible for ddr3phy, it is now in both syscon sets.
- Fix alphabetical ordering for sama7d65.
- Remove the incorrect reorganizing patch.
- Remove sama7g5-rtt as a compatible for sama7d65-rtt and add
  sama7d65-rtt as a compatible wake up source in the pm driver.

Changes from v2 -> v3:
- Correct mistake in v2 sfrbu dt-binding patch.
- Correct incorrect dt-binding addition and formatting for rtc and rtt bindings.
- Add missing SoB tag.
- Cleaned up commit message for Backup mode to describe SHDWC is status
  register is cleared for this SoC.
- Cleaned up variable naming and usage for mcks. Changed the mcks number
  to the correct number of clocks needed to be saved and corrected the
  ASM code accordingly.
- Removed the SHDWC from ULP0 wake-up source as it is not configured as
  a valid wake-up source for ULP0.
- Separated all the DTSI and DTS changes into individual patches.


Li Bin (1):
  ARM: at91: pm: fix at91_suspend_finish for ZQ calibration

Ryan Wanner (20):
  dt-bindings: mfd: syscon: add microchip,sama7d65-ddr3phy
  dt-bindings: mfd: syscon: add microchip,sama7d65-sfrbu
  dt-bindings: sram: Add microchip,sama7d65-sram
  dt-bindings: power: reset: atmel,sama5d2-shdwc: Add
    microchip,sama7d65-shdwc
  dt-bindings: reset: atmel,at91sam9260-reset: add
    microchip,sama7d65-rstc
  dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
  dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
  ARM: at91: Add PM support to sama7d65
  ARM: at91: pm: add DT compatible support for sama7d65
  ARM: at91: PM: Add Backup mode for SAMA7D65
  ARM: at91: pm: Enable ULP0/ULP1 for SAMA7D65
  power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
  ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
  ARM: dts: microchip: sama7d65: Add Reset Controller to sama7d65 SoC
  ARM: dts: microchip: sama7d65: Add Shutdown controller support
  ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65
    SoC
  ARM: dts: microchip: sama7d65: Add RTC support for sama7d65
  ARM: dts: microchip: sama7d65: Add SFRBU support to sama7d65
  ARM: dts: microchip: sama7d65: Enable shutdown controller
  ARM: dts: microchip: sama7d65: Add RTT timer to curiosity board

 .../devicetree/bindings/mfd/syscon.yaml       |   4 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |   5 +
 .../reset/atmel,at91sam9260-reset.yaml        |   3 +
 .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |   4 +-
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |   1 +
 .../devicetree/bindings/sram/sram.yaml        |   1 +
 .../dts/microchip/at91-sama7d65_curiosity.dts |  13 +++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     |  77 +++++++++++++
 arch/arm/mach-at91/Kconfig                    |   1 +
 arch/arm/mach-at91/pm.c                       |  47 +++++---
 arch/arm/mach-at91/pm.h                       |   1 +
 arch/arm/mach-at91/pm_data-offsets.c          |   2 +
 arch/arm/mach-at91/pm_suspend.S               | 101 ++++++++++++++++--
 drivers/power/reset/at91-sama5d2_shdwc.c      |   1 +
 14 files changed, 238 insertions(+), 23 deletions(-)

-- 
2.43.0


