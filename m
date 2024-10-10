Return-Path: <linux-pm+bounces-15448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531A998578
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F601C236B6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322811C3F3D;
	Thu, 10 Oct 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kRyuM1SB"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEC18FDBE;
	Thu, 10 Oct 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561758; cv=none; b=VjH26S4W/elz9ClN7Jg3J4Pw3j3ss6F5jpfIgdioObP2vea95NGE+yGKl9GQhCsnAQGhBhukhtp4GxoZrrcAmKwQ4HdOGZGfFvpd4l4mZASi3ed3hSK7airUgUI4qb5jM5jOvB48/i1EBATcpttbQGPsSK3vspKKVsmOyvfvjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561758; c=relaxed/simple;
	bh=68PLVgZztHKJSdcs8OgU0ydTUNTRkFpa2xwbnZuTHOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVqf4GXqKYEaQLJ+YcQHt1NPzVMigsHTyHJ/rKDfr1Cc9zuYT4aD3dNPndfZ1kePhX5ZRx1irj0GpT+6q/y23giazefEGkzLqjNezlyx8MZlnlFR4mq0dHgas2KIgPPvtSx10Avji5j+JtC6MgRgvOVHmlx17Wciz5CMT7hyz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kRyuM1SB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561756; x=1760097756;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=68PLVgZztHKJSdcs8OgU0ydTUNTRkFpa2xwbnZuTHOE=;
  b=kRyuM1SBb71zVblKj2egi6hod37oZ7Gw1L4Jq7EbnnlfeuMgwwwfL10j
   tGJ51PbTToehyZAOq5iczej/GZEYovYh4pRZYWCxtx1nfBrkIwHAWdX9k
   /lv+T/lY/qCGZwt3vGbTRxZ0GDYsHw5lx4jw2/JONfVyXEzAeKpq8Q5VX
   yS27hLFBinOhsAct74NmJjW7riujUXojleEIOL1H91HVVbIKFulHbx142
   pjH2PqrOLolc8/06HMwN7lg0/mRyHm6PYQZTBe99dmPjgiRkS4orxnTPa
   kzrTlyVizzLVC6QBZsKiXtYv7EPoCSbEj21IXvQgFA+8TUpEm1OPAjuOy
   g==;
X-CSE-ConnectionGUID: pjexnr5TS8Sok4kh7b/pQA==
X-CSE-MsgGUID: jg+Fo0yUTWCrGHGQyJ0KlQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="33425205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:02:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:01:51 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 05:01:47 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <p.zabel@pengutronix.de>,
	<mihai.sain@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 0/9] Add support for sam9x7 SoC family
Date: Thu, 10 Oct 2024 17:31:42 +0530
Message-ID: <20241010120142.92057-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the new SoC family - sam9x7.
 - The device tree, configs and drivers are added
 - Clock driver for sam9x7 is added
 - Support for basic peripherals is added
 - Target board SAM9X75 Curiosity is added

 Changes in v8:
 --------------

 - Dropped patches that are applied from the series
 - Picked up Reviewed-by tags
 - Changed the node name from leds to led-controller in the board dts
   file.

 Changes in v7:
 --------------

 - Addressed all the review comments in the patches
 - Dropped patches that are applied from the series
 - Removed sfr node from the DT to add it later after creating the right
   DT documentation for microchip sfr IPs.
 - All the specific changes are captured in the corresponding patches

 Changes in v6:
 --------------

 - Addressed all the review comments in the patches
 - Picked up all Acked-by and Reviewed-by tags
 - Reverted the IRQ patch to that of version 3 of the same series
 - All the specific changes are captured in the corresponding patches

 Changes in v5:
 --------------

 - Addressed all the review comments in the patches
 - Picked up all Acked-by and Reviewed-by tags
 - Dropped applied patches from the series
 - Addressed the ABI breakage reported in the IRQ patch
 - All the specific changes are captured in the corresponding patches

 Changes in v4:
 --------------

 - Addressed all the review comments in the patches
 - Picked up all Acked-by and Reviewed-by tags
 - Dropped applied patches from the series
 - Added pwm node and related dt binding documentation
 - Added support for exporting some clocks to DT
 - Dropped USB related patches and changes. See NOTE.
 - All the specific changes are captured in the corresponding patches

 NOTE: Owing to the discussion here
 https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
 the USB related changes are dropped from this series in order to enable
 us to work on the mentioned issues before adding new compatibles as
 said. The issues/warnings will be addressed in subsequent patches.
 After which the USB related support for sam9x7 SoCs will be added. Hope
 this works out fine.

 Changes in v3:
 --------------

 - Fixed the DT documentation errors pointed out in v2.
 - Dropped Acked-by tag in tcb DT doc patch as it had to be adapted
   according to sam9x7 correctly.
 - Picked by the previously missed tags.
 - Dropped this patch "dt-bindings: usb: generic-ehci: Document clock-names
   property" as the warning was not found while validating DT-schema for
   at91-sam9x75_curiosity.dtb.
 - Dropped redundant words in the commit message.
 - Fixed the CHECK_DTBS warnings validated against
   at91-sam9x75_curiosity.dtb.
 - Renamed dt nodes according to naming convention.
 - Dropped unwanted status property in dts.
 - Removed nodes that are not in use from the board dts.
 - Removed spi DT doc patch from the series as it was already applied
   and a fix patch was applied subsequently. Added a patch to remove the
   compatible to adapt sam9x7.
 - Added sam9x7 compatibles in usb dt documentation.


 Changes in v2:
 --------------

 - Added sam9x7 specific compatibles in DT with fallbacks
 - Documented all the newly added DT compatible strings
 - Added device tree for the target board sam9x75 curiosity and
   documented the same in the DT bindings documentation
 - Removed the dt nodes that are not supported at the moment
 - Removed the configs added by previous version that are not supported
   at the moment
 - Fixed all the corrections in the commit message
 - Changed all the instances of copyright year to 2023
 - Added sam9x7 flag in PIT64B configuration
 - Moved macro definitions to header file
 - Added another divider in mck characteristics in the pmc driver
 - Fixed the memory leak in the pmc driver
 - Dropped patches that are no longer needed
 - Picked up Acked-by and Reviewed-by tags

Varshini Rajendran (9):
  dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
  power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
  power: reset: at91-reset: add reset support for sam9x7 SoC
  power: reset: at91-reset: add sdhwc support for sam9x7 SoC
  dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
  dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
  ARM: dts: at91: sam9x7: add device tree for SoC
  dt-bindings: arm: add sam9x75 curiosity board
  ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board

 .../devicetree/bindings/arm/atmel-at91.yaml   |    6 +
 .../devicetree/bindings/misc/atmel-ssc.txt    |    1 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |    3 +
 .../reset/atmel,at91sam9260-reset.yaml        |    4 +
 arch/arm/boot/dts/microchip/Makefile          |    3 +
 .../dts/microchip/at91-sam9x75_curiosity.dts  |  324 +++++
 arch/arm/boot/dts/microchip/sam9x7.dtsi       | 1220 +++++++++++++++++
 drivers/power/reset/Kconfig                   |    4 +-
 drivers/power/reset/at91-sama5d2_shdwc.c      |    1 +
 9 files changed, 1564 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
 create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi

-- 
2.25.1


