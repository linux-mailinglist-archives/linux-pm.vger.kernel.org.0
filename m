Return-Path: <linux-pm+bounces-25404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC139A88DEE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579D31897328
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8481F30DD;
	Mon, 14 Apr 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iIpB0zL6"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8F1CAA6D;
	Mon, 14 Apr 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666923; cv=none; b=Y/vXHSCxSc1x7nVdQB/sJXbjidI91dOdu/J2Xz4rlldp5BmS8aVEOeLzeOGJdrRGLoDJmjLwFxLH1SqSTV9hrGPwdjry14S8sQ3ygkmFvG1xTYif0jl+GXt64dLHjum9zaKY10D9m7EIGKjzCBBBnB9148Xj1K07kfDRmF+Mqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666923; c=relaxed/simple;
	bh=tLt2eP72kLFIOGeY1xWW7M7uOV9URzcP5sXZZ5GRu38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pM1jZLKfI1EVqaV7gOO+xnB9Jf81WJNdyPuER5FBdyVGIUK6vzzmXrGStKS6N8i9u1TO58DrAH9mHSo9Z9ivZOBdJFgpQxFu85gvlbi6XkzQPKtNOwYhYNzrPfVewzyBCBT0dOTp2AGzipcNk9jM0wxgMSeLwTo7ZfsZNwKgBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iIpB0zL6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666921; x=1776202921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tLt2eP72kLFIOGeY1xWW7M7uOV9URzcP5sXZZ5GRu38=;
  b=iIpB0zL6XlV4gaiF/FjqRuntcSvesXqA0XN4maYaEMFM3rAWaqqr/MzH
   7TIs/B0JpmmdfSgKwsr0s4E6bXJnDydI/K5DlyED8hE/PaXaOjq/tmeKJ
   HQqJ+6rnov5DJAY3PzzLQRbF8ba1CSk1za60G9yu+k/DwP4FS2WWRp4jc
   URuCqeqrF0SUPoPmu+yE6tR4LqMmczO2bdu/M6Yyx6Qg+voWmxJoHtJkv
   VBZO1LxTj+pmmB5zaIKReb2i+OlJwsCyTIScf+XI8s1rgDGA6rG1axFm2
   RebhIYUlvESljA5Wl3YwpHfjs/qyI0g9Qd/ZzESQeF8sw2WJU7SLnhWJl
   g==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: nFPUg5ewTjG1kq33dFZTtQ==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006664"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 14:41:04 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 14:41:04 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v5 00/11] Enable Power Modes Support for SAMA7D65 SoC
Date: Mon, 14 Apr 2025 14:41:17 -0700
Message-ID: <cover.1744666011.git.Ryan.Wanner@microchip.com>
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

Changes from v3 -> v4:
- Add sama7d65-gpbr to the dt-binding.
- Converted the sama5d2-secumod binding into yaml format.
- Add sama7d65-secumod to the new dt binding.
- Collect and remove applied and accpeted pathces from the set.

Changes from v4 -> v5:
- Use generic naming for dt-binding yaml example.
- Adjust DTSI SECUMOD node to match generic naming.
- Collect Acked and Reviewed tags. 

v1) https://lore.kernel.org/linux-arm-kernel/cover.1738257860.git.Ryan.Wanner@microchip.com/
v2) https://lore.kernel.org/linux-arm-kernel/cover.1739221064.git.Ryan.Wanner@microchip.com/
v3) https://lore.kernel.org/linux-arm-kernel/cover.1740671156.git.Ryan.Wanner@microchip.com/T/#m576233e7af84d68559afb286884c2b9294e7bc1d 
v4) https://lore.kernel.org/linux-arm-kernel/cover.1742936082.git.Ryan.Wanner@microchip.com/

Ryan Wanner (11):
  dt-bindings: sram: Add microchip,sama7d65-sram
  dt-bindings: power: reset: atmel,sama5d2-shdwc: Add
    microchip,sama7d65-shdwc
  dt-bindings: reset: atmel,at91sam9260-reset: add
    microchip,sama7d65-rstc
  dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
  dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
  dt-bindings: mfd: atmel: Add microchip,sama7d65-gpbr
  dt-bindings: mfd: syscon: atmel,sama5d2-secumod: convert to yaml
  dt-bindings: mfd: syscon: add microchip,sama7d65-secumod
  ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
  ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65
    SoC
  ARM: dts: microchip: sama7d65: Add RTT timer to curiosity board

 .../bindings/arm/atmel,sama5d2-secumod.yaml   | 49 +++++++++++++++++++
 .../devicetree/bindings/arm/atmel-sysregs.txt | 25 ----------
 .../bindings/mfd/atmel,at91sam9260-gpbr.yaml  |  1 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |  5 ++
 .../reset/atmel,at91sam9260-reset.yaml        |  3 ++
 .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |  4 +-
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |  1 +
 .../devicetree/bindings/sram/sram.yaml        |  1 +
 .../dts/microchip/at91-sama7d65_curiosity.dts |  4 ++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 47 ++++++++++++++++++
 10 files changed, 114 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml

-- 
2.43.0


