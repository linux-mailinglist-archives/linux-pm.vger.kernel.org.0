Return-Path: <linux-pm+bounces-25484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDAA8A512
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AC33B81DB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEA2192EF;
	Tue, 15 Apr 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP85qR6b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426021883C;
	Tue, 15 Apr 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737103; cv=none; b=nPr4ym0IU8ZcC6xKY1y+s82e8tYApmyGOk087NyObep83yXl2pBOUdwgepjpQi0/Yog/m7NlmkMagnKhVWItjwjdZgaWFyJRU++D5TFIZRM2idtD+W9NrwyGvSBFjToMjNqj191t9jUJbdtvrP1TwHkG5gSb3cs7pF4IGswANx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737103; c=relaxed/simple;
	bh=bX3HlicaR5g9IQkWktPKTPPgxg/GT1DUALZhUDDxksQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lITVFEZ2hf1+gG/LdmHUayfmAdVz0cNa6svNDVw9/d1wYjwfz1MhRDNGzZqropcCDTQkBXddSZCC2m67MMvIk5KHnsm1rY2HjIjMXY3LaVcdU+5YWvB7eZTzWI8pVHu3vqBI2bocsRhS7h+AuoYJCnjlWJH1M+wWIJR7rsY7jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP85qR6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4368AC4CEE9;
	Tue, 15 Apr 2025 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744737102;
	bh=bX3HlicaR5g9IQkWktPKTPPgxg/GT1DUALZhUDDxksQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IP85qR6bV4L3UG0faBuQ49erg90k/sWL9aUpz1KIaYIwzgy4fFx3RwsRnRgaMWE0m
	 hGFVDqDUJjUwDDN7lCB7mrtF68mDZkkYqPvHojepnb3crZXbW9flRJkXBd/AMQ3ryB
	 +GAdxi6ubLdQz/wmUsueTYvoug8FfiWLI1eOJdPivkyMRkD4PBeuz85+GbmWNXNNDL
	 GjFUXg9DBkqstMFdkJ43UZ042/UPntgyRExtbXAg2IV6cfIP8MphsHu3tLR1RkN/y0
	 7VTTlyFDtRLLXddVyvHjukOEZX9qTGZNHVSUbJS4x7LnHCvJt5X/69cM0dZwKgW0CY
	 QAmSiHJQiWi0w==
Date: Tue, 15 Apr 2025 12:11:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: p.zabel@pengutronix.de, claudiu.beznea@tuxon.dev, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 sre@kernel.org, linux-pm@vger.kernel.org, krzk+dt@kernel.org, 
 lee@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 conor+dt@kernel.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
Message-Id: <174473699521.763781.11057126533938200198.robh@kernel.org>
Subject: Re: [PATCH v5 00/11] Enable Power Modes Support for SAMA7D65 SoC


On Mon, 14 Apr 2025 14:41:17 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for low power modes for the SAMA7D65 SoC and
> the required components and changes for low power modes.
> 
> The series includes changes in the asm code to account for the addtional
> clocks that are in this SoC.
> 
> The Device tree additions are to enable all the components needed to
> keep the SoC in low power mode.
> 
> There are some DTB check warnings but that is due to the dt-binding not
> in the correct .yaml file format.
> 
> Changes v1 -> v2:
> - Add missing compatible for ddr3phy, it is now in both syscon sets.
> - Fix alphabetical ordering for sama7d65.
> - Remove the incorrect reorganizing patch.
> - Remove sama7g5-rtt as a compatible for sama7d65-rtt and add
>   sama7d65-rtt as a compatible wake up source in the pm driver.
> 
> Changes from v2 -> v3:
> - Correct mistake in v2 sfrbu dt-binding patch.
> - Correct incorrect dt-binding addition and formatting for rtc and rtt bindings.
> - Add missing SoB tag.
> - Cleaned up commit message for Backup mode to describe SHDWC is status
>   register is cleared for this SoC.
> - Cleaned up variable naming and usage for mcks. Changed the mcks number
>   to the correct number of clocks needed to be saved and corrected the
>   ASM code accordingly.
> - Removed the SHDWC from ULP0 wake-up source as it is not configured as
>   a valid wake-up source for ULP0.
> - Separated all the DTSI and DTS changes into individual patches.
> 
> Changes from v3 -> v4:
> - Add sama7d65-gpbr to the dt-binding.
> - Converted the sama5d2-secumod binding into yaml format.
> - Add sama7d65-secumod to the new dt binding.
> - Collect and remove applied and accpeted pathces from the set.
> 
> Changes from v4 -> v5:
> - Use generic naming for dt-binding yaml example.
> - Adjust DTSI SECUMOD node to match generic naming.
> - Collect Acked and Reviewed tags.
> 
> v1) https://lore.kernel.org/linux-arm-kernel/cover.1738257860.git.Ryan.Wanner@microchip.com/
> v2) https://lore.kernel.org/linux-arm-kernel/cover.1739221064.git.Ryan.Wanner@microchip.com/
> v3) https://lore.kernel.org/linux-arm-kernel/cover.1740671156.git.Ryan.Wanner@microchip.com/T/#m576233e7af84d68559afb286884c2b9294e7bc1d
> v4) https://lore.kernel.org/linux-arm-kernel/cover.1742936082.git.Ryan.Wanner@microchip.com/
> 
> Ryan Wanner (11):
>   dt-bindings: sram: Add microchip,sama7d65-sram
>   dt-bindings: power: reset: atmel,sama5d2-shdwc: Add
>     microchip,sama7d65-shdwc
>   dt-bindings: reset: atmel,at91sam9260-reset: add
>     microchip,sama7d65-rstc
>   dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
>   dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
>   dt-bindings: mfd: atmel: Add microchip,sama7d65-gpbr
>   dt-bindings: mfd: syscon: atmel,sama5d2-secumod: convert to yaml
>   dt-bindings: mfd: syscon: add microchip,sama7d65-secumod
>   ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
>   ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65
>     SoC
>   ARM: dts: microchip: sama7d65: Add RTT timer to curiosity board
> 
>  .../bindings/arm/atmel,sama5d2-secumod.yaml   | 49 +++++++++++++++++++
>  .../devicetree/bindings/arm/atmel-sysregs.txt | 25 ----------
>  .../bindings/mfd/atmel,at91sam9260-gpbr.yaml  |  1 +
>  .../power/reset/atmel,sama5d2-shdwc.yaml      |  5 ++
>  .../reset/atmel,at91sam9260-reset.yaml        |  3 ++
>  .../bindings/rtc/atmel,at91rm9200-rtc.yaml    |  4 +-
>  .../bindings/rtc/atmel,at91sam9260-rtt.yaml   |  1 +
>  .../devicetree/bindings/sram/sram.yaml        |  1 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |  4 ++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 47 ++++++++++++++++++
>  10 files changed, 114 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.15-rc1-45-g43e9076a00b1 (best guess, 7/9 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for cover.1744666011.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/uddrc@e3800000: failed to match any schema with compatible: ['microchip,sama7d65-uddrc', 'microchip,sama7g5-uddrc']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/uddrc@e3800000: failed to match any schema with compatible: ['microchip,sama7d65-uddrc', 'microchip,sama7g5-uddrc']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000 (microchip,sama7d65-ddr3phy): compatible: ['microchip,sama7d65-ddr3phy', 'microchip,sama7g5-ddr3phy'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000 (microchip,sama7d65-ddr3phy): compatible:1: 'syscon' was expected
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: ddr3phy@e3804000 (microchip,sama7d65-ddr3phy): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#






