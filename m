Return-Path: <linux-pm+bounces-21735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4FA2FB90
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7887A1309
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567324C666;
	Mon, 10 Feb 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZCmQHn16"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDF264634;
	Mon, 10 Feb 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222051; cv=none; b=ZYqmni5xE64Ak46QzhBjtqV97nKyykBbuOSMBCzvWLvV20V1Msdj2bA/6udMx2zkiwkZXff2h/WAnNHKhE4aTIbP79yqTREavt7tLvqzL8Dy0gbDQMiox2nkQcA+XB+8Af1TkVbTjcu840o2KmOL30IzVBenXf+iKQCHt6I1Jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222051; c=relaxed/simple;
	bh=41SDJqeOvWQc658it1sXNAN/P9R8aH989E9RDDpERWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T1LcTcSuh6goaA8x579E50AGBYEEA8fYAnC7jUnYQu1P8kpIdNgTFZ3WNxtInfgYx620EzI+j8GnnwAZf8pZd/V4hRI5BLwxtaOh250f8ZkqAHMGnnTnWOMQqOKZmBuxcMYkTXFlvqr4rLe/8FzmkGd1LKSvVXkOZVnKBC9AsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZCmQHn16; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222050; x=1770758050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=41SDJqeOvWQc658it1sXNAN/P9R8aH989E9RDDpERWg=;
  b=ZCmQHn16m31iF71sVc6PQZAecx16XZUnV/CDxsZygYvk7X1TNb+LYobl
   /4xX4leDmaNW8YI0qMeHAVu7HZSfRIK8r6k4jWe4Rd9NGdccnl02fNzIc
   fyeTpWJd+SfFgtvsrgvLLkuHr6+T/qDOj5TSJOz/fkdCFXrCUMHwdPInX
   Q6xxrNMsW2+CBqsra5I2DxXG4k3hRe/HMl4w2t/Th/s+IS7QQon6/nd+f
   xd/3/HFzZ/A9522yZORgTeGNqbcc3fIRNZzI2tOfurIDlfx+TCvNlZjLB
   yeX+1jlF8cX/5ZKcHZyEpnJUmfGkh97cH7SFkNEveTFK2PS3WykdK4C1Z
   A==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: 0K7I9XjESoy6ucluOHAdrA==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027961"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:45 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:45 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 00/15] Enable Power Modes Support for SAMA7D65 SoC
Date: Mon, 10 Feb 2025 14:13:00 -0700
Message-ID: <cover.1739221064.git.Ryan.Wanner@microchip.com>
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

Li Bin (1):
  ARM: at91: pm: fix at91_suspend_finish for ZQ calibration

Ryan Wanner (14):
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
  ARM: at91: pm: Enable ULP0 for SAMA7D65
  power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
  ARM: dts: microchip: sama7d65: Add Reset and Shutdown and PM support
  ARM: dts: microchip: add shutdown controller and rtt timer

 .../devicetree/bindings/mfd/syscon.yaml       |  3 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |  5 +
 .../reset/atmel,at91sam9260-reset.yaml        |  5 +
 .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |  3 +
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |  3 +
 .../devicetree/bindings/sram/sram.yaml        |  1 +
 .../dts/microchip/at91-sama7d65_curiosity.dts | 14 +++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 77 +++++++++++++++
 arch/arm/mach-at91/Kconfig                    |  1 +
 arch/arm/mach-at91/pm.c                       | 54 ++++++++---
 arch/arm/mach-at91/pm.h                       |  1 +
 arch/arm/mach-at91/pm_data-offsets.c          |  2 +
 arch/arm/mach-at91/pm_suspend.S               | 97 +++++++++++++++++--
 drivers/power/reset/at91-sama5d2_shdwc.c      |  1 +
 14 files changed, 245 insertions(+), 22 deletions(-)

-- 
2.43.0


