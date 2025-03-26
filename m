Return-Path: <linux-pm+bounces-24514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821AA71A81
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13798188BA17
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232921F2369;
	Wed, 26 Mar 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JQ8i3ak+"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EA1624D2;
	Wed, 26 Mar 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003397; cv=none; b=nxMZXK96dHNbWjPVArwU/8C+UmPR8+5mZKmKOvffokvcO2XTquXP4hrQPCgbVlRutJdhiDRLRKbzdpV/a0CG6f3tjtILMjP7YxAdZgpFj5C9Um0ZH3WSQti2hK0RPPdfWYGMaIG9rzd7lM/oWPCKxCbzMdtIMgp7s2vzrykyo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003397; c=relaxed/simple;
	bh=336TRgbLvYKh+AeFJ4NUZBlcZovnPjauRJIcAFMcWLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K4dfBoRdKfIcIQfWV1qedaMIN+iY6kn/NLqJB5BC311rfnr/ENqWMtraZzjfjh+ouwjnK9MhTgnlQW9B58PabwnvaxO1nqbvqmnr9hPU75sbHw+rU/RCyhRWvmCVYiTyE5CltnCOBDuKuFVdOzjM37rMl96TT0hB9mrePKNxKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JQ8i3ak+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003395; x=1774539395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=336TRgbLvYKh+AeFJ4NUZBlcZovnPjauRJIcAFMcWLk=;
  b=JQ8i3ak+4gVP4OzSIn5VlUhsnT2/uKPCpk4t0F8j/bpVm9rkN85pdMUW
   av3cTkLiKkwucsxxuoJx3YLXVxzfUFBv1RywJE3BUxJHeZndrMcDOIxhb
   O15P5guDWHS2Z87fHC2HI4vJyZWm66sA5d7kC3/MGFXJQmnQhYljiHuit
   mkGUFuR6xliw+aG/s1j+F+9J+jZnLMVl/5hhw7d8CqG+/6b9nJV8sNTyc
   SOL85VJM0tIJMkr6G+9N3TmO6hZWRO5/LwQASrJFAg9J96DQ6wljvN++d
   tUIh2AVZbojL9vFjEgohelHZ4O74whOIEEMLfa/8rWU0O31ju4K8NjkCd
   Q==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: vHwFJPuuR/W4/UZnO2jmAw==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096094"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:50 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:50 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 00/11] Enable Power Modes Support for SAMA7D65 SoC
Date: Wed, 26 Mar 2025 08:35:33 -0700
Message-ID: <cover.1742936082.git.Ryan.Wanner@microchip.com>
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

v1) https://lore.kernel.org/linux-arm-kernel/cover.1738257860.git.Ryan.Wanner@microchip.com/
v2) https://lore.kernel.org/linux-arm-kernel/cover.1739221064.git.Ryan.Wanner@microchip.com/
v3) https://lore.kernel.org/linux-arm-kernel/cover.1740671156.git.Ryan.Wanner@microchip.com/T/#m576233e7af84d68559afb286884c2b9294e7bc1d 

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


