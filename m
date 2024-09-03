Return-Path: <linux-pm+bounces-13374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10B9693E1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32B51F2394C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFA1D47C0;
	Tue,  3 Sep 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EBE6AcDo"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C51CFEDF;
	Tue,  3 Sep 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345580; cv=none; b=X+p2FoxVX3qoc6Ee5KzZkMwBYaBGxRl4NwR4CVK7kLBhjY0u/AQAqJnAwL7WF819uDC178VKXuK5MnejE5fTq2/6QfPrPo146VgJBRPuDTEYWcLNSJqk4ByLix+prhR8UaDVBWZ7a4SmNOVolCOsiFziXlTmgYQ3yBIdBNtUtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345580; c=relaxed/simple;
	bh=4SqRJIg8jYQd0pSfB2LLNs8e3O6NF6oJJ6NvY1hkGK0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kh+cTK2onGfffmK5/lqGwRJY8qOPCBxtUZJi80GDAWvOK86M0R8lZnplyMxSZcrpN6/sU8WqpB3Qc9ke3me8hJ+chK/R/l2Lm+Y06bGTp4FjJXAEvlKVnvbSTr2ANlNXx3dPFHTIYF8pgu1qv4BvAG2P0YLzHL+dyH76KBai85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EBE6AcDo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345578; x=1756881578;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4SqRJIg8jYQd0pSfB2LLNs8e3O6NF6oJJ6NvY1hkGK0=;
  b=EBE6AcDopzwCSpFZ2e7hVx35OwllweLDUF/0Ol1X5jpChjKmY+pRNSkF
   17dtqQu7HhSpfvrBTOKtljOby1IhY0bl2NYxsosKFNgmHggcV3NLpF5Np
   Uhrf4+2OWq5mGGclg3wUDxJKIHkIv4LStcQc1A2ZFBsPK3Vzx16M94S6O
   JQxzK2NDJan3RLOxYyKdw7ci2EiIjQ8Ht3sQpR2HtFmQyNlIqBmBBGKc+
   cU/nKRwx9QmnHBoKoHzQ3/4JpUEZZTahNeFH0lOP1d94Qb7futl35Sk46
   epoayyuCy3eGInE1zssJbcLG7PeEMEbydVncUL+PwD1q5btVhehYwfHIC
   Q==;
X-CSE-ConnectionGUID: cAIdmXlZT4Gz2m+I3JY7bA==
X-CSE-MsgGUID: IQhJA+S8R3KKdEqXOXJYng==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31149906"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:39:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:39:20 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:39:15 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tglx@linutronix.de>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>, <mihai.sain@microchip.com>,
	<varshini.rajendran@microchip.com>, <andrei.simion@microchip.com>,
	<dharma.b@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH v7 00/12] Add support for sam9x7 SoC family
Date: Tue, 3 Sep 2024 12:09:13 +0530
Message-ID: <20240903063913.48307-1-varshini.rajendran@microchip.com>
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

Hari Prasath (1):
  irqchip/atmel-aic5: Add support for sam9x7 aic

Varshini Rajendran (11):
  dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
  dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x7 compatible
  dt-bindings: interrupt-controller: Add support for sam9x7 aic
  power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
  power: reset: at91-reset: add reset support for sam9x7 SoC
  power: reset: at91-reset: add sdhwc support for sam9x7 SoC
  dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
  dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
  ARM: dts: at91: sam9x7: add device tree for SoC
  dt-bindings: arm: add sam9x75 curiosity board
  ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board

 .../devicetree/bindings/arm/atmel-at91.yaml   |    6 +
 .../interrupt-controller/atmel,aic.yaml       |    1 +
 .../devicetree/bindings/misc/atmel-ssc.txt    |    1 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |    3 +
 .../reset/atmel,at91sam9260-reset.yaml        |    4 +
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   |   20 +-
 arch/arm/boot/dts/microchip/Makefile          |    3 +
 .../dts/microchip/at91-sam9x75_curiosity.dts  |  324 +++++
 arch/arm/boot/dts/microchip/sam9x7.dtsi       | 1220 +++++++++++++++++
 drivers/irqchip/irq-atmel-aic5.c              |    9 +
 drivers/power/reset/Kconfig                   |    4 +-
 drivers/power/reset/at91-sama5d2_shdwc.c      |    1 +
 12 files changed, 1587 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
 create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi

-- 
2.25.1


